part of vallet;

class MainState extends State<Main> {
  List<Widget> trans = [];

  WebSocketChannel webSocketChannel;
  PusherService pusherService = PusherService();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("Limit or Low Budget"),
          content: Text("Demo Version"),
        );
      },
    );
    }

    @override
    void dispose() { 
      pusherService.unbindEvent('App\\Events\\NewMessageNotification');

      super.dispose();
    }

  @override
  void initState() {
        pusherService = PusherService();

    pusherService.firePusher('notification', 'App\\Events\\NewMessageNotification');
    trans.clear();
    for (var i = 0; i < user["transactionsCount"]; i++) {
      var aTran = ListTile(
        leading: Image.network(
          user["transactions"][i]["image"],
          width: 100,
          height: 100,
        ),
        title: Text(user["transactions"][i]["name"]),
        trailing:
            Text('-' + user["transactions"][i]["money"].toString() + "\$"),
        subtitle: Text(
          user["transactions"][i]["cardNumber"],
          style: TextStyle(fontSize: 10),
        ),
      );
      trans.add(aTran);
    }
    super.initState();

        var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon'); 
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);


    pusherService.eventStream.listen((data){
              _showNotificationWithDefaultSound();

        });


  }

Future _showNotificationWithDefaultSound() async {
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.Max, priority: Priority.High);
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    'Limit or Low Budget',
    'How to Show Notification in Vallet',
    platformChannelSpecifics,
    payload: 'Default_Sound',
  );
}

  @override
  Widget build(BuildContext context) {

        
        
    var data = [
      new SpendPerCategory('Withdraw', user["today"]["withdraw"].toInt(),
          Color.fromRGBO(177, 153, 251, 1)),
      new SpendPerCategory('Shoping', user["today"]["shoping"].toInt(),
          Color.fromRGBO(161, 196, 252, 1)),
      new SpendPerCategory('Transfer', user["today"]["transfer"].toInt(),
          Color.fromRGBO(100, 229, 229, 1)),
    ];

    var series = [
      new charts.Series(
          id: 'Activity',
          domainFn: (SpendPerCategory clickData, _) => clickData.category,
          measureFn: (SpendPerCategory clickData, _) => clickData.money,
          colorFn: (SpendPerCategory clickData, _) => clickData.color,
          measureLowerBoundFn: (SpendPerCategory clickData, _) =>
              clickData.money * 0.5,
          data: data,
          labelAccessorFn: (SpendPerCategory clickData, _) =>
              clickData.money.toString() + "\$"),
    ];

    var chart = new charts.BarChart(series,
        animate: true,
        primaryMeasureAxis: new charts.NumericAxisSpec(
            renderSpec: new charts.NoneRenderSpec()));

    Widget charWidget = new Padding(
      padding: new EdgeInsets.symmetric(vertical: 32.0, horizontal: 5.0),
      child: new SizedBox(
        height: 162.0,
        child: chart,
      ),
    );

    double width = MediaQuery.of(context).size.width - 50;
    return Scaffold(
        appBar: new AppBar(
          title: new Text(''),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        drawer: new Drawer(
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                CupertinoButton(
                  onPressed: () => print("Preferences"),
                  child: Text(
                    "Preferences",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
                CupertinoButton(
                  onPressed: () => print("Exit"),
                  child: Text(
                    "Log Out",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.only(top: 5),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => Wallets()),
                    )
                  },
                  child: Center(
                      child: Container(
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: Color.fromRGBO(50, 50, 50, 1),
                    ),
                    height: 200,
                    width: width,
                    child: Card(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35.0),
                      ),
                      elevation: 0,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 10,
                            left: 15,
                            child: Text(
                              "Vallet",
                              style: TextStyle(
                                  color: Color.fromRGBO(220, 220, 220, 1),
                                  fontSize: 30,
                                  fontFamily: "SF",
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Positioned(
                            top: 30,
                            right: 30,
                            child: Image.asset(
                              "resource/card.png",
                              width: 50,
                            ),
                          ),
                          Positioned(
                            left: 20,
                            bottom: 10,
                            child: Container(
                                width: width,
                                child: Text(
                                  "Mr. " + user["fullname"],
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Color.fromRGBO(235, 235, 235, 1),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                )),
                          ),
                          Positioned(
                            top: 120,
                            right: 18,
                            child: Container(
                              child: Text(
                                  "\$"+user["totalBalance"].toStringAsFixed(2),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(255, 255, 255, .85),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "SF",
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
                ),
                Center(
                    child: Container(
                  height: 200,
                  width: width,
                  child: Card(
                    elevation: 10,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 5,
                          left: 10,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => Activity()),
                              );
                            },
                            child: Text(
                              "Activity",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          child: Container(
                            width: width,
                            child: charWidget,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
                Container(
                  width: width,
                  height: 400,
                  child: Card(
                    elevation: 6,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 5,
                          left: 10,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => Transaction()),
                              );
                            },
                            child: Text(
                              "Transactions",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        Card(
                            margin: EdgeInsets.only(top: 30),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: trans,
                              ),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
  
}
