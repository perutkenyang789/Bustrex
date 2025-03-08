import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static final String _apiKey = dotenv.env['TMDB_API_KEY']!;
  static const String _baseUrl = "https://api.themoviedb.org/3";

  static Future<Map<String, dynamic>> fetchData(String endpoint) async {
    final url = Uri.parse("$_baseUrl/$endpoint?api_key=$_apiKey");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Error fetching data: $error");
    }
  }
}
