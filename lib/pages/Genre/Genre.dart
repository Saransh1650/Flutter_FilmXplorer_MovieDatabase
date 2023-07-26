// ignore_for_file: prefer_const_constructors

import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:movies_database/pages/Genre/GenreSearch.dart';

import 'package:tmdb_api/tmdb_api.dart';

class Genre extends StatefulWidget {
  const Genre({Key key}) : super(key: key);

  @override
  State<Genre> createState() => _GenreState();
}

class _GenreState extends State<Genre> {
  String genreName = "";
  String genre = "";
  final String _apiKey = "<YOUR_API_KEY>";
  final String _apiReadAccessTokenv =
      "<YOUR_ACCESS_READ_TOKEN>";
  List GM = [];
  List GT = [];

  loadGenre() async {
    final tmdb = TMDB(ApiKeys(_apiKey, _apiReadAccessTokenv));
    logConfig:
    const ConfigLogger(showErrorLogs: true, showLogs: true);
    Map genreMovie = await tmdb.v3.genres.getMovieList();
    Map genreTV = await tmdb.v3.genres.getTvlist();

    setState(() {
      GM = genreMovie['genres'];
    });

    print(GM);
  }

  @override
  void initState() {
    loadGenre();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              
              color: Colors.black38,
              child: Row(children: [
                Text(
                  " Search",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'Agne',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  child: DefaultTextStyle(
                    style: const TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'Agne',
                        fontWeight: FontWeight.bold),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Action',
                        ),
                        TypewriterAnimatedText(
                          'Crime',
                        ),
                        TypewriterAnimatedText(
                          'Documentary',
                        ),
                        TypewriterAnimatedText(
                          'Mystery',
                        ),
                        TypewriterAnimatedText(
                          'Thriller',
                        ),
                        TypewriterAnimatedText(
                          'Adventure',
                        ),
                        TypewriterAnimatedText(
                          'Documentary',
                        ),
                        TypewriterAnimatedText(
                          'And much more...',
                        ),
                      ],
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                  ),
                ),
              ]),
            ),
           
            Expanded(
              
              child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
            
                children: List.generate(GM.length, (index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        genre = GM[index]["id"].toString();
            
                        genreName = GM[index]["name"];
                      });
                      Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext dialogContext) {
                          return GenreSearch(
                            GenreID: genre,
                            GenreName: genreName,
                          );
                        },
                      ));
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        border: Border.all(width: 10),
                        color: Color.fromRGBO(
                          Random().nextInt(225),
                          Random().nextInt(225),
                          Random().nextInt(225),
                          0.3,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                          child: Text(
                        GM[index]['name'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
