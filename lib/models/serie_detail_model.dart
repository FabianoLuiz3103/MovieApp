import 'dart:convert';

// Classe principal
class SerieDetail {
  bool adult;
  String backdropPath;
  List<Creator> createdBy;
  List<int> episodeRunTime;
  DateTime firstAirDate;
  List<Genre> genres;
  int id;
  bool inProduction;
  List<String> languages;
  DateTime lastAirDate;
  Episode lastEpisodeToAir;
  String name;
  Episode? nextEpisodeToAir;
  List<Network> networks;
  int numberOfEpisodes;
  int numberOfSeasons;
  List<String> originCountry;
  String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String? posterPath;
  List<ProductionCompany> productionCompanies;
  List<ProductionCountry> productionCountries;
  List<Season> seasons;
  List<SpokenLanguage> spokenLanguages;
  double voteAverage;
  int voteCount;

  SerieDetail({
    required this.adult,
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.name,
    this.nextEpisodeToAir,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.voteAverage,
    required this.voteCount,
  });

  factory SerieDetail.fromJson(Map<String, dynamic> json) {
  return SerieDetail(
    adult: json['adult'] ?? false, // Forneça valor padrão
    backdropPath: json['backdrop_path'] ?? '',
    createdBy: (json['created_by'] as List?)
        ?.map((e) => Creator.fromJson(e))
        .toList() ?? [],
    episodeRunTime: List<int>.from(json['episode_run_time'] ?? []),
    firstAirDate: DateTime.parse(json['first_air_date']),
    genres: (json['genres'] as List)
        .map((e) => Genre.fromJson(e))
        .toList(),
    id: json['id'] ?? 0, // Forneça valor padrão
    inProduction: json['in_production'] ?? false, // Forneça valor padrão
    languages: List<String>.from(json['languages'] ?? []),
    lastAirDate: DateTime.parse(json['last_air_date']),
    lastEpisodeToAir: json['last_episode_to_air'] != null
        ? Episode.fromJson(json['last_episode_to_air'])
        : Episode.empty(),
    name: json['name'] ?? '',
    nextEpisodeToAir: json['next_episode_to_air'] != null
        ? Episode.fromJson(json['next_episode_to_air'])
        : null,
    networks: (json['networks'] as List)
        .map((e) => Network.fromJson(e))
        .toList(),
    numberOfEpisodes: json['number_of_episodes'] ?? 0, // Forneça valor padrão
    numberOfSeasons: json['number_of_seasons'] ?? 0, // Forneça valor padrão
    originCountry: List<String>.from(json['origin_country'] ?? []),
    originalLanguage: json['original_language'] ?? '',
    originalName: json['original_name'] ?? '',
    overview: json['overview'] ?? '',
    popularity: (json['popularity'] as num).toDouble(),
    posterPath: json['poster_path'] ?? '',
    productionCompanies: (json['production_companies'] as List)
        .map((e) => ProductionCompany.fromJson(e))
        .toList(),
    productionCountries: (json['production_countries'] as List)
        .map((e) => ProductionCountry.fromJson(e))
        .toList(),
    seasons: (json['seasons'] as List)
        .map((e) => Season.fromJson(e))
        .toList(),
    spokenLanguages: (json['spoken_languages'] as List)
        .map((e) => SpokenLanguage.fromJson(e))
        .toList(),
    voteAverage: (json['vote_average'] as num).toDouble(),
    voteCount: json['vote_count'] ?? 0, // Forneça valor padrão
  );
}


}

class Creator {
  int id;
  String creditId;
  String name;
  String originalName;
  int gender;
  String? profilePath; // Permitir nulos

  Creator({
    required this.id,
    required this.creditId,
    required this.name,
    required this.originalName,
    required this.gender,
    this.profilePath,
  });

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
      id: json['id'],
      creditId: json['credit_id'] ?? '', // Verificação de valores nulos
      name: json['name'] ?? '',
      originalName: json['original_name'] ?? '',
      gender: json['gender'] ?? 0, // Forneça valor padrão
      profilePath: json['profile_path'], // Permitir nulos
    );
  }
}


class Genre {
  int id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Episode {
  int id;
  String name;
  String overview;
  double voteAverage;
  int voteCount;
  String airDate;
  int episodeNumber;
  String episodeType;
  String productionCode;
  int? runtime; // Permitir nulos
  int seasonNumber;
  int showId;
  String? stillPath; // Permitir nulos

  Episode({
    required this.id,
    required this.name,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    required this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.productionCode,
    this.runtime,
    required this.seasonNumber,
    required this.showId,
    this.stillPath,
  });

  factory Episode.empty() {
    return Episode(
      id: 0,
      name: '',
      overview: '',
      voteAverage: 0.0,
      voteCount: 0,
      airDate: '',
      episodeNumber: 0,
      episodeType: '',
      productionCode: '',
      runtime: null, // Valor nulo
      seasonNumber: 0,
      showId: 0,
      stillPath: null, // Valor nulo
    );
  }

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      name: json['name'] ?? '',
      overview: json['overview'] ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
      airDate: json['air_date'] ?? '',
      episodeNumber: json['episode_number'] ?? 0,
      episodeType: json['episode_type'] ?? '',
      productionCode: json['production_code'] ?? '',
      runtime: json['runtime'], // Permitir nulos
      seasonNumber: json['season_number'] ?? 0,
      showId: json['show_id'] ?? 0,
      stillPath: json['still_path'], // Permitir nulos
    );
  }
}


class Network {
  int id;
  String logoPath;
  String name;
  String originCountry;

  Network({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory Network.fromJson(Map<String, dynamic> json) {
    return Network(
      id: json['id'],
      logoPath: json['logo_path'],
      name: json['name'],
      originCountry: json['origin_country'],
    );
  }
}

class ProductionCompany {
  int id;
  String? logoPath;
  String name;
  String originCountry;

  ProductionCompany({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json['id'],
      logoPath: json['logo_path'],
      name: json['name'],
      originCountry: json['origin_country'],
    );
  }
}

class ProductionCountry {
  String iso31661;
  String name;

  ProductionCountry({
    required this.iso31661,
    required this.name,
  });

  factory ProductionCountry.fromJson(Map<String, dynamic> json) {
    return ProductionCountry(
      iso31661: json['iso_3166_1'],
      name: json['name'],
    );
  }
}

class Season {
  String? airDate; // Permitir nulos
  int episodeCount;
  int id;
  String name;
  String overview;
  String? posterPath; // Permitir nulos
  int seasonNumber;
  double voteAverage;

  Season({
    this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      airDate: json['air_date'], // Permitir nulos
      episodeCount: json['episode_count'] ?? 0, // Forneça valor padrão
      id: json['id'],
      name: json['name'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'], // Permitir nulos
      seasonNumber: json['season_number'] ?? 0, // Forneça valor padrão
      voteAverage: (json['vote_average'] as num).toDouble(),
    );
  }
}


class SpokenLanguage {
  String englishName;
  String iso6391;
  String name;

  SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) {
    return SpokenLanguage(
      englishName: json['english_name'],
      iso6391: json['iso_639_1'],
      name: json['name'],
    );
  }
}
