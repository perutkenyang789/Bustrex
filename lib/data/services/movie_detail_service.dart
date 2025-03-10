import '../models/movie_detail_model.dart';
import '../services/api_service.dart';

class MovieDetailService {
  static Future<MovieDetail?> getMovieDetail(int id) async {
    try {
      return await ApiService.fetchData<MovieDetail>(
        'movie/$id',
        (json) => MovieDetail.fromJson(json),
      );
    } catch (e) {
      return null;
    }
  }
}
