import 'package:flutter/material.dart';
import 'package:themoviedb/ui/widgets/auth/auth_model.dart';
import 'package:themoviedb/ui/widgets/auth/auth_widget.dart';
import 'package:themoviedb/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_widget.dart';

abstract class MainNavigationRouteNames {
  static const authRoute = 'auth';
  static const mainScreenRoute = '/';
  static const movieDetailsRoute = '/movie_details';
}

class MainNavigation {
  static MainNavigation instance = MainNavigation();

  String getInitialRoute(bool isAuth) => isAuth
      ? MainNavigationRouteNames.mainScreenRoute
      : MainNavigationRouteNames.authRoute;

  Map<String, Widget Function(BuildContext)> get routes => {
        MainNavigationRouteNames.authRoute: (context) => NotifierProvider(
              model: AuthModel(),
              child: const AuthWidget(),
            ),
        MainNavigationRouteNames.mainScreenRoute: (context) =>
            const MainScreenWidget(),
      };
  Route<Object>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.movieDetailsRoute:
        final arguments = settings.arguments as int;
        return MaterialPageRoute(
            builder: (context) => MovieDetailsWidget(movieId: arguments));
      default:
        return MaterialPageRoute(
            builder: (context) => const Text('error page'));
    }
  }
}
