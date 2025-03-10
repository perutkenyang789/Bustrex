import 'package:flutter/material.dart';
import '../../data/models/movie_preview_model.dart';

class MovieCard extends StatelessWidget {
  final MoviePreview movie;
  final double? height;
  final double aspectRatio;

  const MovieCard({
    super.key,
    required this.movie,
    this.height,
    this.aspectRatio = 2 / 3, // Default poster aspect ratio
  });

  @override
  Widget build(BuildContext context) {
    final double cardHeight = height ?? 300;
    final double cardWidth = cardHeight * aspectRatio;
    final theme = Theme.of(context);
    final String backdropPath = movie.backdropPath ?? '';

    return Container(
      height: cardHeight,
      width: cardWidth,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.surface.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Movie Poster
          backdropPath.isNotEmpty
              ? Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  width: cardWidth,
                  height: cardHeight,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: cardWidth,
                    height: cardHeight,
                    color: Colors.grey,
                    child:
                        const Center(child: Icon(Icons.broken_image, size: 50)),
                  ),
                )
              : Container(color: Colors.black),

          // Gradient Overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: cardHeight * 0.6,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    theme.colorScheme.surface.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ),

          // Text Container
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '⭐ ${movie.voteAverage.toInt()} (${movie.voteCount})',
                    style: theme.textTheme.labelSmall,
                  ),

                  // Movie Title
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
