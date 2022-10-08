import 'package:story_view/story_view.dart';
import 'package:flutter/material.dart';

class StoryPageView extends StatefulWidget {
  const StoryPageView({Key key}) : super(key: key);

  @override
  _StoryPageViewState createState() => _StoryPageViewState();
}

class _StoryPageViewState extends State<StoryPageView> {
  @override
  final controller = StoryController();
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Stack(
          children: <Widget>[
            StoryView(
              storyItems: [
                StoryItem.text(
                    title:
                        '➡️Features to be added: \n\n\nFollowing mechanism\nAdding caption to photos\nLike storing system\nModifications to chat screen\nA settings page\nEdit profile page\nUpdating Stories\n\n\n 🙂🙂',
                    backgroundColor: Colors.redAccent,
                    textStyle: TextStyle(
                        height: 1.5,
                        fontFamily: 'Metropolis',
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                StoryItem.pageImage(
                    url:
                        'https://i.pinimg.com/originals/a4/f8/f9/a4f8f91b31d2c63a015ed34ae8c13bbd.jpg',
                    controller: controller)
              ],
              controller: controller,
              inline: false,
              repeat: false,
            ),
            Positioned.fill(
                top: 20,
                right: 10,
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
