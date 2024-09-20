
class Person {
  final bool adult;
  final List<String> alsoKnownAs;
  final String biography;
  final String birthday;
  final String? deathday; 
  final int gender;
  final String? homepage; 
  final int id;
  final String imdbId;
  final String knownForDepartment;
  final String name;
  final String placeOfBirth;
  final double popularity;
  final String profilePath;

  Person({
    required this.adult,
    required this.alsoKnownAs,
    required this.biography,
    required this.birthday,
    this.deathday,
    required this.gender,
    this.homepage,
    required this.id,
    required this.imdbId,
    required this.knownForDepartment,
    required this.name,
    required this.placeOfBirth,
    required this.popularity,
    required this.profilePath,
  });
  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      adult: json['adult'] ?? false,
      alsoKnownAs: List<String>.from(json['also_known_as']),
      biography: json['biography'] ?? '',
      birthday: json['birthday'] ?? '',
      deathday: json['deathday'] ?? '',
      gender: json['gender'],
      homepage: json['homepage'] ?? '',
      id: json['id'],
      imdbId: json['imdb_id'] ?? '',
      knownForDepartment: json['known_for_department'] ?? '',
      name: json['name'] ?? '',
      placeOfBirth: json['place_of_birth'] ?? '',
      popularity: json['popularity'].toDouble(),
      profilePath: json['profile_path'] ?? '',
    );
  }

}

