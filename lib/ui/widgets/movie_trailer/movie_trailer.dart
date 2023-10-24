import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieTrailerWidget extends StatefulWidget {
  final String trailerKey;
  const MovieTrailerWidget({super.key, required this.trailerKey});
  @override
  MovieTrailerWidgetState createState() => MovieTrailerWidgetState();
}

class MovieTrailerWidgetState extends State<MovieTrailerWidget> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.trailerKey,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final player = YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
    );
    return YoutubePlayerBuilder(
      builder: (p0, p1) => Scaffold(
        appBar: AppBar(title: Text('Trailer')),
        body: Center(child: player),
      ),
      player: player,
    );
  }
}
