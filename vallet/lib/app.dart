library vallet;

// Dart Imports
import 'dart:async';
import 'dart:convert';

// Flutter imports
import 'package:flutter/cupertino.dart';
import 'package:pusher_websocket_flutter/pusher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/semantics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flip_card/flip_card.dart';
import 'package:http/http.dart' show Client;
import 'package:laravel_echo/laravel_echo.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


// Plugins import...

// Router
part 'src/logPage/index.dart';
part 'src/logPage/state.dart';
part 'src/mainPage/index.dart';
part 'src/mainPage/state.dart';
part 'src/transactionPage/index.dart';
part 'src/transactionPage/state.dart';
part 'src/walletsPage/index.dart';
part 'src/walletsPage/state.dart';
part 'src/activityPage/index.dart';
part 'src/activityPage/state.dart';
part 'src/api/api_provider.dart';
part 'src/api/bloc.dart';
part 'src/operation/index.dart';
part 'src/api/repository.dart';
part 'src/historyPage/index.dart';
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
          style: TextStyle(fontSize: 50, fontFamily: "SF", fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.black);
  }
}


class PusherService {
  Event lastEvent;
  String lastConnectionState;
  Channel channel;

StreamController<String> _eventData = StreamController<String>();
  Sink get _inEventData => _eventData.sink;
  Stream get eventStream => _eventData.stream;

  Future<void> initPusher() async {
    try {
      await Pusher.init("0d4f0a2fdbf344edca13", PusherOptions(cluster: "ap2"));
    } catch (e) {
      print(e.message);
    }
  }

  void connectPusher() {
    Pusher.connect(
        onConnectionStateChange: (ConnectionStateChange connectionState) async {
      lastConnectionState = connectionState.currentState;
    }, onError: (ConnectionError e) {
      print("Error: ${e.message}");
    });
  }

  Future<void> subscribePusher(String channelName) async {
    channel = await Pusher.subscribe(channelName);
  }

  void unSubscribePusher(String channelName) {
    Pusher.unsubscribe(channelName);
  }

   void bindEvent(String eventName) {
    channel.bind(eventName, (last) {
      final String data = last.data;
      _inEventData.add(data);
    });
  }

  void unbindEvent(String eventName) {
    channel.unbind(eventName);
    _eventData.close();
  }

   Future<void> firePusher(String channelName, String eventName) async {
    await initPusher();
    connectPusher();
    await subscribePusher(channelName);
    bindEvent(eventName);
  }
}