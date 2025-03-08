import '../models/movie_collection_model.dart';
import 'api_service.dart';

class MovieService {
  static Future<MovieCollection> fetchMovies(String category) async {
    final data = await ApiService.fetchData("movie/$category");
    return MovieCollection.fromJson(data);
  }
}
