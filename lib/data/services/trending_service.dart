import '../models/movie_collection_model.dart';
import '../services/api_service.dart';

class TrendingService {
  static Future<MovieCollection> getHighlights(String category) async {
    try {
      return await ApiService.fetchData(
          'trending/$category/day', (json) => MovieCollection.fromJson(json));
    } catch (e) {
      return MovieCollection(
          page: 1, movies: [], totalPages: 0, totalMovies: 0);
    }
  }
}
