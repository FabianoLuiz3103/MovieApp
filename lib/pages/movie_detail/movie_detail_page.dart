import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/components/progress.dart';
import 'package:movie_app/models/movie_detail_model.dart';
import 'package:movie_app/models/media_model.dart';
import 'package:movie_app/models/serie_detail_model.dart';
import 'package:movie_app/services/api_services.dart';

class MovieDetailPage extends StatefulWidget {
  final int mediaId;
  final bool? isMovie;
  const MovieDetailPage({super.key, required this.mediaId, this.isMovie});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  ApiServices apiServices = ApiServices();

  late Future<MovieDetailModel>? movieDetail;
  late Future<SerieDetail>? serieDetail;
  late Future<Result>? recommendationModel;
  late Future<Result>? recommendationSerieModel;

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  fetchInitialData() {
    if (widget.isMovie == true) {
      // Carregar os detalhes do filme
      movieDetail = apiServices.getMovieDetail(widget.mediaId);
      recommendationModel = apiServices.getMovieRecommendations(widget.mediaId);
    } else {
      // Carregar os detalhes da série
      serieDetail = apiServices.getSerieDetail(widget.mediaId);
      recommendationSerieModel =
          apiServices.getSerieRecommendations(widget.mediaId);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<dynamic>(
          future: widget.isMovie! ? movieDetail : serieDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final media = snapshot.data;

              // Definindo os textos de acordo com a mídia
              String title = widget.isMovie! ? media.title : media.name;
              String releaseDate = widget.isMovie!
                  ? media.releaseDate.year.toString()
                  : media.firstAirDate.year.toString();
              String genresText =
                  media.genres.map((genre) => genre.name).join(', ');

              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: size.height * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage("$imageUrl${media.posterPath}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back_ios,
                                    color: Colors.white),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 25, left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              releaseDate,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 30),
                            Expanded(
                              child: Text(
                                genresText,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                ),
                                softWrap: true,
                                
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Text(
                          media.overview,
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  FutureBuilder(
                    future: widget.isMovie!
                        ? recommendationModel
                        : recommendationSerieModel,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final recommendations = snapshot.data;

                        return recommendations!.movies.isEmpty
                            ? const SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "More like this",
                                    maxLines: 6,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    itemCount: recommendations.movies.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 15,
                                      childAspectRatio: 1.5 / 2,
                                    ),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MovieDetailPage(
                                                mediaId: recommendations
                                                    .movies[index].id,
                                                isMovie: widget.isMovie,
                                              ),
                                            ),
                                          );
                                        },
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "$imageUrl${recommendations.movies[index].posterPath}",
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                      }
                      return const Text("Something Went wrong");
                    },
                  ),
                ],
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 2 - 50),
                progressSkin(20),
              ],
            );
          },
        ),
      ),
    );
  }
}
