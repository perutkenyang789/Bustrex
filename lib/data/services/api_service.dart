import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = "https://api.themoviedb.org/3";
  static final String _apiKey = dotenv.env['TMDB_API_KEY'] ?? '';

  /// Generic method to fetch data and deserialize it into the given model.
  static Future<T> fetchData<T>(
      String endpoint, T Function(Map<String, dynamic>) fromJson) async {
    final uri = Uri.parse('$_baseUrl/$endpoint?api_key=$_apiKey');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return fromJson(jsonData);
      } else {
        throw Exception(
            "Error ${response.statusCode}: ${response.reasonPhrase}");
      }
    } catch (e) {
      throw Exception("Failed to fetch data: $e");
    }
  }
}
