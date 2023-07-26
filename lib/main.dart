// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:movies_database/pages/genre/Genre.dart';
import 'package:movies_database/pages/movies/trending.dart';
import 'package:movies_database/pages/search%20screen/SearchScreen.dart';
import 'package:movies_database/pages/TV.dart';
import 'package:splashscreen/splashscreen.dart';


import 'package:tmdb_api/tmdb_api.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';



void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({
    Key key,
  }) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

//lists of movies
  List Trending_List = [];
  List OnAirList = [];
  List Top_Rated_List = [];
  List Latest = [];
  List Upcoming = [];
  List PopularMovies = [];
  List TVlatest = [];
  List PopularTv = [];

//config articles
  final String api_key = "<YOUR_API_KEY>";
  final String read_access_token =
      "<YOUR_READ_ACCESS_TOKEN>";

  LoadMovies() async {
    final tmdbWithCustomLogs = TMDB(ApiKeys(api_key, read_access_token));
    logConfig:
    const ConfigLogger(showErrorLogs: true, showLogs: true);
    Map trendingResults = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map popularResults = await tmdbWithCustomLogs.v3.tv.getAiringToday();
    Map topRatedResults = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map upcoming = await tmdbWithCustomLogs.v3.movies.getUpcoming();
    Map popularMovies = await tmdbWithCustomLogs.v3.movies.getPopular();
    Map tvLatest = await tmdbWithCustomLogs.v3.tv.getTopRated();
   

    setState(() {
      Trending_List = trendingResults["results"];

      OnAirList = popularResults["results"];

      Top_Rated_List = topRatedResults["results"];
      Upcoming = upcoming["results"];
      PopularMovies = popularMovies["results"];
      TVlatest = tvLatest["results"];
    });
  }

  @override
  void initState() {
    super.initState();
    LoadMovies();
  

    _pageController = PageController();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: Text("FilmXplorer", style: TextStyle(fontWeight: FontWeight.bold),), elevation: 0),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              TrendingPage(
                  trendingResults: Trending_List,
                  Upcoming: Upcoming,
                  TopRated: Top_Rated_List,
                  TopRatedMovies: PopularMovies),
              SearchScreen(),
              TV(TVLatest: TVlatest, TVOnAir: OnAirList),
              Genre()
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          onItemSelected: (index) {
            setState(() => _currentIndex = index);
            _pageController.jumpToPage(index);
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                title: Text(
                  'Movies',
                  textAlign: TextAlign.center,
                ),
                icon: Icon(Icons.movie_filter_sharp)),
            BottomNavyBarItem(
                title: Text('Search', textAlign: TextAlign.center),
                icon: Icon(Icons.manage_search)),
            BottomNavyBarItem(
                title: Text('Television', textAlign: TextAlign.center),
                icon: Icon(Icons.tv)),
            BottomNavyBarItem(
                title: Text('Genre', textAlign: TextAlign.center),
                icon: Icon(Icons.view_carousel_rounded)),
          ],
        ),
      ),
    );
  }
}
