import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:mi_bienestar_uc/models/diagnosis.dart';
import 'package:mi_bienestar_uc/models/symptom.dart';

const String _apiKey = 'richardrnmr@gmail.com';
const String _secretKey = 'y6S5CpWc9z3QGd2k4';
const String _language = 'es';

class ApiMedic {
  static Future<String?> getToken() async {
    // Define la URL y las credenciales
    final String url = 'https://sandbox-authservice.priaid.ch/login';
    final String apiKey = 'richardrnmr@gmail.com';
    final String secretKey = 'y6S5CpWc9z3QGd2k4';

    // Calcula el hash HMAC-MD5
    String uri = 'https://sandbox-authservice.priaid.ch/login';
    String hashedCredentials = _hmacMd5(secretKey, uri);
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $apiKey:$hashedCredentials',
      },
    );

    // Verifica si la solicitud fue exitosa
    if (response.statusCode == 200) {
      // Extrae el token del cuerpo de la respuesta
      Map<String, dynamic> data = json.decode(response.body);
      return data['Token'];
    } else {
      print('Error: ${response.body}');
      return null;
    }
  }

  static String _hmacMd5(String key, String message) {
    var bytesKey = utf8.encode(key);
    var bytesMessage = utf8.encode(message);
    var hmacSha256 = Hmac(md5, bytesKey);
    var digest = hmacSha256.convert(bytesMessage);
    return base64Encode(digest.bytes);
  }

  static Future<List<Symptom>> fetchSymptoms(
      String token, String language) async {
    final baseUrl = 'https://sandbox-healthservice.priaid.ch/symptoms';
    final queryParams = {
      'token': token,
      'language': language,
    };
    final uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((e) => Symptom.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load symptoms, ${response.body}');
    }
  }

  static Future<List<Diagnosis>> fetchDiagnosis(String token,
      List<Symptom> symptoms, String gender, int yearOfBirth) async {
    // Mapea la lista de síntomas a una lista de IDs
    final List<int> symptomIds = symptoms.map((symptom) => symptom.id).toList();
    final Uri uri = Uri.https('sandbox-healthservice.priaid.ch', '/diagnosis', {
      'token': token,
      'symptoms': jsonEncode(symptomIds),
      'gender': gender,
      'year_of_birth': yearOfBirth.toString(),
      'language': 'es-es',
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Diagnosis.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load diagnosis, ${response.body}');
    }
  }
}
