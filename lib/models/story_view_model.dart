class StoryViewModel{
  final String name;
  final String img;

  StoryViewModel({this.name,this.img});

}

List<Map> _storyData = [
  {"john":"images/usr1.jfif"},
  {"ibram":"images/usr2.jfif"},
{"moedin":"images/usr3.jfif"},
  {"arunsmoki":"images/usr4.jfif"},
  {"mani":"images/usr5.jfif"},
  {"aniz":"images/usr6.jfif"},
  {"ramgov":"images/usr7.jfif"},
  {"edwin21":"images/usr8.jfif"},
  {"karthikks":"images/usr9.jfif"},
  {"peterpark":"images/usr10.jfif"},

];



List<StoryViewModel>StoryViewData = [
  StoryViewModel(name: _storyData[0].keys.toList()[0],img: _storyData[0].values.toList()[0]),
  StoryViewModel(name: _storyData[1].keys.toList()[0],img: _storyData[1].values.toList()[0]),
  StoryViewModel(name: _storyData[2].keys.toList()[0],img: _storyData[2].values.toList()[0]),
  StoryViewModel(name: _storyData[3].keys.toList()[0],img: _storyData[3].values.toList()[0]),
  StoryViewModel(name: _storyData[4].keys.toList()[0],img: _storyData[4].values.toList()[0]),
  StoryViewModel(name: _storyData[5].keys.toList()[0],img: _storyData[5].values.toList()[0]),
  StoryViewModel(name: _storyData[6].keys.toList()[0],img: _storyData[6].values.toList()[0]),
  StoryViewModel(name: _storyData[7].keys.toList()[0],img: _storyData[7].values.toList()[0]),
  StoryViewModel(name: _storyData[8].keys.toList()[0],img: _storyData[8].values.toList()[0]),
  StoryViewModel(name: _storyData[9].keys.toList()[0],img: _storyData[9].values.toList()[0]),

];

