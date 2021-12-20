import 'package:flutter/material.dart';

class BlogView extends StatelessWidget {
  const BlogView(
      {@required this.title,
      @required this.tdata,
      @required this.comments,
      @required this.img,
      @required this.author,
      @required this.time});
  final String title;
  final String tdata;
  final int comments;
  final String img;
  final String author;
  final String time;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back)),
        ),
        body: ListView(padding: EdgeInsets.only(top: 0.0), children: <Widget>[
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.50,
            decoration: BoxDecoration(
              image:
                  DecorationImage(image: NetworkImage(img), fit: BoxFit.cover),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: <Widget>[],
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(32)),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 12,
                              backgroundImage: NetworkImage(
                                  "https://cdn.dribbble.com/users/2598141/screenshots/9393397/media/9a0b0c792552f4bc010bbf245cdadbfc.png?compress=1&resize=800x600"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                author,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: Colors.grey,
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.chat_bubble_outline,
                              color: Colors.black,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                comments.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  tdata,
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
              ],
            ),
          ),
        ]),
        extendBodyBehindAppBar: true,
      ),
    );
  }
}
