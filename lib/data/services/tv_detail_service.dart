import '../models/tv_detail_model.dart';
import '../services/api_service.dart';

class TvDetailService {
  static Future<TvDetail?> getTvDetail(int id) async {
    try {
      return await ApiService.fetchData<TvDetail>(
        'tv/$id',
        (json) => TvDetail.fromJson(json),
      );
    } catch (e) {
      return null;
    }
  }
}
