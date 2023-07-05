import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:themoviedb/style.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
        width: double.infinity,
        child: Text('Themoviedb', textAlign: TextAlign.center),
      )),
      body: AuthWidget(),
    );
  }
}

class AuthWidget extends StatefulWidget {
  AuthWidget({super.key});
  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _Header(),
      ],
    );
  }
}

class _Header extends StatefulWidget {
  _Header({super.key});
  @override
  __HeaderState createState() => __HeaderState();
}

final defaultFontStyle = const TextStyle(fontSize: 16, color: Colors.black);

class __HeaderState extends State<_Header> {
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

class _FormWidget extends StatefulWidget {
  _FormWidget({super.key});
  @override
  __FormWidgetState createState() => __FormWidgetState();
}

class __FormWidgetState extends State<_FormWidget> {
  String? errorText;
  final _loginController = TextEditingController(text: 'admin');
  final _passwordController = TextEditingController(text: 'admin');
  void loginClicked() {
    if (_loginController.text == 'admin' &&
        _passwordController.text == 'admin') {
      errorText = null;
      Navigator.of(context).pushReplacementNamed('/main');
    } else {
      errorText = 'Incorrect input data';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final textStye = const TextStyle(fontSize: 16);
    final defaultColor = const Color(0xFF01B4E4);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (errorText != null) ...[
          Text(errorText ?? ''),
          SizedBox(height: 20),
        ],
        TextField(
          controller: _loginController,
          decoration: inputDecorationForTextField('Username'),
        ),
        SizedBox(height: 20),
        TextField(
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          controller: _passwordController,
          obscureText: true,
          decoration: inputDecorationForTextField('Password'),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            TextButton(
              onPressed: loginClicked,
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(defaultColor),
                foregroundColor: MaterialStatePropertyAll(Colors.white),
                textStyle: MaterialStatePropertyAll(
                  TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              child: Text('Login'),
            ),
            SizedBox(width: 30),
            TextButton(
              onPressed: () {
                print('reset clicked');
              },
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
