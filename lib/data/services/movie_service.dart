import '../models/movie_collection_model.dart';
import '../services/api_service.dart';

class MovieService {
  static Future<MovieCollection> getMovies(String category) async {
    try {
      return await ApiService.fetchData(
        'movie/$category',
        (json) => MovieCollection.fromJson(json),
      );
    } catch (e) {
      return MovieCollection(
          page: 1, movies: [], totalPages: 0, totalMovies: 0);
    }
  }
}
