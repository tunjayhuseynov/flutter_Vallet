part of vallet;

class MainState extends State<Main> {
  List<Widget> trans = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < user["transactionsCount"]; i++) {
      var aTran = ListTile(
        leading: Image.network(
          user["transactions"][i]["image"],
          width: 100,
          height: 100,
        ),
        title: Text(user["transactions"][i]["name"]),
        trailing: Text('-'+user["transactions"][i]["money"].toString()+"\$"),
        subtitle: Text(user["transactions"][i]["cardNumber"], style: TextStyle(fontSize: 10),),
      );
      trans.add(aTran);
    }
    var data = [
      new SpendPerCategory('Withdraw', user["today"]["withdraw"],
          Color.fromRGBO(177, 153, 251, 1)),
      new SpendPerCategory('Shoping', user["today"]["shoping"],
          Color.fromRGBO(161, 196, 252, 1)),
      new SpendPerCategory('Transfer', user["today"]["transfer"],
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
        barRendererDecorator: new charts.BarLabelDecorator<String>(
            insideLabelStyleSpec:
                charts.TextStyleSpec(color: charts.Color.white)),
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
    double height = MediaQuery.of(context).size.height;
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
                    height: 160,
                    width: width,
                    child: Card(
                      elevation: 10,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: width,
                            child: Image.network(
                              "https://st4.depositphotos.com/2060305/22518/v/600/depositphotos_225182764-stock-video-dynamic-animation-smooth-gradient-background.jpg",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                            left: 5,
                            child: Text(
                              "Vallet",
                              style: TextStyle(
                                  fontSize: 30, fontFamily: "Lobster"),
                            ),
                          ),
                          Positioned(
                            left: 15,
                            bottom: 5,
                            child: Container(
                                width: width,
                                child: Text(
                                  "Mr. " + user["fullname"],
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                )),
                          ),
                          Positioned(
                            top: 75,
                            child: Container(
                              width: width,
                              child: Center(
                                  child: Text(
                                "TOTAL BALANCE: " + user["totalBalance"] + "\$",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
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
                              "Latest Activity",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
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
                  height: 200,
                  child: Card(
                    elevation: 6,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 5,
                          left: 10,
                          child: Text(
                            "Latest Transactions",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
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
