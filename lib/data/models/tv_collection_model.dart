import 'dart:convert';
import 'tv_preview_model.dart';

TvCollection tvCollectionFromJson(String str) =>
    TvCollection.fromJson(json.decode(str));

String tvCollectionToJson(TvCollection data) => json.encode(data.toJson());

class TvCollection {
  int page;
  List<TvPreview> series;
  int totalPages;
  int totalSeries;

  TvCollection({
    required this.page,
    required this.series,
    required this.totalPages,
    required this.totalSeries,
  });

  factory TvCollection.fromJson(Map<String, dynamic> json) => TvCollection(
        page: json["page"],
        series: List<TvPreview>.from(
            json["TvPreviews"].map((x) => TvPreview.fromJson(x))),
        totalPages: json["total_pages"],
        totalSeries: json["total_TvPreviews"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "series": List<dynamic>.from(series.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_TvPreviews": totalSeries,
      };
}
