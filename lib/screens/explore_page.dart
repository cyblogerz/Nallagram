import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nallagram/screens/profilelist_page.dart';
import 'dart:math';
import 'package:toast/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nallagram/screens/postView_model.dart';

final _store = FirebaseFirestore.instance;

class Explore extends StatelessWidget {
//   @override
//   _ExploreState createState() => _ExploreState();
// }

// class _ExploreState extends State<Explore> {

  List<Color> _colors = [
    Colors.red,
    Colors.pink,
    Colors.blue,
    Colors.purple,
    Colors.deepPurple,
    Colors.teal,
    Colors.indigo,
    Colors.cyan,
  ];
  cgen(List<Color> nlis) {
    return nlis.elementAt(Random().nextInt(nlis.length));
  }

  Widget picPost(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Image.network(
        url,
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget tagBuild(String tag, Color color) {
      return GestureDetector(
        onTap: () {
          Toast.show("This feature will be available soon!", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        },
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: color,
          shadowColor: color,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: Text(
              '$tag',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Metropolis',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          elevation: 20.0,
        ),
      );
    }

    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileList()));
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            height: 50.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.grey.shade400,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Search',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Metropolis',
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.search),
                ),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              tagBuild('Travel', Colors.pink),
              tagBuild('Architecture', Colors.blue),
              tagBuild('Travel', Colors.orange),
              tagBuild('Technology', Colors.red),
              tagBuild('Flutter', cgen(_colors)),
              tagBuild('Python', cgen(_colors)),
              tagBuild('Reactjs', cgen(_colors)),
              tagBuild('Business', cgen(_colors)),
              tagBuild('Design', cgen(_colors)),
              tagBuild('Fashion', cgen(_colors)),
              tagBuild('Music', cgen(_colors)),
            ],
          ),
        ),
        // SizedBox(
        //   height: 20.0,
        // ),

        PostsStream(),
      ],
    );
  }
}

class ImageBox extends StatelessWidget {
  final imageUrl;
  ImageBox({@required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => POstView(imageUrl)));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.red.shade100,
          image: DecorationImage(
              image: CachedNetworkImageProvider(imageUrl), fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class PostsStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _store.collection('posts').snapshots(),
      builder: (context, snapshot) {
        List<ImageBox> imageBoxes = [];
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlue,
            ),
          );
        }
        final images = snapshot.data.docs;

        for (var image in images) {
          final url = image['url'];
          final gridItem = ImageBox(
            imageUrl: url,
          );
          imageBoxes.add(gridItem);
        }
        return Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            padding: EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: imageBoxes,
          ),
        );
      },
    );
  }
}
