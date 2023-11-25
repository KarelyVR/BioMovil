import 'package:http/http.dart' as http;
import 'dart:convert';

class APICoyote {
  Future<Map<String, dynamic>> fetchCoyoteData() async {
    String name = 'coyote'; // Cambia el nombre del animal según tu API
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
            'error': 'No se encontró información para el coyote',
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