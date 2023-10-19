import 'package:flutter/material.dart';
import 'package:themoviedb/ui/custom_widgets/custom_figure.dart';

import '../movie_list/movie_list_widget.dart';

var nameStye = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w400,
  fontSize: 16,
);
var jobTitleStye = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w400,
  fontSize: 16,
);

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
          SizedBox(height: 20),
          _ScoreWidget(),
          SizedBox(height: 20),
          _SummaryWidget(),
          SizedBox(height: 20),
          _OverviewHeaderWidget(),
          _OverviewContentWidget(),
          SizedBox(height: 20),
          _CastWidget(
              castName1: 'Niki Caro',
              jobName1: 'Director',
              castName2: 'Andrea Berloff',
              jobName2: 'Screenplay'),
          SizedBox(height: 20),
          _CastWidget(
              castName1: 'Misha Green',
              jobName1: 'Writer',
              castName2: 'Peter Craig',
              jobName2: 'Writer'),
        ],
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

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
            onPressed: () {},
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: RadialPercentWidget(
                    percent: 72,
                    lineWidth: 5,
                    fillColor: Color.fromARGB(255, 10, 23, 25),
                    freeColor: Color.fromARGB(255, 25, 54, 31),
                    lineColor: Color.fromARGB(255, 37, 203, 103),
                  ),
                ),
                SizedBox(width: 20),
                Text('User Score'),
              ],
            )),
        Container(width: 1, height: 15, color: Colors.grey),
        TextButton(
            onPressed: () {},
            child: Row(
              children: [
                Icon(Icons.play_arrow),
                Text('Play Trailer'),
              ],
            )),
      ],
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

class _OverviewHeaderWidget extends StatelessWidget {
  const _OverviewHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        'Overview',
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _OverviewContentWidget extends StatelessWidget {
  const _OverviewContentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        'A deadly female assassin comes out of hiding to protect the daughter that she gave up years before, while on the run from dangerous men.',
        maxLines: 4,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class _CastWidget extends StatelessWidget {
  String castName1 = '';
  String castName2 = '';
  String jobName1 = '';
  String jobName2 = '';
  _CastWidget({
    super.key,
    required this.castName1,
    required this.castName2,
    required this.jobName1,
    required this.jobName2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  castName1,
                  style: nameStye,
                ),
                Text(
                  jobName1,
                  style: jobTitleStye,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  castName2,
                  style: nameStye,
                ),
                Text(
                  jobName2,
                  style: jobTitleStye,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
