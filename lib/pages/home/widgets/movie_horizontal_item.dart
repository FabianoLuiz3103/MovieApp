import 'package:flutter/material.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/media_model.dart';
import 'package:movie_app/pages/movie_detail/movie_detail_page.dart';

class MovieHorizontalItem extends StatelessWidget {
  const MovieHorizontalItem({
    super.key,
    required this.movie,
    required this.isMovie,
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
      child: Stack(
        children: [
          Container(
            height: 200,
            width: 140,
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.transparent,
                ],
              ),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage('$imageUrl${movie.posterPath}'),
              ),
            ),
          ),
          Positioned(
            left: 15,
            right: 15,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isMovie? movie.title! : movie.name!,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isMovie? movie.releaseDate?.year.toString() ?? '' : movie.firstAirDate?.year.toString() ?? '',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.voteAverage.toInt().toString(),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 15,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
