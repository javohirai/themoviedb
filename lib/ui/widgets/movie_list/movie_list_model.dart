import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/domain/entity/popular_movie_response.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class MovieListModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _movies = <Movie>[];

  List<Movie> get movies => _movies;
  late DateFormat _dateFormat;
  late int _currentPage;
  late int _totalPage;
  bool _isLoadingMovies = false;
  String _locale = '';
  String? _queryText;
  Timer? searchDebounce;

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await _resetList();
  }

  Future<void> _resetList() async {
    _currentPage = 0;
    _totalPage = 1;
    _movies.clear();
    await _loadNextPage();
  }

  Future<PopularMovieResponse> _loadMovies(int nextPage, String locale) async {
    final query = _queryText;
    if (query == null) {
      return await _apiClient.popularMovieList(nextPage, _locale);
    } else {
      return await _apiClient.searchMovie(nextPage, _locale, query);
    }
  }

  Future<void> _loadNextPage() async {
    if (_isLoadingMovies || _currentPage >= _totalPage) return;
    _isLoadingMovies = true;
    try {
      final nextPage = _currentPage + 1;
      final response = await _loadMovies(nextPage, _locale);
      _currentPage = response.page;
      _totalPage = response.total_pages;
      _movies.addAll(response.movieList);
      notifyListeners();
    } catch (e) {}
    _isLoadingMovies = false;
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.movieDetailsRoute,
      arguments: id,
    );
  }

  void showedMovieAtIndex(int index) {
    if (index < _movies.length - 1) return;
    _loadNextPage();
  }

  Future<void> searchQuery(String query) async {
    searchDebounce?.cancel();
    searchDebounce = Timer(Duration(seconds: 1), () async {
      final queryText = query.isNotEmpty ? query : null;
      if (queryText == _queryText) return;
      _queryText = queryText;
      await _resetList();
    });
  }
}
