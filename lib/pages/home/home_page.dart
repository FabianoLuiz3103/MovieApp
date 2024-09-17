import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/components/progress.dart';
import 'package:movie_app/models/genero_model.dart';
import 'package:movie_app/models/media_model.dart';
import 'package:movie_app/pages/home/widgets/movies_horizontal_list.dart';
import 'package:movie_app/pages/home/widgets/nowplaying_list.dart';
import 'package:movie_app/services/api_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiServices apiServices = ApiServices();

  bool isMovie = true;
  bool isLoading = false;

  // Filmes
  late Future<Result> popular;
  late Future<Result> nowPlaying;
  late Future<Result> upcomingFuture;

  // Séries
  late Future<Result> airingToday;
  late Future<Result> onTheAir;
  late Future<Result> popularSeries;


  @override
  void initState() {
    super.initState();

    popular = apiServices.getPopularMovies();
    nowPlaying = apiServices.getNowPlayingMovies();
    upcomingFuture = apiServices.getUpcomingMovies();
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
    });

    if (!isMovie) {
      airingToday = apiServices.getAiringSeries();
      onTheAir = apiServices.getOnTheAir();
      popularSeries = apiServices.getPopularSeries();
    }

    _startLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FBFLIX',
          style: GoogleFonts.anton(
            color: Colors.yellowAccent,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              escolhaTipo(),
              _buildSectionHeader(isMovie ? 'Now Playing' : 'Airing Today'),
              _buildSectionContent(
                isLoading,
                isMovie ? nowPlaying : airingToday,
                (data) => NowPlayingList(result: data),
              ),
              const SizedBox(height: 20),
              _buildSectionHeader('Popular'),
              _buildSectionContent(
                isLoading,
                isMovie ? popular : popularSeries,
                (data) => MoviesHorizontalList(result: data, isMovie: isMovie),
              ),
              _buildSectionHeader(isMovie ? 'Upcoming' : 'On The Air'),
              _buildSectionContent(
                isLoading,
                isMovie ? upcomingFuture : onTheAir,
                (data) => MoviesHorizontalList(result: data, isMovie: isMovie),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
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
          }),
          button("Séries", !isMovie, () {
            _changeMediaType(false);
          })
        ],
      ),
    );
  }

  ElevatedButton button(String texto, bool isSelected, VoidCallback clicado) {
    return ElevatedButton(
      onPressed: clicado,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        side: WidgetStateProperty.all(BorderSide(
            color: isSelected ? Colors.yellowAccent : Colors.white54,
            width: 2)),
        elevation: WidgetStateProperty.all(0), // Remove a elevação
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10)), // Ajuste o padding conforme necessário
      ),
      child: Text(
        texto,
        style: TextStyle(
            color: isSelected
                ? Colors.yellowAccent
                : Colors.white54), // Define a cor do texto
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white54,
          fontWeight: FontWeight.w300,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _buildSectionContent(
    bool isLoading,
    Future<Result> future,
    Widget Function(Result) builder,
  ) {
    return isLoading
        ? SizedBox(
            height: 200,
            child: Center(child: progressSkin(20)),
          )
        : FutureBuilder<Result>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: 200,
                  child: Center(child: progressSkin(20)),
                );
              } else if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return const Text('Nenhum dado disponível');
              } else {
                return builder(snapshot.data!);
              }
            },
          );
  }
}
