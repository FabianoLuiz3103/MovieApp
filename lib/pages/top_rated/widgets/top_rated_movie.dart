import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/media_model.dart';
import 'package:movie_app/pages/movie_detail/movie_detail_page.dart';

class TopHatedMovie extends StatelessWidget {
  const TopHatedMovie({
    super.key,
    required this.movie,
    required this.isMovie
  });

  final Media movie;
  final bool isMovie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MovieDetailPage(
                  mediaId: movie.id,
                  isMovie: isMovie,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('$imageUrl${movie.posterPath}')),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isMovie ? movie.title! : movie.name!,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    isMovie ? (movie.releaseDate == null
                        ? ''
                        : DateFormat("d 'de' MMM 'de' y")
                            .format(movie.releaseDate!)) :
                    (movie.firstAirDate == null
                        ? ''
                        : DateFormat("d 'de' MMM 'de' y")
                            .format(movie.firstAirDate!)),
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 15,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${movie.voteAverage.toStringAsFixed(1)}/10',
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
