import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/resources/pwd.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  String? _errorText;
  final loginController = TextEditingController(text: UtilPwd.login);
  final passwordController = TextEditingController(text: UtilPwd.pwd);

  String get errorText => _errorText ?? '';
  bool _isAuthProgress = false;

  bool get canAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  Future<void> auth(BuildContext context) async {
    final login = loginController.text;
    final pwd = passwordController.text;

    if (login.isEmpty || pwd.isEmpty) {
      _errorText = 'Login or password is empty';
      notifyListeners();
      return;
    }
    _errorText = null;
    _isAuthProgress = true;
    notifyListeners();
    String? sessionId;
    try {
      sessionId = await _apiClient.auth(login, pwd);
    } catch (e) {
      _errorText = e.toString();
    }
    _isAuthProgress = false;
    if (_errorText != null && sessionId == null) notifyListeners();
  }
}

class AuthProvider extends InheritedNotifier {
  final AuthModel model;
  const AuthProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );
  static AuthProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthProvider>();
  }

  static AuthProvider? read(BuildContext context) {
    final widget =
        context.getElementForInheritedWidgetOfExactType<AuthProvider>()?.widget;
    return widget is AuthProvider ? widget : null;
  }
}
