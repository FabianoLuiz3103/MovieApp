import 'dart:convert';

class Result {
  int page;
  List<Media> movies;
  int totalPages;
  int totalResults;

  Result({
    required this.page,
    required this.movies,
    required this.totalPages,
    required this.totalResults,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        page: json["page"],
        movies: List<Media>.from(json["results"].map((x) => Media.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class Media {
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String? originalTitle;    
  String? originalName;     
  String overview;
  double popularity;
  String posterPath;
  DateTime? releaseDate;     
  DateTime? firstAirDate;    
  String? title;             
  String? name;             
  List<String>? originCountry; 
  bool video;
  double voteAverage;
  int voteCount;

  Media({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    this.originalTitle,
    this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    this.releaseDate,
    this.firstAirDate,
    this.title,
    this.name,
    this.originCountry,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Media.fromRawJson(String str) => Media.fromJson(json.decode(str));

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"] ?? '',
        genreIds: json["genre_ids"] != null 
            ? List<int>.from(json["genre_ids"].map((x) => x)) 
            : [],
        id: json["id"] ?? 0,
        originalLanguage: json["original_language"] ?? '',
        originalTitle: json["original_title"],        
        originalName: json["original_name"],         
        overview: json["overview"] ?? '',
        popularity: json["popularity"]?.toDouble() ?? 0,
        posterPath: json["poster_path"] ?? '',
        releaseDate: json["release_date"] != null 
            ? DateTime.tryParse(json["release_date"]) 
            : null,                                   // Para filmes
        firstAirDate: json["first_air_date"] != null 
            ? DateTime.tryParse(json["first_air_date"]) 
            : null,                                   // Para séries
        title: json["title"],                         // Para filmes
        name: json["name"],                           // Para séries
        originCountry: json["origin_country"] != null
            ? List<String>.from(json["origin_country"].map((x) => x))
            : null,                                   // Para séries
        video: json["video"] ?? false,
        voteAverage: json["vote_average"]?.toDouble() ?? 0,
        voteCount: json["vote_count"] ?? 0,
      );
}
