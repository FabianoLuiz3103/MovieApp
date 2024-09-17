import 'package:flutter/material.dart';
import 'package:movie_app/components/progress.dart';
import 'package:movie_app/models/media_model.dart';
import 'package:movie_app/pages/top_rated/widgets/top_rated_movie.dart';
import 'package:movie_app/services/api_services.dart';

class TrendingPage extends StatefulWidget {
  const TrendingPage({super.key});

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  ApiServices apiServices = ApiServices();
  late Future<Result> treding;
  bool isDay = true;
  bool isLoading = false;
  String dayOrWeek = 'day';

  @override
  void initState() {
    super.initState();
    treding = apiServices.getTrending(dayOrWeek).then((result) {
      final sortedMovies = result.movies
        ..sort((a, b) => b.voteAverage.compareTo(a.voteAverage)); 
      return Result(
        movies: sortedMovies,
        page: result.page,
        totalPages: result.totalPages,
        totalResults: result.totalResults,
      );
    });
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

  void _changeMediaType(bool type, String tp) {
  setState(() {
    isDay = type;
    isLoading = true;
    dayOrWeek = tp;
    treding = apiServices.getTrending(dayOrWeek).then((result) {
      final sortedMovies = result.movies
        ..sort((a, b) => b.voteAverage.compareTo(a.voteAverage)); 
      return Result(
        movies: sortedMovies,
        page: result.page,
        totalPages: result.totalPages,
        totalResults: result.totalResults,
      );
    });
  });

  _startLoading();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending'), 
      ),
      body: Column(
        children: [
          escolhaTipo(),
          Expanded(
            child: isLoading
                ?  Center(child: progressSkin(20)) 
                : FutureBuilder<Result>(
                    future: treding,
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
                             bool isMovie = movie.firstAirDate == null;
                            
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
          button("Day", isDay, () {
            _changeMediaType(true, "day");
          }),
          button("Week", !isDay, () {
            _changeMediaType(false, "week");
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
