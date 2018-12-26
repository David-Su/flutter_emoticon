import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Center(child: Center(child: EmoticonPage('panxinghua的表情包'))),
    );
  }
}

class Choice {
  final String title;
  final IconData icon;
  final List<String> pics;

  const Choice(this.title, this.icon, this.pics);
}

const List<Choice> choices = const <Choice>[
  Choice("吃货企鹅", Icons.face, penguinsPics),
  Choice("啊盖", Icons.face, aGaiPics),
];

const List<String> penguinsPics = const <String>[
  'images/penguin/01.gif',
  'images/penguin/02.gif',
  'images/penguin/03.gif',
  'images/penguin/04.gif',
  'images/penguin/05.gif',
  'images/penguin/06.gif',
  'images/penguin/07.gif',
  'images/penguin/08.gif',
  'images/penguin/09.gif',
  'images/penguin/10.gif',
  'images/penguin/11.gif',
  'images/penguin/12.gif',
  'images/penguin/13.gif',
  'images/penguin/14.gif',
  'images/penguin/15.gif',
  'images/penguin/16.gif',
  'images/penguin/17.gif',
  'images/penguin/18.gif',
  'images/penguin/19.gif',
  'images/penguin/20.gif',
  'images/penguin/21.gif',
  'images/penguin/22.gif',
  'images/penguin/23.gif',
  'images/penguin/24.gif',
];

const List<String> aGaiPics = const <String>[
  'images/agai/01.gif',
  'images/agai/02.gif',
  'images/agai/03.gif',
  'images/agai/04.gif',
  'images/agai/05.gif',
  'images/agai/06.gif',
  'images/agai/07.gif',
  'images/agai/08.gif',
  'images/agai/09.gif',
  'images/agai/10.gif',
  'images/agai/11.gif',
  'images/agai/12.gif',
  'images/agai/13.gif',
  'images/agai/14.gif',
  'images/agai/15.gif',
  'images/agai/16.gif',
];

class EmoticonPage extends StatelessWidget {
  EmoticonPage(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new DefaultTabController(
          length: choices.length,
          child: new Scaffold(
            appBar: new AppBar(
              title: Text(this.title),
              bottom: new TabBar(
                  tabs: choices.map((Choice choice) {
                return new Tab(
                  text: choice.title,
                  icon: new Icon(choice.icon),
                );
              }).toList()),
            ),
            body: new TabBarView(
              children: choices.map((Choice choice) {
                return new Padding(
                  padding: EdgeInsets.all(16.0),
                  child: GridView.count(
                    crossAxisCount: 3,
                    children: choice.pics.map((String pic) {
//                      return new Image(image: new AssetImage(pic));
                      return new GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new _EmoticonDetailPage(
                                      choice.pics, choice.pics.indexOf(pic))));
                        },
                        child: new Image(image: new AssetImage(pic)),
                      );
                    }).toList(),
                  ),
                );
              }).toList(),
            ),
          )),
    );
  }
}

class _EmoticonDetailPage extends StatefulWidget {
  _EmoticonDetailPage(this._pics, this._currentIndex) {
    var pic = _pics.elementAt(_currentIndex);
    _title = pic.substring(pic.lastIndexOf("/") + 1);
  }

  final int _currentIndex;
  final List<String> _pics;
  String _title;

  int get currentIndex => _currentIndex;

  List<String> get pics => _pics;

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  @override
  State<_EmoticonDetailPage> createState() {
    return new __EmoticonDetailPageState();
  }
}

class __EmoticonDetailPageState extends State<_EmoticonDetailPage> {
  @override
  Widget build(BuildContext context) {
//    this.widget.title = this.widget.pics.elementAt(this.widget.currentIndex);
    return new Scaffold(
        appBar: new AppBar(title: new Text(this.widget.title)),
        body: new PageView.builder(
          controller: new PageController(initialPage: this.widget.currentIndex),
          itemBuilder: (context, index) => (new Image(
              image: new AssetImage(this.widget.pics.elementAt(index)))),
          itemCount: this.widget.pics.length,
          onPageChanged: (index) => (_updateTitle(index)),
        ));
  }

  void _updateTitle(int index) {
    //刷新状态
    setState(() {
      this.widget.title = getTitle(index);
    });
  }

  String getTitle(int index) {
    var pic = this.widget.pics.elementAt(index);
    return pic.substring(pic.lastIndexOf("/") + 1);
  }
}
