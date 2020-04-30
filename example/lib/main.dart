import 'package:example/my_benchmark_game.dart';
import 'package:flutter/material.dart';

import 'package:flim/flim.dart';

import 'my_game_widget.dart';
import 'my_game.dart';
import 'my_simple_game.dart';
import 'my_keyboard_game.dart';

void main() async {
  ImageAssets.instance.basePath = "assets/images/";
  JsonAssets.instance.basePath = "assets/json/";
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
        ),
      ),
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
      body: buildKeyboardGame(),
    );
  }

  Widget buildBenchmarkGame() {
    return FutureBuilder(
      future: MyBenchmarkGame(MediaQuery.of(context).size).initialize(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GameWidget(snapshot.data);
        } else {
          return Container();
        }
      },
    );
  }

  Widget buildKeyboardGame() {
    return Stack(
      children: [
        FutureBuilder(
          future: MyKeyboardGame(MediaQuery.of(context).size).initialize(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MyGameWidget(snapshot.data);
            } else {
              return Container();
            }
          },
        ),
        Padding(
          padding: EdgeInsets.all(32),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              'press \'hjkl\' to move and \'f\' to fire',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAnimationWithTwoImage() {
    return FutureBuilder(
      future: AnimatedSprite.loadJson('animation_two_images.json'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GameWidget(AnimatedSpriteGame(snapshot.data));
        } else {
          return Container();
        }
      },
    );
  }

  Widget buildSimpleGameAndWidgets() {
    return Row(
      children: [
        FutureBuilder(
          future: Sprite(
            imageRect: ImageRect(
              image: 'boom3.PNG',
              rect: IntRect(512, 512, 128, 128),
              color: Colors.yellowAccent,
            ),
            transform: Transform2(
              anchor: Offset(64.0, 64.0),
            ),
          ).load(),
          builder: (context, snapshot) {
            return Container(
              width: 300,
              height: 200,
              color: Colors.blueAccent,
              child: Center(
                child: snapshot.hasData ? SpriteWidget(snapshot.data) : Container(),
              ),
            );
          },
        ),
        FutureBuilder(
          future: MySimpleGame().initialize(),
          builder: (context, snapshot) {
            return Container(
              width: 200,
              height: 200,
              color: Colors.redAccent,
              child: snapshot.hasData
                  ? GameWidget(
                      snapshot.data,
                      size: Size(200, 200),
                    )
                  : Container(),
            );
          },
        ),
      ],
    );
  }

  Widget buildGameAndWidgets() {
    return Stack(
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
            transform: Transform2(
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
            spriteSize: IntSize(128, 128),
            atlasBounds: IntRect(0, 0, 8, 8),
            frameDuration: 0.03,
            color: Colors.transparent,
            transform: Transform2(
              translate: Offset(0.0, 128 * 2.0),
            ),
          ).load(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GameWidget(AnimatedSpriteGame(snapshot.data));
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}
