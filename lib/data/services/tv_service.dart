import '../models/tv_collection_model.dart';
import '../services/api_service.dart';

class TvService {
  static Future<TvCollection> getTvs(String category) async {
    try {
      return await ApiService.fetchData(
        'tv/$category',
        (json) => TvCollection.fromJson(json),
      );
    } catch (e) {
      return TvCollection(page: 1, series: [], totalPages: 0, totalSeries: 0);
    }
  }
}
