import 'package:flutter/material.dart';

class BlogShrink {
  BlogShrink({
    @required this.tName,
    @required this.tColor,
    @required this.title,
    @required this.text,
    @required this.author,
    @required this.image,
    @required this.comments,
    @required this.time,
  });
  final String title;
  final String tName;
  final Color tColor;
  final String text;
  final String time;
  final String author;
  final String image;
  final int comments;
}

List<BlogShrink> allData = [
  BlogShrink(
    title: "Make systems people want to use",
    comments: 10,
    time: "5 mins ago",
    author: "Pranav Ajay",
    text:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    image:
        "https://cdn.dribbble.com/users/3807693/screenshots/16959518/media/921b60038850f869f8ed703e36b8382d.jpg",
    tColor: Colors.purple,
    tName: 'DESIGN',
  ),
  BlogShrink(
    title: "Make systems people want to use",
    tColor: Colors.purple,
    tName: 'DESIGN',
    comments: 10,
    time: "5 mins ago",
    author: "Pranav Ajay",
    text:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    image:
        "https://cdn.dribbble.com/users/3807693/screenshots/16959518/media/921b60038850f869f8ed703e36b8382d.jpg",
  ),
  BlogShrink(
    title: "Make systems people want to use",
    tColor: Colors.purple,
    tName: 'DESIGN',
    comments: 10,
    time: "5 mins ago",
    author: "Pranav Ajay",
    text:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    image:
        "https://cdn.dribbble.com/users/3807693/screenshots/16959518/media/921b60038850f869f8ed703e36b8382d.jpg",
  ),
  BlogShrink(
    title: "Make systems people want to use",
    tColor: Colors.purple,
    tName: 'DESIGN',
    comments: 10,
    time: "5 mins ago",
    author: "Pranav Ajay",
    text:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    image:
        "https://cdn.dribbble.com/users/3807693/screenshots/16959518/media/921b60038850f869f8ed703e36b8382d.jpg",
  ),
  BlogShrink(
    title: "Make systems people want to use",
    tColor: Colors.purple,
    tName: 'DESIGN',
    comments: 10,
    time: "5 mins ago",
    author: "Pranav Ajay",
    text:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    image:
        "https://cdn.dribbble.com/users/3807693/screenshots/16959518/media/921b60038850f869f8ed703e36b8382d.jpg",
  ),
  BlogShrink(
    tColor: Colors.purple,
    tName: 'DESIGN',
    title: "Make systems people want to use",
    comments: 10,
    time: "5 mins ago",
    author: "Pranav Ajay",
    text:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    image:
        "https://cdn.dribbble.com/users/3807693/screenshots/16959518/media/921b60038850f869f8ed703e36b8382d.jpg",
  ),
];

// List<BlogShrink> popularData = [
//   BlogShrink(title: "t", likes: likes, comments: comments, date: date, views: views)
// ];
