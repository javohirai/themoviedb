import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {
  String? _errorText;
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  String get errorText => _errorText ?? '';
  final bool _isAuthProgress = false;

  bool get canAuth => _isAuthProgress;

  Future<void> auth(BuildContext context) async {}
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
