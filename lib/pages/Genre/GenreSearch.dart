// ignore_for_file: prefer_interpolation_to_compose_strings, duplicate_ignore

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:tmdb_api/tmdb_api.dart';

import '../movies/Description.dart';

class GenreSearch extends StatefulWidget {
  String GenreID;
  String GenreName;
  GenreSearch({Key key, @required this.GenreID, @required this.GenreName})
      : super(key: key);

  @override
  State<GenreSearch> createState() => _GenreSearchState();
}

class _GenreSearchState extends State<GenreSearch> {
  List GenreSearch = [];
  final String _apiKey = "<YOUR_API_KEY>";
  final String _apiReadAccessTokenv =
      "<YOUR_READ_ACCESS_TOKEN>";
  loadGenre() async {
    String genreId = "";
    setState(() {
      genreId = widget.GenreID.toString();
    });
    final tmdb = TMDB(ApiKeys(_apiKey, _apiReadAccessTokenv));
    logConfig:
    const ConfigLogger(showErrorLogs: true, showLogs: true);
    Map genreMovie = await tmdb.v3.discover.getMovies(withGenres: "$genreId");

    print(genreMovie);

    setState(() {
      GenreSearch = genreMovie["results"];
    });
  }

  @override
  void initState() {
    loadGenre();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results for ${widget.GenreName}"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
           physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: GenreSearch.length,
          itemBuilder: (context, index) => InkWell(
            // ignore: void_checks
            onTap: () {
              return Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Description(
                    name: GenreSearch[index]["title"],
                    description: GenreSearch[index]['overview'],
                    // ignore: prefer_interpolation_to_compose_strings
                    bannerUrl: 'https://image.tmdb.org/t/p/w500' +
                        GenreSearch[index]['backdrop_path'],
                    posterUrl: 'https://image.tmdb.org/t/p/w500' +
                        GenreSearch[index]['poster_path'],
                    vote: GenreSearch[index]['vote_average'].toString(),
                    lDate: GenreSearch[index]['release_date'].toString(),
                  );
                },
              ));
            },
            child: Container(
              child: Row(
                children: [
                  Container(
                    height: 200,
                    padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                    child: CachedNetworkImage(
                      imageUrl: 'https://image.tmdb.org/t/p/w500' +
                          GenreSearch[index]['poster_path'],
                            imageBuilder: (context, imageProvider) => Container(
                        width: 140,
                        
                        decoration: BoxDecoration(
                          
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      
                      placeholder:(context, url) => const CircularProgressIndicator.adaptive(
                       
                        
                      ),
                          
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Column(
                    
                    children: <Widget>[
                      Center(
                        child: Container(
                      
                          width: 200,
                          child: Text(
                            GenreSearch[index]["title"],
                            softWrap: true,
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        " ⭐ ${GenreSearch[index]["vote_average"]}",
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
