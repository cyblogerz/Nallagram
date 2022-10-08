import 'package:flutter/material.dart';

import 'package:nallagram/screens/blog/blog_view.dart';

class BlogElement extends StatelessWidget {
  BlogElement({
    @required this.title,
    @required this.comments,
    @required this.time,
    @required this.image,
    @required this.text,
    @required this.author,
    @required this.tagColor,
    @required this.tagName,
  });
  final String title;
  final String image;
  final Color tagColor;
  final String tagName;

  final String text;
  final String time;
  final String author;
  final int comments;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlogView(
                      tName: tagName,
                      tColor: tagColor,
                      title: title,
                      img: image,
                      author: author,
                      time: time,
                      comments: comments,
                      tdata: text,
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 10), // changes position of shadow
            ),
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      image: DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        decoration: BoxDecoration(
                            color: tagColor,
                            borderRadius: BorderRadius.circular(6)),
                        child: Text(
                          tagName,
                          style: TextStyle(
                              fontFamily: "Metropolis",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, bottom: 2.0, right: 4.0),
                                  child: Icon(Icons.schedule,
                                      color: Colors.grey, size: 20),
                                ),
                                Text(
                                  time,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 50.0),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 4.0),
                                    child: Icon(Icons.chat_bubble_outline,
                                        size: 20, color: Colors.grey),
                                  ),
                                  Text(
                                    comments.toString(),
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
