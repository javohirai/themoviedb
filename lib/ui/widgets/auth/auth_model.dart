import 'dart:io';

import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;

    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Заполните логин и пароль';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();
    String? sessionId;
    int? acctounId;
    try {
      sessionId = await _apiClient.auth(
        username: login,
        password: password,
      );
      acctounId = await _apiClient.getAccountId(sessionId);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.Network:
          _errorMessage =
              'Сервер не доступен. Проверте подключение к интернету';
          break;
        case ApiClientExceptionType.Auth:
          _errorMessage = 'Неправильный логин пароль!';
          break;
        case ApiClientExceptionType.Other:
          _errorMessage = 'Произошла ошибка. Попробуйте еще раз';
          break;
        case ApiClientExceptionType.SessionExpired:
        _errorMessage = 'Сессия закончилось';
          break;
      }
    }
    _isAuthProgress = false;
    if (_errorMessage != null) {
      notifyListeners();
      return;
    }

    if (sessionId == null || acctounId == null) {
      _errorMessage = 'Неизвестная ошибка, поторите попытку';
      notifyListeners();
      return;
    }
    await _sessionDataProvider.setSessionId(sessionId);
    await _sessionDataProvider.setAccountId(acctounId);

    unawaited(
      Navigator.of(context)
          .pushReplacementNamed(MainNavigationRouteNames.mainScreen),
    );
  }
}
