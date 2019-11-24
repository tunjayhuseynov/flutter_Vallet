library vallet;

// Dart Imports
import 'dart:async';
import 'dart:convert';

// Flutter imports
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flip_card/flip_card.dart';
import 'package:http/http.dart' show Client;
// Plugins import...

// Router
part 'src/logPage/index.dart';
part 'src/logPage/state.dart';
part 'src/mainPage/index.dart';
part 'src/mainPage/state.dart';
part 'src/walletsPage/index.dart';
part 'src/walletsPage/state.dart';
part 'src/activityPage/index.dart';
part 'src/activityPage/state.dart';
part 'src/api/api_provider.dart';
part 'src/api/bloc.dart';
part 'src/api/repository.dart';
part 'constans.dart';
// Models

// Blocs

// Resources

// Widgets

class Vallet extends StatelessWidget {
  Vallet({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Netflix',
      theme: ThemeData(
        fontFamily: 'GoogleSans',
        primaryColor: Colors.black,
      ),
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 2,
        navigateAfterSeconds: new Log(),
        title: Text(
          "Vallet",
          style: TextStyle(fontSize: 50, fontFamily: "Lobster"),
        ),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.black);
  }
}
