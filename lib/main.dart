import 'package:flutter/material.dart';
import 'package:themoviedb/style.dart';
import 'package:themoviedb/ui/auth/auth_form.dart';
import 'package:themoviedb/ui/auth/auth_model.dart';
import 'package:themoviedb/ui/main_screen/main_screen.dart';
import 'package:themoviedb/ui/movie_list/movie_list_widget.dart';
import 'package:themoviedb/ui/movie/movie_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: ProjectStyle.projectDefaultColor,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: ProjectStyle.projectDefaultColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/auth': (context) => AuthProvider(
              model: AuthModel(),
              child: AppWidget(),
            ),
        '/main': (context) => MainScreenWidget(),
        '/movie_list/movie_widget': (context) {
          var movie = ModalRoute.of(context)!.settings.arguments as Movie;
          return MovieWidget(
            movie: movie,
          );
        },
      },
      initialRoute: '/auth',
      // onGenerateRoute: (RouteSettings setting) {
      //   return MaterialPageRoute<void>(
      //     builder: (context) {
      //       return Scaffold(
      //         body: Center(
      //           child: Text('Error'),
      //         ),
      //       );
      //     },
      //   );
      // },
    );
  }
}
