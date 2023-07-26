// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, non_constant_identifier_names, prefer_final_fields
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movies_database/pages/movies/Description.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TrendingPage extends StatefulWidget {
  final List trendingResults;
  final List Upcoming;
  final List TopRatedMovies;
  final List TopRated;

  TrendingPage(
      {Key key,
      this.trendingResults,
      this.Upcoming,
      this.TopRated,
      this.TopRatedMovies})
      : super(key: key);

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // Simulate fetching new data (replace this with your actual data fetching logic)
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      // Update the list with new data
      // For example: widget.trendingResults = fetchedData;
    });
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Trending",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 350,
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  height: 400,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {}); // Trigger a rebuild on page change
                  },
                ),
                items: widget.trendingResults.map((item) {
                  // Background image parallax effect
                  bool isSelected = widget.trendingResults.indexOf(item) == 0;
                  double scale = isSelected ? 1.0 : 1.0;
                  return Transform.scale(
                    scale: scale,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return Description(
                                  name: item['title'],
                                  description: item['overview'],
                                  bannerUrl: 'https://image.tmdb.org/t/p/w500' +
                                      item['backdrop_path'],
                                  posterUrl: 'https://image.tmdb.org/t/p/w500' +
                                      item['poster_path'],
                                  vote: item['vote_average'].toString(),
                                  lDate: item['release_date'].toString(),
                                );
                              },
                            ));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 250,
                            width: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500' +
                                          item['backdrop_path']
                                          ),
                                  fit: BoxFit.fitHeight),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(item['original_title'] ?? "Loading...",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.center)
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            Divider(height: 20),
            Text(
              "Upcoming Movies",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 270,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                scrollDirection: Axis.horizontal,
                itemCount: widget.trendingResults.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    setState(() {});

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext dialogContext) => Description(
                          name: widget.Upcoming[index]['title'],
                          description: widget.Upcoming[index]['overview'],
                          bannerUrl: 'https://image.tmdb.org/t/p/w500' +
                              widget.Upcoming[index]['backdrop_path'],
                          posterUrl: 'https://image.tmdb.org/t/p/w500' +
                              widget.Upcoming[index]['poster_path'],
                          vote:
                              widget.Upcoming[index]['vote_average'].toString(),
                          lDate:
                              widget.Upcoming[index]['release_date'].toString(),
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
                                    widget.Upcoming[index]['poster_path']),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 140,
                        child: Text(
                            widget.Upcoming[index]['original_title'] ??
                                "Loading...",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.center),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Divider(height: 20),
            Text(
              "Top Rated Movies",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
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
                          description: widget.TopRated[index]['overview'],
                          bannerUrl: 'https://image.tmdb.org/t/p/w500' +
                              widget.TopRated[index]['backdrop_path'],
                          posterUrl: 'https://image.tmdb.org/t/p/w500' +
                              widget.TopRated[index]['poster_path'],
                          vote:
                              widget.TopRated[index]['vote_average'].toString(),
                          lDate:
                              widget.TopRated[index]['release_date'].toString(),
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
                            textAlign: TextAlign.center),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Divider(height: 20),
            Text(
              "Popular Movies",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
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
                          description: widget.TopRatedMovies[index]['overview'],
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
                                    widget.TopRatedMovies[index]
                                        ['poster_path']),
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
                            textAlign: TextAlign.center),
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
