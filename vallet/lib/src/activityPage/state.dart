part of vallet;

class ActivityState extends State<Activity> {
  final Map<int, Widget> logoWidgets = const <int, Widget>{
    0: Text('Day'),
    1: Text('Week'),
    2: Text('Month'),
  };
  static int withdraw;
  static int shoping;
  static int transfer;
  static int dailyWithdraw = user["today"]["withdraw"].toInt();
  static int dailyShoping = user["today"]["shoping"].toInt();
  static int dailyTransfer = user["today"]["transfer"].toInt();
  static int weeklyWithdraw = user["week"]["withdraw"].toInt();
  static int weeklyShoping = user["week"]["shoping"].toInt();
  static int weeklyTransfer = user["week"]["transfer"].toInt();
  static int monthlyWithdraw = user["month"]["withdraw"].toInt();
  static int monthlyShoping = user["month"]["shoping"].toInt();
  static int monthlyTransfer = user["month"]["transfer"].toInt();

  Map<int, Function> process = <int, Function>{
    0: () {
      withdraw = dailyWithdraw;
      shoping = dailyShoping;
      transfer = dailyTransfer;
    },
    1: () {
      withdraw = weeklyWithdraw;
      shoping = weeklyShoping;
      transfer = weeklyTransfer;
    },
    2: () {
      withdraw = monthlyWithdraw;
      shoping = monthlyShoping;
      transfer = monthlyTransfer;
    },
  };

  int sharedValue = 0;

  @override
  void initState() {
    process.values.first();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = [
      new SpendPerCategory(
          'Withdraw', withdraw, Color.fromRGBO(177, 153, 251, 1)),
      new SpendPerCategory(
          'Shoping', shoping, Color.fromRGBO(161, 196, 252, 1)),
      new SpendPerCategory(
          'Transfer', transfer, Color.fromRGBO(100, 229, 229, 1)),
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

    var charWidget = new Padding(
      padding: new EdgeInsets.symmetric(vertical: 32.0, horizontal: 5.0),
      child: new SizedBox(
        height: 162.0,
        child: chart,
      ),
    );
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: true,
            title: Text(
              'Activity',
              style: TextStyle(color: Colors.black, fontFamily: "SF", fontWeight: FontWeight.w400),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: width,
                  child: CupertinoSegmentedControl<int>(
                    selectedColor: Colors.black,
                    borderColor: Colors.black,
                    children: logoWidgets,
                    onValueChanged: (int val) {
                      setState(() {
                        sharedValue = val;
                        switch (val) {
                          case 0:
                            process.values.first();
                            break;
                          case 1:
                            process.values.skip(1).first();
                            break;
                          case 2:
                            process.values.last();
                            break;
                          default:
                        }
                      });
                    },
                    groupValue: sharedValue,
                  ),
                ),
                Container(
                  width: width,
                  child: charWidget,
                ),
              ],
            ),
          ),
        ));
  }
}
