// ignore_for_file: non_constant_identifier_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'movies/Description.dart';

class TV extends StatefulWidget {
  final List TVLatest, TVOnAir;

  // ignore: non_constant_identifier_names
  const TV({Key key, @required this.TVLatest, @required this.TVOnAir})
      : super(key: key);

  @override
  State<TV> createState() => _TVState();
}

class _TVState extends State<TV> {
@override
void initState() {
  super.initState();
  print(widget.TVOnAir);
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
                "Trending TV Shows",
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
                  items: widget.TVLatest.map((item) {
                    // Background image parallax effect
                    bool isSelected = widget.TVLatest.indexOf(item) == 0;
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
                                    name: item['original_name'],
                                    description: item['overview'],
                                    bannerUrl:
                                        'https://image.tmdb.org/t/p/w500' +
                                            item['backdrop_path'],
                                    posterUrl:
                                        'https://image.tmdb.org/t/p/w500' +
                                            item['poster_path'],
                                    vote: item['vote_average'].toString(),
                                    lDate: item['first_air_date'].toString(),
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
                                            item['backdrop_path']),
                                    fit: BoxFit.fitHeight),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(item['original_name'] ?? "Loading...",
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
                "Latest TV Shows",
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
                  itemCount: 10,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      setState(() {});

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext dialogContext) => Description(
                            name: widget.TVOnAir[index]['original_name'],
                            description: widget.TVOnAir[index]['overview'],
                            bannerUrl: 'https://image.tmdb.org/t/p/w500' +
                                widget.TVOnAir[index]['backdrop_path'],
                            posterUrl: 'https://image.tmdb.org/t/p/w500' +
                                widget.TVOnAir[index]['poster_path'],
                            vote: widget.TVOnAir[index]['vote_average']
                                .toString(),
                            lDate: widget.TVOnAir[index]['first_air_date']
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
                                      widget.TVOnAir[index]['poster_path']),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 140,
                          child: Text(
                              widget.TVOnAir[index]['original_name'] ??
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
            ],
          ),
        ));
  }
}
