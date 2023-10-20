import 'dart:convert';
import 'dart:io';

import 'package:themoviedb/domain/entity/popular_movie_response.dart';

enum ApiClientExceptionType { Network, Auth, Other }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

class ApiClient {
  final _client = HttpClient();

  final _host = 'https://api.themoviedb.org/3';
  static final String _imageHost = 'https://image.tmdb.org/t/p/w500';
  final _token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxN2FiYmNmMTQzMGRjNTcyMTgyYjJhNjU4MTQ2MTg4ZCIsInN1YiI6IjYwOWQxMTAzZmQ0YTk2MDA2MzRlNmIzNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ErSFBc1fO_s_MJoDdjQg3RDi3jh41Ls1WYPzr36OB6Y';

  static String imagePath(String path) => '$_imageHost$path';

  Future<String> auth(
    String username,
    String password,
  ) async {
    final token = await _makeToken();
    final validToken = await _validateLogin(username, password, token);
    final sessionId = await _makeSession(validToken);

    return sessionId;
  }

  Future<Map<String, dynamic>> _makeUri(
    String path,
    String method, [
    Map<String, dynamic>? bodyParametres,
    Map<String, dynamic>? queryParametres,
  ]) async {
    var url = Uri.parse('$_host$path');
    if (queryParametres != null) {
      url = url.replace(queryParameters: queryParametres);
    }
    try {
      final request = method == 'get'
          ? await _client.getUrl(url)
          : await _client.postUrl(url);

      request.headers.add('Authorization', 'Bearer $_token');
      if (bodyParametres != null) {
        request.headers.contentType = ContentType.json;
        request.write(jsonEncode(bodyParametres));
      }
      final response = await request.close();
      if (response.statusCode == 401) {
        throw ApiClientException(ApiClientExceptionType.Auth);
      }
      final json = await response
          .transform(utf8.decoder)
          .toList()
          .then((value) => value.join())
          .then((value) => jsonDecode(value) as Map<String, dynamic>);
      return json;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (e) {
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }

  Future<String> _makeToken() async {
    final json = await _makeUri('/authentication/token/new', 'get');
    final token = json['request_token'] as String;
    return token;
  }

  Future<PopularMovieResponse> popularMovieList(int page, String locale) async {
    final json = await _makeUri(
      '/movie/popular',
      'get',
      null,
      <String, dynamic>{'language': locale, 'page': page.toString()},
    ); //?language=en-US&page=1
    return PopularMovieResponse.fromJson(json);
  }

  Future<String> _validateLogin(
    String username,
    String password,
    String request_token,
  ) async {
    final parametres = {
      'username': username,
      'password': password,
      'request_token': request_token
    };
    final json = await _makeUri(
        '/authentication/token/validate_with_login', 'post', parametres);
    final token = json['request_token'] as String;
    return token;
  }

  Future<String> _makeSession(
    String request_token,
  ) async {
    final parametres = {'request_token': request_token};
    final json =
        await _makeUri('/authentication/session/new', 'post', parametres);
    final sessionId = json['session_id'] as String;
    return sessionId;
  }
}
