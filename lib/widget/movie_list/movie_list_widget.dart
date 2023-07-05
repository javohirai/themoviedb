import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:themoviedb/utils/images.dart';

class Movie {
  int id;
  String image;
  String name;
  String date;
  String year;
  String description;

  Movie(
      {required this.id,
      required this.image,
      required this.name,
      required this.date,
      required this.year,
      required this.description});
}

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({super.key});

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final List<Movie> _movieList = [
    Movie(
      id: 0,
      image: 'images/test.jpg',
      name: 'The Pope\'s Exorcist',
      date: 'April  5, 2023',
      year: '2023',
      description:
          'Father Gabriele Amorth, Chief Exorcist of the Vatican, investigates a young',
    ),
    Movie(
      id: 1,
      image: 'images/test.jpg',
      name: 'Ant-Man and the Wasp: Quantumania',
      year: '2023',
      date: 'February 15, 2023',
      description:
          'Super-Hero partners Scott Lang and Hope van Dyne, along with with Hope\'s parents Janet van Dyne and Hank Pym',
    ),
    Movie(
      id: 2,
      image: 'images/test.jpg',
      name: 'The Super Mario Bros. Movie',
      year: '2023',
      date: 'April  5, 2023',
      description:
          'While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world',
    ),
    Movie(
      id: 2,
      year: '2023',
      image: 'images/test.jpg',
      name: 'Guardians of the Galaxy Volume 3',
      date: 'May  3, 2023',
      description:
          'Peter Quill, still reeling from the loss of Gamora, must rally his team around him to defend the universe along with protecting one of their own. A mission that',
    ),
    Movie(
      id: 3,
      image: 'images/test.jpg',
      name: 'Ghosted',
      year: '2023',
      date: 'April  18, 2023',
      description:
          'Salt-of-the-earth Cole falls head over heels for enigmatic Sadie — but then makes the shocking discovery that s',
    ),
  ];

  List<Movie> _filteredMovieList = [];

  void _searchMovie() {
    var query = _searchController.text;
    if (query.isNotEmpty) {
      _filteredMovieList = _movieList.where((element) {
        return element.name.toLowerCase().startsWith(query);
      }).toList();
    } else {
      _filteredMovieList = _movieList;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _filteredMovieList = _movieList;
    _searchController.addListener(_searchMovie);
  }

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.only(top: 70),
            itemCount: _filteredMovieList.length,
            itemExtent: 163,
            itemBuilder: (BuildContext context, int index) {
              final movie = _filteredMovieList[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black.withOpacity(0.2)),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 2))
                    ],
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Image(image: AssetImage(movie.image)),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Text(
                                  movie.name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  movie.date,
                                  style: TextStyle(color: Colors.grey),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 15),
                                Text(
                                  movie.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              '/movie_list/movie_widget',
                              arguments: movie,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withAlpha(235),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              labelText: 'Search',
            ),
          ),
        ),
      ],
    );
  }
}
