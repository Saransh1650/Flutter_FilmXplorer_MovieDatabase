// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

import 'Description.dart';

class TopRatedPage extends StatefulWidget {
  final List TopRated;
  final List TopRatedMovies;
  
  TopRatedPage({Key key, this.TopRated, this.TopRatedMovies}) : super(key: key);

  @override
  State<TopRatedPage> createState() => _TopRatedPageState();
}

class _TopRatedPageState extends State<TopRatedPage> {

 @override
  void initState() {
    print(widget.TopRated);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Top Rated Movies",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 270,
              child: ListView.builder(
                 physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                scrollDirection: Axis.horizontal,
                itemCount: widget.TopRated.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    setState(() {});

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext dialogContext) => Description(
                          name: widget.TopRated[index]['title'],
                          description: widget.TopRated[index]
                              ['overview'],
                          bannerUrl: 'https://image.tmdb.org/t/p/w500' +
                              widget.TopRated[index]['backdrop_path'],
                          posterUrl: 'https://image.tmdb.org/t/p/w500' +
                              widget.TopRated[index]['poster_path'],
                          vote: widget.TopRated[index]['vote_average']
                              .toString(),
                          lDate: widget.TopRated[index]['release_date']
                              .toString(),
                           
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        width: 140,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500' +
                                    widget.TopRated[index]['poster_path']),
                          ),
                        ),
                      ),
                      Container(
                        width: 140,
                        child: Text(
                          widget.TopRated[index]['title'] ?? "Loading",
                          style: TextStyle(fontSize: 18),
                          softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.center
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Text(
              "Popular Movies",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 270,
              child: ListView.builder(
                 physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                scrollDirection: Axis.horizontal,
                itemCount: widget.TopRatedMovies.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    setState(() {});

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext dialogContext) => Description(
                          name: widget.TopRatedMovies[index]['title'],
                          description: widget.TopRatedMovies[index]
                              ['overview'],
                          bannerUrl: 'https://image.tmdb.org/t/p/w500' +
                              widget.TopRatedMovies[index]['backdrop_path'],
                          posterUrl: 'https://image.tmdb.org/t/p/w500' +
                              widget.TopRatedMovies[index]['poster_path'],
                          vote: widget.TopRatedMovies[index]['vote_average']
                              .toString(),
                          lDate: widget.TopRatedMovies[index]['release_date']
                              .toString(),
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        width: 140,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500' +
                                    widget.TopRatedMovies[index]['poster_path']),
                          ),
                        ),
                      ),
                      Container(
                        width: 140,
                        child: Text(
                          widget.TopRatedMovies[index]['title'] ?? "Loading",
                          style: TextStyle(fontSize: 18),
                           softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.center
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
