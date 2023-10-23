import 'package:json_annotation/json_annotation.dart';

part 'movie_details_videos.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieDetailsVideos {
  List<MovieDetailsVideosResult> results;

  MovieDetailsVideos({required this.results});

  factory MovieDetailsVideos.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsVideosFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsVideosToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieDetailsVideosResult {
  @JsonKey(name: 'iso_639_1')
  String iso639;
  @JsonKey(name: 'iso_3166_1')
  String iso3166;
  String name;
  String key;
  String site;
  int size;
  String type;
  String official;
  DateTime? publishedAt;
  String id;

  MovieDetailsVideosResult({
    required this.id,
    required this.iso3166,
    required this.iso639,
    required this.key,
    required this.name,
    required this.official,
    required this.publishedAt,
    required this.site,
    required this.size,
    required this.type,
  });

  factory MovieDetailsVideosResult.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsVideosResultFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsVideosResultToJson(this);
}
