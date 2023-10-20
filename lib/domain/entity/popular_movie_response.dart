import 'package:json_annotation/json_annotation.dart';
import 'package:themoviedb/domain/entity/movie.dart';

part 'popular_movie_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PopularMovieResponse {
  final int page;
  @JsonKey(name: 'results')
  final List<Movie> movieList;
  final int total_pages;
  final int total_results;

  PopularMovieResponse({
    required this.page,
    required this.movieList,
    required this.total_pages,
    required this.total_results,
  });

  factory PopularMovieResponse.fromJson(Map<String, dynamic> json) =>
      _$PopularMovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PopularMovieResponseToJson(this);
}
