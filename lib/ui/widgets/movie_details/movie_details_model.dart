import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/domain/entity/movie_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class MovieDetailsModel extends ChangeNotifier {
  final _sessionDataProvider = SessionDataProvider();
  final _apiClient = ApiClient();

  final int movieId;
  MovieDetails? _movieDetails;
  String _locale = '';
  bool _isFavourite = false;
  late DateFormat _dateFormat;
  Future<void>? Function()? onSessionExpired;

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';
  bool get isFavourite => _isFavourite;
  MovieDetails? get movieDetails => _movieDetails;

  MovieDetailsModel(this.movieId);

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await loadDetails();
  }

  Future<void> loadDetails() async {
    _movieDetails = await _apiClient.movieDetails(movieId, _locale);
    final sessionId = await _sessionDataProvider.getSessionId();
    if (sessionId != null) {
      _isFavourite = await _apiClient.isFavourite(movieId, sessionId);
    }
    notifyListeners();
  }

  Future<void> toggleFavorite() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final accountId = await _sessionDataProvider.getAccountId();

    if (sessionId == null || accountId == null) return;

    _isFavourite = !_isFavourite;
    notifyListeners();
    try {
      await _apiClient.makeFavourite(
          accountId: accountId,
          sessionId: sessionId,
          mediaType: MediaType.Movie,
          mediaId: movieId,
          favorite: _isFavourite);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.SessionExpired:
          await onSessionExpired?.call();
        default:
          print('hey');
      }
    }
  }

  void openMovieTrailer(BuildContext context, String trailerKey) {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.movieTrailer,
        arguments: trailerKey);
  }
}
