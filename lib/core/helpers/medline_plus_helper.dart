import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class MedlinePlusHelper {

  //busca resultados a consultas de salud y enfermedades
  static Future<List<Map<String, dynamic>>> searchMedlinePlus(
      String term) async {
    final url =
        'https://wsearch.nlm.nih.gov/ws/query?db=healthTopicsSpanish&term=$term';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = xml.parse(response.body);
      final List<xml.XmlElement> documents =
          data.findAllElements('document').toList();

      List<Map<String, dynamic>> results = [];
      for (var document in documents) {
        results.add({
          'title': document
              .findElements('content')
              .firstWhere((e) => e.getAttribute('name') == 'title')
              .text,
          'url': document.getAttribute('url'),
          'summary': document
              .findElements('content')
              .firstWhere((e) => e.getAttribute('name') == 'FullSummary')
              .text,
        });
      }
      return results;
    } else {
      throw Exception('Failed to load search results');
    }
  }
}

