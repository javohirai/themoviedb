import 'package:flutter/material.dart';
import 'package:themoviedb/widget/custom_widgets/custom_figure.dart';
import 'package:themoviedb/widget/movie_list/movie_list_widget.dart';

class MainScreenWidget extends StatefulWidget {
  MainScreenWidget({super.key});
  @override
  _MainScreenWidgetState createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 1;

  void onSelectTap(int index) {
    if (index == _selectedTab) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedTab,
        children: [
          CustomFigureWidget(),
          MovieListWidget(),
          Text('TV'),
        ],
      ),
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          child: Text(
            'TMDB',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Movie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'TV',
          ),
        ],
        onTap: onSelectTap,
      ),
    );
  }
}
