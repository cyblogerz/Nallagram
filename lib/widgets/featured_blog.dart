import 'package:flutter/material.dart';

Widget featuredElement(BuildContext context) {
  return Column(children: <Widget>[
    Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        alignment: Alignment.bottomLeft,
        height: MediaQuery.of(context).size.height * 0.25,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          image: DecorationImage(
            image: NetworkImage(
                "https://cdn.dribbble.com/users/730703/screenshots/16787857/media/99fc22aa5c7c53e4d08b66e650f64a5a.jpg"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        "Here is what you need to know about DigiCupid",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 16),
      child: Row(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.schedule,
                color: Colors.grey,
                size: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "5 min ago",
                  style: TextStyle(color: Colors.black45),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.grey,
                  size: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "20",
                    style: TextStyle(color: Colors.black45),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  ]);
}
