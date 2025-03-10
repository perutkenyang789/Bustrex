import 'package:bustrex/data/models/movie_collection_model.dart';
import '../services/api_service.dart';

class MovieRecommendationService {
  static Future<MovieCollection?> getMovieRecommendation(int id) async {
    try {
      print("Fetching recommendations for movie ID: $id"); // Debugging line

      final response = await ApiService.fetchData<MovieCollection>(
        'movie/$id/recommendations',
        (json) => MovieCollection.fromJson(json),
      );

      print("Response: $response"); // Debugging line
      return response;
    } catch (e) {
      print("Error fetching recommendations: $e");
      return null;
    }
  }
}
