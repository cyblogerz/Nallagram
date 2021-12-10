import 'package:flutter/material.dart';
import 'dart:math';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

class Activity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ListTile _followList(int num, String name, String place) {
      return ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('images/usr$num.jfif'),
          radius: 28.0,
        ),
        title: Text(
          name,
          style: TextStyle(
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
        subtitle: Text(
          place,
          style: TextStyle(
            fontFamily: 'Metropolis',
            fontSize: 12.0,
          ),
        ),
        trailing: IconButton(
          icon: FaIcon(
            FontAwesomeIcons.userPlus,
            color: Colors.blueAccent,
            size: 19.0,
          ),
        ),
        onTap: () {
          Toast.show("Following list updated!", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        },
      );
    }

    return ListView(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Card(
                margin: EdgeInsets.fromLTRB(10.0, 20.0, 3.0, 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 30.0,
                shadowColor: Colors.pink,
                child: Container(
                  padding: EdgeInsets.fromLTRB(15.0, 20.0, 50.0, 15.0),
                  height: 101.0,
                  width: 169.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'New Followers',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Metropolis',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Last 7 days',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Metropolis',
                            fontSize: 10.0),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        '265',
                        style: TextStyle(
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.white),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.pink, Colors.redAccent, Colors.orange],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                      ),
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
            //Todo: Randomise Profile pics
            //Todo: Randomise Network images
            Expanded(
              child: Card(
                margin: EdgeInsets.fromLTRB(8.0, 20.0, 10.0, 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 30.0,
                shadowColor: Colors.blue,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 50.0, 10.0),
                  height: 101.0,
                  width: 162.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Unfollowed',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Metropolis',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Last 7 days',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Metropolis',
                            fontSize: 10.0),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        '82',
                        style: TextStyle(
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.white),
                      )
                    ],
                  ),
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
            ),
          ],
        ),
        _followList(Random().nextInt(10) + 1, 'Harris', 'Enathu'),
        _followList(Random().nextInt(10) + 1, 'Rahul', 'India'),
        _followList(Random().nextInt(10) + 1, 'Mani', 'Los Angeles'),
        _followList(Random().nextInt(10) + 1, 'Rajpal', 'Newzealand'),
        _followList(Random().nextInt(10) + 1, 'Kim jung', 'Trivandrum'),
        _followList(Random().nextInt(10) + 1, 'Gregory', 'Adoor'),
        _followList(Random().nextInt(10) + 1, 'Rahul', 'New York'),
        _followList(Random().nextInt(10) + 1, 'Devis', 'Kerala'),
        _followList(Random().nextInt(10) + 1, 'Ram', 'Jammu'),
        _followList(Random().nextInt(10) + 1, 'Edwin', 'India'),
        _followList(Random().nextInt(10) + 1, 'Aswathy', 'Kovalam'),
        _followList(Random().nextInt(10) + 1, 'Pranav', 'Thiruvalla'),
        _followList(Random().nextInt(10) + 1, 'Aswin', 'Pala'),
        _followList(Random().nextInt(10) + 1, 'Devu', 'Chenganoor'),
        _followList(Random().nextInt(10) + 1, 'Prakash', 'MAnnady'),
        _followList(Random().nextInt(10) + 1, 'Athul', 'Korea'),
        _followList(Random().nextInt(10) + 1, 'Rajiv', 'Washington'),
        _followList(Random().nextInt(10) + 1, 'Mohanlal', 'AbuDhabi'),
        _followList(Random().nextInt(10) + 1, 'Sethupathi', 'Heaven'),
      ],
    );
  }
}
