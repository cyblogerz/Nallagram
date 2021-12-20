import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

Widget tagBuild(String tag, Color color, context) {
  return GestureDetector(
    onTap: () {
      Toast.show("This feature will be available soon!", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    },
    child: Card(
      margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      color: color,
      shadowColor: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
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
