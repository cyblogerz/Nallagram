import 'package:story_view/story_view.dart';
import 'package:flutter/material.dart';
import 'nav.dart';

class StoryPageView extends StatefulWidget {
  const StoryPageView({Key key}) : super(key: key);

  @override
  _StoryPageViewState createState() => _StoryPageViewState();
}

class _StoryPageViewState extends State<StoryPageView> {
  @override
  final controller = StoryController();
  Widget build(BuildContext context) {
    return StoryView(
      storyItems: [
        StoryItem.text(title: 'Namaskaram', backgroundColor: Colors.redAccent),
        StoryItem.pageImage(url: 'https://i.pinimg.com/originals/a4/f8/f9/a4f8f91b31d2c63a015ed34ae8c13bbd.jpg', controller: controller)
      ],
      controller: controller,
      inline: false,
      repeat: false,
    );
  }
}
