import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nallagram/widgets/SearchBox.dart';
import 'package:nallagram/widgets/ctag.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nallagram/screens/Posts/postView_model.dart';

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
    return Column(
      children: <Widget>[
        SearchBox(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              tagBuild('Travel', Colors.pink, context),
              tagBuild('Architecture', Colors.blue, context),
              tagBuild('Travel', Colors.orange, context),
              tagBuild('Technology', Colors.red, context),
              tagBuild('Flutter', cgen(_colors), context),
              tagBuild('Python', cgen(_colors), context),
              tagBuild('Reactjs', cgen(_colors), context),
              tagBuild('Business', cgen(_colors), context),
              tagBuild('Design', cgen(_colors), context),
              tagBuild('Fashion', cgen(_colors), context),
              tagBuild('Music', cgen(_colors), context),
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
