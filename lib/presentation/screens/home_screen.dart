import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../data/services/movie_detail_service.dart';
import '../../data/services/movie_reccomendation_service.dart';
import '../../data/services/movie_service.dart';
import '../../data/services/trending_service.dart';
import '../../data/models/movie_collection_model.dart';
import '../widgets/movie_card.dart';
import '../widgets/appbar.dart';
import '../widgets/movie_section.dart';
import 'movie_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  Future<MovieCollection>? trendingCollection;
  Future<MovieCollection>? nowPlayingCollection;
  Future<MovieCollection>? popularCollection;
  Future<MovieCollection>? topRatedCollection;
  Future<MovieCollection>? upcomingCollection;

  final double highlightCardHeight = 400;
  final double normalCardHeight = 200;

  @override
  void initState() {
    super.initState();
    trendingCollection = TrendingService.getHighlights("movie");
    nowPlayingCollection = MovieService.getMovies("now_playing");
    popularCollection = MovieService.getMovies("popular");
    topRatedCollection = MovieService.getMovies("top_rated");
    upcomingCollection = MovieService.getMovies("upcoming");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BustrexAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured Carousel
            FutureBuilder<MovieCollection>(
              future: trendingCollection,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: highlightCardHeight,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.movies.isEmpty) {
                  return const Center(child: Text('No movies available.'));
                }

                final movies = snapshot.data!.movies;

                return Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  child: CarouselSlider.builder(
                    itemCount: movies.length,
                    options: CarouselOptions(
                      height: highlightCardHeight,
                      aspectRatio: 2 / 3,
                      viewportFraction: 0.6,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 4),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                    ),
                    itemBuilder: (context, index, realIndex) {
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
                          height: highlightCardHeight,
                          aspectRatio: 2 / 3,
                        ),
                      );
                    },
                  ),
                );
              },
            ),

            // Other Movie Collections
            MovieSection(
                title: 'NOW PLAYING',
                collection: nowPlayingCollection,
                height: normalCardHeight),
            MovieSection(
                title: 'TOP RATED',
                collection: topRatedCollection,
                height: normalCardHeight),
            MovieSection(
                title: 'POPULAR',
                collection: popularCollection,
                height: normalCardHeight),
            MovieSection(
                title: 'UPCOMING',
                collection: upcomingCollection,
                height: normalCardHeight),

            // Add some padding at the bottom for better scrolling
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
