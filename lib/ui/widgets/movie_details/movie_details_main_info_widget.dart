import 'package:themoviedb/Library/Widgets/Inherited/provider.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/entity/movie_details_credits.dart';
import 'package:themoviedb/ui/widgets/elements/radial_percent_widget.dart';
import 'package:flutter/material.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _TopPosterWidget(),
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: _MovieNameWidget(),
        ),
        const _ScoreWidget(),
        const _SummeryWidget(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: _OverviewWidget(),
        ),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: _DescriptionWidget(),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: const _PeopleWidgets(),
        ),
      ],
    );
  }

  Text _OverviewWidget() {
    return const Text(
      'Overview',
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieDetails =
        NotifierProvider.watch<MovieDetailsModel>(context)?.movieDetails;
    return Text(
      movieDetails?.overview ?? '',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final movieDetails = model?.movieDetails;
    final backdropPath = movieDetails?.backdropPath;
    final posterPath = movieDetails?.posterPath;
    return AspectRatio(
      aspectRatio: 390 / 219,
      child: Stack(
        children: [
          backdropPath != null
              ? Image.network(ApiClient.imageUrl(backdropPath))
              : SizedBox.shrink(),
          Positioned(
            top: 20,
            left: 20,
            bottom: 20,
            child: posterPath != null
                ? Image.network(ApiClient.imageUrl(posterPath))
                : SizedBox.shrink(),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              onPressed: () => model?.toggleFavorite(),
              icon: model?.isFavourite == true
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_outline),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieDetails =
        NotifierProvider.watch<MovieDetailsModel>(context)?.movieDetails;
    final title = movieDetails?.title;
    var year = movieDetails?.releaseDate?.year.toString();
    year = year != null ? ' ($year)' : '';
    return RichText(
      maxLines: 3,
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: year,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final movieDetails = model?.movieDetails;
    var voteAverage = movieDetails?.voteAverage ?? 0;
    voteAverage = voteAverage * 10;

    final videos = movieDetails?.videos.results.where(
        (element) => element.type == 'Trailer' && element.site == 'YouTube');
    final trailerKey = videos?.isNotEmpty == true ? videos?.first.key : null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: RadialPercentWidget(
                  percent: voteAverage / 100,
                  fillColor: const Color.fromARGB(255, 10, 23, 25),
                  lineColor: const Color.fromARGB(255, 37, 203, 103),
                  freeColor: const Color.fromARGB(255, 25, 54, 31),
                  lineWidth: 3,
                  child: Text(voteAverage.toStringAsFixed(0)),
                ),
              ),
              const SizedBox(width: 10),
              const Text('User Score'),
            ],
          ),
        ),
        Container(width: 1, height: 15, color: Colors.grey),
        trailerKey != null
            ? TextButton(
                onPressed: () => model?.openMovieTrailer(context, trailerKey),
                child: Row(
                  children: [
                    const Icon(Icons.play_arrow),
                    const Text('Play Trailer'),
                  ],
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}

class _SummeryWidget extends StatelessWidget {
  const _SummeryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    if (model == null) return SizedBox.shrink();
    final movieDetails = model.movieDetails;
    if (movieDetails == null) return SizedBox.shrink();
    final texts = <String>[];
    if (movieDetails.releaseDate != null) {
      texts.add(model.stringFromDate(movieDetails.releaseDate));
    }

    if (movieDetails.productionCountries.isNotEmpty) {
      texts.add('(${movieDetails.productionCountries.first.iso})');
    }
    texts.add(movieDetails.genres.map((e) => e.name).join(', '));

    final duration = movieDetails.runtime ?? 0;
    final hour = (duration / 60).floor();
    final minute = duration % 60;
    texts.add('${hour}h ${minute}m');
    // 'R, 04/29/2021 (US) 1h49m Action, Adventure, Thriller, War'
    return ColoredBox(
      color: Color.fromRGBO(22, 21, 25, 1.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 70),
        child: Text(
          texts.join(' '),
          maxLines: 3,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _PeopleWidgets extends StatelessWidget {
  const _PeopleWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model =
        NotifierProvider.watch<MovieDetailsModel>(context)?.movieDetails;
    if (model == null) return SizedBox.shrink();
    var crew = model.credits.crew;
    crew = crew.length > 4 ? crew.sublist(0, 4) : crew;
    final crewChunk = <List<Crew>>[];
    for (var i = 0; i < crew.length; i += 2) {
      crewChunk
          .add(crew.sublist(i, (i + 2 > crew.length) ? crew.length : i + 2));
    }

    return Column(
      children: crewChunk
          .map(
            (crews) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _PeopleRowWidget(
                crews: crews,
              ),
            ),
          )
          .toList(),
    );
  }
}

class _PeopleRowWidget extends StatelessWidget {
  final List<Crew> crews;
  const _PeopleRowWidget({super.key, required this.crews});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.max,
        children: crews
            .map(
              (crew) => Expanded(
                child: _PeopleRowItemWidget(
                  crew: crew,
                ),
              ),
            )
            .toList());
  }
}

const nameStyle = TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.w400,
);
const jobTilteStyle = TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.w400,
);

class _PeopleRowItemWidget extends StatelessWidget {
  final Crew crew;
  const _PeopleRowItemWidget({super.key, required this.crew});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(crew.name, style: nameStyle),
        Text(crew.job, style: jobTilteStyle),
      ],
    );
  }
}
