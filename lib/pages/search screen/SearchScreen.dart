// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:movies_database/pages/search%20screen/search_results.dart';

import '../movies/Description.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String search = "";
  String query = "query";
  Map data;
  List movies = [];
  int currentPage = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Listen for scroll events
  }

  final dio = Dio();

  void fetchMovies() async {
    movies.clear();

    try {
      final res = await dio.get(
        "https://api.themoviedb.org/3/search/movie",
        queryParameters: {
          "query": search,
          "api_key": "<YOUR_API_KEY>",
        },
      );
      Map data = res.data;
      print(data['results']);
      setState(() {
        movies = data['results'];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
                child: TextField(
              keyboardAppearance: Brightness.dark,
              keyboardType: TextInputType.text,
              enableSuggestions: true,
              autofocus: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Search for Your favorite Movie',
                  alignLabelWithHint: true,
                  hintText: "Spider-Man",
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  icon: Icon(Icons.movie)),
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
            )),
            ElevatedButton(
                onPressed: () {
                  if(movies.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text("Sorry, no data available for this movie, try using spaces and '-'s"),
                      ),
                    );
                  }
                  fetchMovies();
                },
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(8),
                    enableFeedback: true,
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                child: Text('Search')),
            Expanded(
              flex: 5,
              child: Builder(
                builder: (context) {
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.black,
                    ),
                    padding: EdgeInsets.all(10),
                    // Assign the ScrollController to the ListView.builder
                    scrollDirection: Axis.vertical,
                    itemCount: movies.length.toInt(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          
                           if (movies[index]['original_title'] != null &&
                              movies[index]['overview'] != null &&
                              movies[index]['backdrop_path'] != null &&
                              movies[index]['poster_path'] != null &&
                              movies[index]['vote_average'] != null &&
                              movies[index]['release_date'] != null) {
                            try {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext dialogContext) =>
                                      Description(
                                    name: movies[index]['original_title'],
                                    description: movies[index]['overview'],
                                    bannerUrl:
                                        'https://image.tmdb.org/t/p/w500' +
                                            movies[index]['backdrop_path'],
                                    posterUrl:
                                        'https://image.tmdb.org/t/p/w500' +
                                            movies[index]['poster_path'],
                                    vote: movies[index]['vote_average']
                                        .toString(),
                                    lDate: movies[index]['release_date']
                                        .toString(),
                                  ),
                                ),
                              );
                            } catch (e) {
                              print(e);
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Sorry, no data available for this movie"),
                              ),
                            );
                          }
                        },
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    movies[index]['original_title'],
                                    style: TextStyle(fontSize: 25),
                                  ),
                                )
                              ],
                            ),

                            // Your movie item widgets here
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
