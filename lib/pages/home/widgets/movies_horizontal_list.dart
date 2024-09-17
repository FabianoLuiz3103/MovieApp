import 'package:flutter/material.dart';
import 'package:movie_app/models/media_model.dart';
import 'package:movie_app/pages/home/widgets/movie_horizontal_item.dart';

class MoviesHorizontalList extends StatelessWidget {
  final Result result;
  final bool isMovie;
  const MoviesHorizontalList({super.key, required this.result, required this.isMovie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: result.movies.length,
        itemBuilder: (context, index) {
          final movie = result.movies[index];
          return MovieHorizontalItem(movie: movie, isMovie: isMovie,);
        },
      ),
    );
  }
}
