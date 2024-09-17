import 'package:flutter/material.dart';
import 'package:movie_app/components/progress.dart';
import 'package:movie_app/models/media_model.dart';
import 'package:movie_app/pages/top_rated/widgets/top_rated_movie.dart';
import 'package:movie_app/services/api_services.dart';

class TopRatedPage extends StatefulWidget {
  const TopRatedPage({super.key});

  @override
  State<TopRatedPage> createState() => _TopRatedPageState();
}

class _TopRatedPageState extends State<TopRatedPage> {
  ApiServices apiServices = ApiServices();
  late Future<Result> topRatedMoviesFuture;
  Future<Result>? topRatedSeries; // Inicializando como nullable
  bool isMovie = true;
  bool isLoading = false;
  String title = "Movies";

  @override
  void initState() {
    super.initState();
    topRatedMoviesFuture = apiServices.getTopRatedMovies(); // Carrega os filmes inicialmente
  }

  void _startLoading() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  void _changeMediaType(bool movie) {
    setState(() {
      isMovie = movie;
      isLoading = true; 
    });

    if (!isMovie) {
      topRatedSeries = apiServices.getTopRatedSeries(); 
    }

    _startLoading(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Top Rated $title'), 
      ),
      body: Column(
        children: [
          escolhaTipo(),
          Expanded(
            child: isLoading
                ?  Center(child: progressSkin(20)) 
                : FutureBuilder<Result>(
                    future: isMovie ? topRatedMoviesFuture : topRatedSeries,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return  Center(child: progressSkin(20));
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Erro: ${snapshot.error}'));
                      } else if (!snapshot.hasData) {
                        return const Center(child: Text('Nenhum dado disponível'));
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.movies.length,
                          itemBuilder: (context, index) {
                            var movie = snapshot.data!.movies[index];
                            return TopHatedMovie(movie: movie, isMovie: isMovie);
                          },
                        );
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Padding escolhaTipo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          button("Filmes", isMovie, () {
            _changeMediaType(true);
            title = "Movie";
          }),
          button("Séries", !isMovie, () {
            _changeMediaType(false);
            title = "Series";
          }),
        ],
      ),
    );
  }

  ElevatedButton button(String texto, bool isSelected, VoidCallback clicado) {
    return ElevatedButton(
      onPressed: clicado,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        side: WidgetStateProperty.all(
           BorderSide(color: isSelected ? Colors.yellowAccent : Colors.white54, width: 2),
        ),
        elevation: WidgetStateProperty.all(0),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
      child: Text(
        texto,
        style: TextStyle(
          color: isSelected ? Colors.yellowAccent : Colors.white54,
        ),
      ),
    );
  }
}
