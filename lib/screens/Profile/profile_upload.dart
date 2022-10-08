import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';

// import 'nav.dart';

final storage = FirebaseStorage.instance;
final store = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;
var rimage;
var imagePicker;
User user;

void uploadProfile(String url) async {
  user = auth.currentUser;
  user.updatePhotoURL(url);
}

enum ImageSourceType { gallery, camera }

void imageHandler(File image) async {
  var uploadTask =
      await storage.ref().child(basename(image.path)).putFile(image);
  if (uploadTask.state == TaskState.success) {
    final String downloadUrl = await uploadTask.ref.getDownloadURL();
    uploadProfile(downloadUrl);
  }
}

class UploadProfile extends StatefulWidget {
  @override
  State<UploadProfile> createState() => _UploadProfileState();
}

class _UploadProfileState extends State<UploadProfile> {
  // final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                CupertinoIcons.back,
                color: Colors.black,
              )),
          backgroundColor: Colors.white,
          title: Text(
            'Edit Profile',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              child: Container(
                // padding: EdgeInsets.fromLTRB(20.0, 20.0, 50.0, 10.0),
                child: TextButton(
                    onPressed: () async {
                      XFile image = await imagePicker.pickImage(
                        source: ImageSource.gallery,
                      );
                      setState(() {
                        if (image.path != null) {
                          rimage = File(image.path);
                        }
                      });
                      Navigator.pop(context);
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
                    onPressed: () async {
                      // _handleURLButtonPress(context, ImageSourceType.camera);
                      XFile image = await imagePicker.pickImage(
                        source: ImageSource.camera,
                      );
                      setState(() {
                        if (image.path != null) {
                          rimage = File(image.path);
                        }
                      });
                      Navigator.pop(context);
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
                      colors: [
                        Colors.purple,
                        Colors.deepPurple,
                        Colors.blueAccent
                      ],
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                    ),
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
