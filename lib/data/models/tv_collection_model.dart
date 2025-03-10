import 'dart:convert';
import 'tv_preview_model.dart';

TvCollection tvCollectionFromJson(String str) =>
    TvCollection.fromJson(json.decode(str));

String tvCollectionToJson(TvCollection data) => json.encode(data.toJson());

class TvCollection {
  int page;
  List<Result> results;
  int totalPages;
  int totalSeries;

  TvCollection({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalSeries,
  });

  factory TvCollection.fromJson(Map<String, dynamic> json) => TvCollection(
        page: json["page"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"],
        totalSeries: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalSeries,
      };
}
