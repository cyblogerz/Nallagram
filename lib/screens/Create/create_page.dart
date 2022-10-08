import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';

import '../../nav.dart';

final storage = FirebaseStorage.instance;
final store = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;

User user;

void publishPosts(String place, String posturl) async {
  user = auth.currentUser;

  await store.collection('posts').add({
    'likes': 0,
    'userid': user.uid,
    'name': user.displayName,
    'place': place,
    'profilepicurl': user.photoURL,
    'url': posturl,
    'timestamp': FieldValue.serverTimestamp(),
  });
}

void addUserposts(String place, String posturl) async {
  await store.collection('users').doc(user.uid).collection('posts').add({
    'likes': 0,
    'userid': user.uid,
    'name': user.displayName,
    'place': place,
    'profilepicurl': user.photoURL,
    'url': posturl,
    'timestamp': FieldValue.serverTimestamp(),
  });
}

enum ImageSourceType { gallery, camera }

void ImageHandler(File image) async {
  var UploadTask =
      await storage.ref().child(basename(image.path)).putFile(image);
  if (UploadTask.state == TaskState.success) {
    final String DownloadUrl = await UploadTask.ref.getDownloadURL();

    publishPosts('India', DownloadUrl);
    addUserposts('India', DownloadUrl);
  }
}

class Create extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();
  void _handleURLButtonPress(BuildContext context, var type) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ImageFromGalleryEx(type)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
          child: Container(
            // padding: EdgeInsets.fromLTRB(20.0, 20.0, 50.0, 10.0),
            child: TextButton(
                onPressed: () {
                  _handleURLButtonPress(context, ImageSourceType.gallery);
                },
                child: Text(
                  'Upload from Gallery',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Metropolis',
                      fontWeight: FontWeight.bold),
                )),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pink, Colors.redAccent, Colors.orange],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
                borderRadius: BorderRadius.circular(20.0)),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
          child: Container(
            // padding: EdgeInsets.fromLTRB(20.0, 20.0, 50.0, 10.0),
            child: TextButton(
                onPressed: () {
                  _handleURLButtonPress(context, ImageSourceType.camera);
                },
                child: Text(
                  'Open Camera',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Metropolis',
                      fontWeight: FontWeight.bold),
                )),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.deepPurple, Colors.blueAccent],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
                borderRadius: BorderRadius.circular(20.0)),
          ),
        ),
      ],
    );
  }
}

class ImageFromGalleryEx extends StatefulWidget {
  final type;
  ImageFromGalleryEx(this.type);

  @override
  ImageFromGalleryExState createState() => ImageFromGalleryExState(this.type);
}

class ImageFromGalleryExState extends State<ImageFromGalleryEx> {
  var _image;
  var imagePicker;
  var type;

  ImageFromGalleryExState(this.type);

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(type == ImageSourceType.camera
              ? "Image from Camera"
              : "Image from Gallery")),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 52,
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                var source = type == ImageSourceType.camera
                    ? ImageSource.camera
                    : ImageSource.gallery;
                XFile image = await imagePicker.pickImage(
                  source: source,
                );
                setState(() {
                  if (image.path != null) {
                    _image = File(image.path);
                  } else if (image.path == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Sending Message"),
                    ));
                  }
                });
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.red[200],
                    borderRadius: BorderRadius.circular(32)),
                child: _image != null
                    ? Image.file(
                        _image,
                        width: 200.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.circular(32),
                        ),
                        width: 200,
                        height: 200,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                        ),
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 46.0),
            child: ElevatedButton(
                onPressed: () {
                  ImageHandler(_image);
                  Navigator.pushNamed(context, Nav.id);
                },
                child: Text('Done')),
          )
        ],
      ),
    );
  }
}
