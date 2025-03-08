import 'dart:convert';
import 'movie_preview_model.dart';

MovieCollection movieCollectionFromJson(String str) =>
    MovieCollection.fromJson(json.decode(str));

String movieCollectionToJson(MovieCollection data) =>
    json.encode(data.toJson());

class MovieCollection {
  int page;
  List<MoviePreview> movies;
  int totalPages;
  int totalMovies;

  MovieCollection({
    required this.page,
    required this.movies,
    required this.totalPages,
    required this.totalMovies,
  });

  factory MovieCollection.fromJson(Map<String, dynamic> json) =>
      MovieCollection(
        page: json["page"],
        movies: List<MoviePreview>.from(
            json["results"].map((x) => MoviePreview.fromJson(x))),
        totalPages: json["total_pages"],
        totalMovies: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "movies": List<dynamic>.from(movies.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_movies": totalMovies,
      };
}
