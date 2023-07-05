import 'package:flutter/material.dart';

import '../movie_list/movie_list_widget.dart';

class MovieNameWidget extends StatelessWidget {
  final Movie movie;
  const MovieNameWidget({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Color.fromRGBO(24, 23, 27, 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          _TopPosterWidget(movie: movie),
          SizedBox(
            height: 20,
          ),
          _SummaryWidget(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Overview',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'A deadly female assassin comes out of hiding to protect the daughter that she gave up years before, while on the run from dangerous men.',
              maxLines: 4,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text(
                        'Niki Caro',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Director',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text(
                        'Andrea Berloff',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Screenplay',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Text('Andrea Berloff'),
                  Text('Screenplay'),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _SummaryWidget extends StatelessWidget {
  const _SummaryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ColoredBox(
        color: Color.fromRGBO(22, 21, 25, 1.0),
        child: Text(
          style: TextStyle(color: Colors.white),
          'R 05/04/2023 (US) Action, Thriller 1h 55m',
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        maxLines: 3,
        text: TextSpan(
          children: [
            TextSpan(
                text: movie.name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                )),
            TextSpan(
                text: '(${movie.year})',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                )),
          ],
        ),
      ),
    );
  }
}
