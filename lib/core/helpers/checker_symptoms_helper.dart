import 'dart:convert';
import 'package:http/http.dart' as http;

class CheckerSymptomsHelper {
  static final String apiKey =
      '9ec9fc7a86msh81cee81c8515890p1af4bajsn77b2527ff47f';
  static final String apiHost = 'symptom-checker4.p.rapidapi.com';
  static final String apiUrl =
      'https://symptom-checker4.p.rapidapi.com/analyze';

  static Future<Map<String, dynamic>?> analyzeSymptoms(String symptoms) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'X-RapidAPI-Key': apiKey,
          'X-RapidAPI-Host': apiHost,
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'symptoms': symptoms}),
      );

      if (response.statusCode == 200) {
        // Parsea la respuesta JSON
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        // Extrae los campos relevantes
        final List<String> potentialCauses =
            List<String>.from(responseBody['potentialCauses']);
        final List<String> followupQuestions =
            List<String>.from(responseBody['followupQuestions']);

        // Retorna un mapa con los datos procesados
        return {
          'potentialCauses': potentialCauses,
          'followupQuestions': followupQuestions,
        };
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      print('Error: $error');
      throw error;
    }
  }
}
