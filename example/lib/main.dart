import 'package:flutter/material.dart';

import 'package:flim/flim.dart';

import 'my_game.dart';

void main() async {
  Assets.instance.imagePath = "assets/images/";
  Assets.instance.jsonPath = "assets/json/";
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flim demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            elevation: 0,
            color: Colors.black26,
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flim demo'),
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: MyGame().initialize(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GameWidget(snapshot.data);
              } else {
                return Container();
              }
            },
          ),
          FutureBuilder(
            future: Sprite(
              imageRect: ImageRect(image: 'AngelBrown.PNG'),
              transform: Transform2D(
                translate: Offset(100, 200),
                scale: 2.0,
                rotation: 3.14 / 4.0,
              ),
            ).load(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SpriteWidget(snapshot.data);
              } else {
                return Container();
              }
            },
          ),
          FutureBuilder(
            future: AnimatedSprite.fromUniformSpriteSheet(
              'boom3.png',
              subImageSize: IntSize(128, 128),
              numSpriteBounds: IntRect(0, 0, 8, 8),
              frameTime: 0.03,
              transform: Transform2D(
                translate: Offset(0.0, 128 * 2.0),
              ),
            ).load(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return AnimatedSpriteWidget(snapshot.data);
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
