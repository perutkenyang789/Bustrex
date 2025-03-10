import 'package:bustrex/data/models/movie_collection_model.dart';
import '../services/api_service.dart';

class MovieRecommendationService {
  static Future<MovieCollection?> getMovieRecommendation(int id) async {
    try {
      return await ApiService.fetchData<MovieCollection>(
        'movie/$id/recommendations',
        (json) => MovieCollection.fromJson(json),
      );
    } catch (e) {
      return null;
    }
  }
}
