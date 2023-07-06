import 'package:flutter/material.dart';
import 'package:themoviedb/style.dart';
import 'package:themoviedb/utils/images.dart';
import 'package:themoviedb/widget/movie_list/movie_list_widget.dart';
import 'package:themoviedb/widget/movie/movie_name_info.dart';

import 'movie_screen_cast.dart';

class MovieWidget extends StatefulWidget {
  Movie movie;
  MovieWidget({super.key, required this.movie});
  @override
  _MovieWidgetState createState() => _MovieWidgetState(movie: movie);
}

class _MovieWidgetState extends State<MovieWidget> {
  Movie movie;
  _MovieWidgetState({required this.movie});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.name),
        backgroundColor: ProjectStyle.projectDefaultColor,
      ),
      body: Container(
        child: ListView(
          children: [
            _ImagePlaceHolderWidget(
              movie: movie,
            ),
            MovieNameWidget(
              movie: movie,
            ),
            MovieScreenCastWidget(),
          ],
        ),
      ),
    );
  }
}

class _ImagePlaceHolderWidget extends StatelessWidget {
  final Movie movie;
  const _ImagePlaceHolderWidget({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
          image: AppImages.backgroundImage,
        ),
        Positioned(
          bottom: 20,
          left: 20,
          top: 20,
          child: Image(
            image: AppImages.smallImage,
          ),
        )
      ],
    );
  }
}
