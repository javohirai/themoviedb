import 'package:themoviedb/domain/service/auth_service.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';

class AuthModel extends ChangeNotifier {
  final _authService = AuthService();

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

    try {
      await _authService.login(login, password);
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
    } catch (e) {
      _errorMessage = 'Неизвестная ошибка, поторите попытку';
    }
    _isAuthProgress = false;
    if (_errorMessage != null) {
      notifyListeners();
      return;
    }

    MainNavigation.resetNavigation(context);
  }
}
