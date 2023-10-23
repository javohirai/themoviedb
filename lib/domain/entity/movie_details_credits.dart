import 'package:json_annotation/json_annotation.dart';

part 'movie_details_credits.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake,explicitToJson: true)
class MovieDetailsCredits {
  List<Cast> cast;
  List<Crew> crew;

  MovieDetailsCredits({required this.cast, required this.crew});

  factory MovieDetailsCredits.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsCreditsFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsCreditsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Cast {
  bool adult;
  int? gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String? profilePath;
  int castId;
  String character;
  String creditId;
  int order;

  Cast({
    required this.adult,
    required this.gender,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.order,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
  });

  factory Cast.fromJson(Map<String, dynamic> json) =>
      _$CastFromJson(json);

  Map<String, dynamic> toJson() => _$CastToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Crew {
  bool adult;
  int? gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String? profilePath;
  String creditId;
  String department;
  String job;

  Crew({
    required this.adult,
    required this.gender,
    required this.department,
    required this.creditId,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.job,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
  });

  factory Crew.fromJson(Map<String, dynamic> json) =>
      _$CrewFromJson(json);

  Map<String, dynamic> toJson() => _$CrewToJson(this);
}
