// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Description extends StatefulWidget {
  final String name, description, bannerUrl, posterUrl, vote, lDate;
 
    Description(
      {Key key,
      @required this.name,
      @required this.description,
      @required this.bannerUrl,
      @required this.posterUrl,
      @required this.vote,
      @required this.lDate,
      })
      : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name ?? "no data"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            Container(
              height: 250,
              child: Stack(
                children: [
                  Positioned(
                      child: Container(
                    height: 250,
                    child:
                        Image.network(widget.bannerUrl, fit: BoxFit.fill) ??
                            Image.asset('assets/placeholder_image.png'),
                  )),
                  Positioned(
                    bottom: 2,
                    child: Container(
                      margin: EdgeInsets.all(3),
                      padding: EdgeInsets.all(3),
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      child: Text(
                          "Average Rating : " + widget.vote ?? "no rating",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.name ?? "Loading",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("🗓️ Release Date : " + widget.lDate ?? "no data",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          
            SizedBox(
              height: 10,
            ),
            Container(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                    height: 200,
                    image: NetworkImage(
                      widget.posterUrl ??
                          AssetImage('assets/placeholder_image.png'),
                    )),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: Text(
                  widget.description ?? "no data",
                  style: TextStyle(fontSize: 20),
                ))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
