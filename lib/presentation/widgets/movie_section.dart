import 'package:flutter/material.dart';
import '../../data/models/movie_collection_model.dart';
import '../widgets/movie_card.dart';

class MovieSection extends StatelessWidget {
  final String title;
  final Future<MovieCollection>? collection;
  final double height;

  const MovieSection({
    super.key,
    required this.title,
    required this.collection,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: height,
          child: FutureBuilder<MovieCollection>(
            future: collection,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.movies.isEmpty) {
                return const Center(child: Text('No movies available.'));
              }

              final movies = snapshot.data!.movies;

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: MovieCard(
                      movie: movies[index],
                      height: height,
                      aspectRatio: 2 / 3, // Maintain proper poster ratio
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
