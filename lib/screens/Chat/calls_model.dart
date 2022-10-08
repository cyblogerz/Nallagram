import 'package:flutter/material.dart';

class CallsModel extends StatefulWidget {
  final dynamic icon;
  final String type;
  final String typeDescription;
  const CallsModel({
    Key key,
    this.icon,
    this.type,
    this.typeDescription,
  }) : super(key: key);

  @override
  State<CallsModel> createState() => _CallsModelState();
}

class _CallsModelState extends State<CallsModel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: CircleAvatar(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
              radius: 26,
              child: Icon(
                widget.icon,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.type,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Metropolis'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    widget.typeDescription,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Metropolis',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
