import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/genero_model.dart';
import 'package:movie_app/models/movie_detail_model.dart';
import 'package:movie_app/models/media_model.dart';
import 'package:movie_app/models/serie_detail_model.dart';

const baseUrl = 'https://api.themoviedb.org/3/';
const key = '?api_key=$apiKey';

class ApiServices {
  Future<Result> getTopRatedMovies() async {
    await Future.delayed(const Duration(seconds: 2));
    var endPoint = 'movie/top_rated';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load now playing movies');
  }

  Future<Result> getNowPlayingMovies() async {
    await Future.delayed(const Duration(seconds: 2));
    var endPoint = 'movie/now_playing';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load now playing movies');
  }

  Future<Result> getUpcomingMovies() async {
    await Future.delayed(const Duration(seconds: 2));
    var endPoint = 'movie/upcoming';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load upcoming movies');
  }

  Future<MovieDetailModel> getMovieDetail(int movieId) async {
    await Future.delayed(const Duration(seconds: 2));
    final endPoint = 'movie/$movieId';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load  movie details');
  }

  Future<Result> getMovieRecommendations(int movieId) async {
    await Future.delayed(const Duration(seconds: 2));
    final endPoint = 'movie/$movieId/recommendations';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load  movie details');
  }

  Future<Result> getSearchedMovie(String searchText) async {
    await Future.delayed(const Duration(seconds: 2));
    final endPoint = 'search/movie?query=$searchText';
    final url = '$baseUrl$endPoint';
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTAyYjhjMDMxYzc5NzkwZmU1YzBiNGY5NGZkNzcwZCIsInN1YiI6IjYzMmMxYjAyYmE0ODAyMDA4MTcyNjM5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.N1SoB26LWgsA33c-5X0DT5haVOD4CfWfRhwpDu9eGkc'
    });
    if (response.statusCode == 200) {
      final movies = Result.fromJson(jsonDecode(response.body));
      return movies;
    }
    throw Exception('failed to load  search movie ');
  }

  Future<Result> getPopularMovies() async {
    await Future.delayed(const Duration(seconds: 2));
    const endPoint = 'movie/popular';
    const url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url), headers: {});
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load now playing movies');
  }

  Future<Result> getAiringSeries() async {
    await Future.delayed(const Duration(seconds: 2));
    const endPoint = 'tv/airing_today';
    const url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url), headers: {});
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load Airing Today');
  }

  Future<Result> getOnTheAir() async {
    await Future.delayed(const Duration(seconds: 2));
    const endPoint = 'tv/on_the_air';
    const url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url), headers: {});
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to on the air');
  }

  Future<Result> getPopularSeries() async {
    await Future.delayed(const Duration(seconds: 2));
    const endPoint = 'tv/popular';
    const url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url), headers: {});
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to on the air');
  }

  Future<SerieDetail> getSerieDetail(int serieId) async {
    await Future.delayed(const Duration(seconds: 2));
    final endPoint = 'tv/$serieId';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return SerieDetail.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load serie details');
  }

  Future<Result> getSerieRecommendations(int serieId) async {
    await Future.delayed(const Duration(seconds: 2));
    final endPoint = 'tv/$serieId/recommendations';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load serie details');
  }

  Future<List<Genero>> getMoviesGenero() async {
    await Future.delayed(const Duration(seconds: 2));
    const endPoint = 'genre/movie/list';
    const url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> genresJson = jsonResponse['genres'];
      List<Genero> generos =
          genresJson.map((json) => Genero.fromJson(json)).toList();

      return generos;
    }
    throw Exception('failed to load movies genero details');
  }

  Future<Result> getTopRatedSeries() async {
    await Future.delayed(const Duration(seconds: 2));
    var endPoint = 'tv/top_rated';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load to rated series');
  }


  Future<Result> getSearchedSeries(String searchText) async {
  await Future.delayed(const Duration(seconds: 2));
  final endPoint = 'search/tv?query=$searchText';
  final url = '$baseUrl$endPoint';
  final response = await http.get(Uri.parse(url), headers: {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTAyYjhjMDMxYzc5NzkwZmU1YzBiNGY5NGZkNzcwZCIsInN1YiI6IjYzMmMxYjAyYmE0ODAyMDA4MTcyNjM5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.N1SoB26LWgsA33c-5X0DT5haVOD4CfWfRhwpDu9eGkc'
  });
  if (response.statusCode == 200) {
    final series = Result.fromJson(jsonDecode(response.body));
    return series;
  }
  throw Exception('Failed to load search series');
}

 Future<Result> getTrending(String dayOrWeek) async {
    await Future.delayed(const Duration(seconds: 2));
    var endPoint = 'trending/all/$dayOrWeek';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load to rated series');
  }


}
