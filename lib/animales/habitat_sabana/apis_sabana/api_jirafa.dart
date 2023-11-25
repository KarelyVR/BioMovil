import 'package:http/http.dart' as http;
import 'dart:convert';

class APIJirafa {
  Future<Map<String, dynamic>> fetchJirafaData() async {
    String name = 'giraffe'; // Cambia el nombre del animal según tu API
    String apiKey = 'AmoVOB2sD+OTVOzKLiEGtA==wRuv9HSRzQ9zBlnb';
    String apiUrl = 'https://api.api-ninjas.com/v1/animals?name=$name';

    try {
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {'X-Api-Key': apiKey},
      );

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        if (decodedResponse is List && decodedResponse.isNotEmpty) {
          return decodedResponse[0];
        } else {
          return {
            'error': 'No se encontró información para la jirafa',
          };
        }
      } else {
        return {
          'error': 'Error: ${response.statusCode} ${response.body}',
        };
      }
    } catch (e) {
      return {
        'error': 'Error: $e',
      };
    }
  }
}
