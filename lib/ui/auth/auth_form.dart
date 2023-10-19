import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:themoviedb/ui/auth/auth_model.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
        width: double.infinity,
        child: Text('Themoviedb', textAlign: TextAlign.center),
      )),
      body: _Header(),
    );
  }
}

class _Header extends StatelessWidget {
  _Header({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          _FormWidget(),
          SizedBox(height: 20),
          Text(
              'In order to use the editing and rating capabilities of TMDB, as well as get personal recommendations you will need to login to your account. If you do not have an account, registering for an account is free and simple. Click here to get started.',
              style: defaultFontStyle),
          SizedBox(height: 20),
          Text(
              'If you signed up but didn\'t get your verification emailclick here to have it resent',
              style: defaultFontStyle),
        ],
      ),
    );
  }
}

final defaultFontStyle = const TextStyle(fontSize: 16, color: Colors.black);

class _FormWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = AuthProvider.read(context)?.model;
    final defaultColor = const Color(0xFF01B4E4);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ErrorMessageWidget(),
        TextField(
          controller: model?.loginController,
          decoration: inputDecorationForTextField('Username'),
        ),
        SizedBox(height: 20),
        TextField(
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          controller: model?.passwordController,
          obscureText: true,
          decoration: inputDecorationForTextField('Password'),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            _LoginButtonWidget(color: defaultColor),
            SizedBox(width: 30),
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(defaultColor),
              ),
              child: Text('Reset password'),
            ),
          ],
        ),
      ],
    );
  }

  InputDecoration inputDecorationForTextField(String labelText) {
    return InputDecoration(
        border: OutlineInputBorder(),
        isCollapsed: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        labelText: labelText);
  }
}

class _LoginButtonWidget extends StatelessWidget {
  const _LoginButtonWidget({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    final model = AuthProvider.watch(context)?.model;
    final onPressed = model?.canAuth == true ? model?.auth(context) : null;
    return TextButton(
      onPressed: () => onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(color),
        foregroundColor: MaterialStatePropertyAll(Colors.white),
        textStyle: MaterialStatePropertyAll(
          TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      child: Text('Login'),
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final errorText = AuthProvider.watch(context)?.model.errorText;
    if (errorText == null) return SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(errorText),
    );
  }
}
