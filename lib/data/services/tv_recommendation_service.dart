import 'package:bustrex/data/models/Tv_collection_model.dart';
import '../services/api_service.dart';

class TvRecommendationService {
  static Future<TvCollection?> getTvRecommendation(int id) async {
    try {
      return await ApiService.fetchData<TvCollection>(
        'tv/$id/recommendations',
        (json) => TvCollection.fromJson(json),
      );
    } catch (e) {
      return null;
    }
  }
}
