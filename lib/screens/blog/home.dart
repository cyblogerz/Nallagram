import 'package:flutter/material.dart';
import 'package:nallagram/models/blog_shrink_model.dart';
import 'package:nallagram/widgets/blog_element.dart';
import 'package:nallagram/widgets/featured_blog.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: const CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blueGrey,
            ),
          ),
        ],
      ),
      drawer: const Drawer(),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                featuredElement(context),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, top: 34, bottom: 16),
                  child: Text(
                    "Popular",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return BlogElement(
                        title: allData[index].title,
                        comments: allData[index].comments,
                        author: allData[index].author,
                        time: allData[index].time,
                        text: allData[index].text,
                        image: allData[index].image,
                      );
                    }),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, top: 34, bottom: 16),
                  child: Text(
                    "Latest",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return BlogElement(
                        title: allData[index].title,
                        comments: allData[index].comments,
                        author: allData[index].author,
                        time: allData[index].time,
                        text: allData[index].text,
                        image: allData[index].image,
                      );
                    }),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, top: 34, bottom: 16),
                  child: Text(
                    "Discover",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // BlogElement()
        ],
      ),
    );
  }
}
