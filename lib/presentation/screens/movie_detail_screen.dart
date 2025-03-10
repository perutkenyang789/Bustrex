import 'package:flutter/material.dart';
import 'package:bustrex/data/models/movie_detail_model.dart';
import 'package:bustrex/core/constants.dart';
import '../../data/models/movie_collection_model.dart';
import '../../data/services/movie_detail_service.dart';
import '../../data/services/movie_reccomendation_service.dart';
import '../widgets/movie_card.dart';

class MovieDetailPage extends StatefulWidget {
  final Future<MovieDetail?> movie;
  final Future<MovieCollection?> recommendedMovies;

  const MovieDetailPage(
      {super.key, required this.movie, required this.recommendedMovies});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: FutureBuilder<MovieDetail?>(
        future: widget.movie,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}',
                    style: theme.textTheme.bodyLarge));
          } else if (!snapshot.hasData) {
            return Center(
                child: Text("Movie details not available.",
                    style: theme.textTheme.bodyLarge));
          }

          final movie = snapshot.data!;

          return CustomScrollView(
            slivers: [
              _buildAppBar(context, movie),
              SliverToBoxAdapter(child: _buildBody(context, movie)),
              SliverToBoxAdapter(child: _buildRecommendedMovies(context)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, MovieDetail movie) {
    final theme = Theme.of(context);

    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              '$imageBaseUrl${movie.backdropPath}',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: theme.colorScheme.primary),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 120,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        '$imageBaseUrl${movie.posterPath}',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(color: theme.colorScheme.primary),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(movie.title, style: theme.textTheme.displayLarge),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.star,
                                color: theme.colorScheme.secondary, size: 16),
                            const SizedBox(width: 4),
                            Text(movie.voteAverage.toStringAsFixed(1),
                                style: theme.textTheme.labelSmall),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: theme.colorScheme.surface,
    );
  }

  Widget _buildBody(BuildContext context, MovieDetail movie) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('SYNOPSIS', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(movie.overview, style: theme.textTheme.bodyLarge),
        ],
      ),
    );
  }

  Widget _buildRecommendedMovies(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder<MovieCollection?>(
      future: widget.recommendedMovies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Error: ${snapshot.error}',
                  style: theme.textTheme.bodyLarge));
        } else if (!snapshot.hasData || snapshot.data!.movies.isEmpty) {
          return Center(
              child: Text("No recommended movies available.",
                  style: theme.textTheme.bodyLarge));
        }

        final movies = snapshot.data!.movies;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Recommended Movies', style: theme.textTheme.titleLarge),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailPage(
                            movie: MovieDetailService.getMovieDetail(
                                movies[index].id),
                            recommendedMovies: MovieRecommendationService
                                .getMovieRecommendation(movies[index].id),
                          ),
                        ),
                      );
                    },
                    child: MovieCard(
                      movie: movies[index],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
