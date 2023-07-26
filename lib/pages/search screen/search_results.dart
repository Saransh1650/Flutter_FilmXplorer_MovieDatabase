import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search_Results extends StatefulWidget {
  String getSearch;

  Search_Results({Key key, this.getSearch}) : super(key: key);

  @override
  State<Search_Results> createState() => _Search_ResultsState();
}

class _Search_ResultsState extends State<Search_Results> {
  String search;
  String query = "query";
  Map data;
  List movies = [];
  int currentPage = 1;
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    search = widget.getSearch.toString();
    _scrollController.addListener(_onScroll); // Listen for scroll events
    fetchMovies();
  }

  @override
  void dispose() {
    _scrollController
        .dispose(); // Dispose of the ScrollController when not needed
    super.dispose();
  }

  void _onScroll() {
    // Check if the user has scrolled to the end of the list
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      fetchMovies(); // Load more data when reaching the end of the list
    }
  }

  final dio = Dio();

  void fetchMovies() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
      print(movies.length);
    });

    try {
      final res = await dio.get(
        "https://api.themoviedb.org/3/search/movie",
        queryParameters: {
          "query": search,
          "api_key": "<YOUR_API_KEY>",
          "page": currentPage,
        },
      );
      Map data = res.data;
      print(data['results']);
      setState(() {
        if (currentPage == 1) {
          movies = data['results'];
        } else {
          movies.addAll(data['results']);
        }
        currentPage++;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Search results for $search"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.back_hand))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,

                controller:
                    _scrollController, // Assign the ScrollController to the ListView.builder
                scrollDirection: Axis.vertical,
                itemCount: movies.length.toInt(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Row(
                          children: [
                            
                            Container(
                              child: Text(movies[index]['original_title']),
                            )
                          ],
                        ),

                        // Your movie item widgets here
                      ],
                    ),
                  );
                },
              ),
            ),
            if (isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
