part of vallet;

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  var newCardArray = ["Bank Card", "Cashback (Umico)"];
  var cardType = ["Visa", "Mastercard"];

  String _selectedValue;
  String _selectedCardType;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('New Card'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: 200,
              child: new DropdownButton<String>(
                isExpanded: true,
                hint: Text("Card Type"),
                value: _selectedValue,
                items: newCardArray.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (_item) {
                  setState(() {
                    _selectedValue = _item;
                    print(_item);
                  });
                },
              ),
            ),
            _selectedValue != null
                ? _selectedValue == "Bank Card"
                    ? Column(
                        children: <Widget>[
                          Container(
                            width: 200,
                            child: new DropdownButton<String>(
                              isExpanded: true,
                              hint: Text("Company Type"),
                              value: _selectedCardType,
                              items: cardType.map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              onChanged: (_item) {
                                setState(() {
                                  _selectedCardType = _item;
                                  print(_item);
                                });
                              },
                            ),
                          ),
                          Container(
                            width: 200,
                            child: TextField(
                              decoration:
                                  InputDecoration(hintText: "Card Number"),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            width: 200,
                            child: TextField(
                              decoration:
                                  InputDecoration(hintText: "Card Name"),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            width: 200,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Expired Time (mm/yy)"),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            width: 200,
                            child: TextField(
                              decoration: InputDecoration(hintText: "CVV"),
                            ),
                          )
                        ],
                      )
                    : Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            width: 200,
                            child: TextField(
                              decoration:
                                  InputDecoration(hintText: "Full Name"),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            width: 200,
                            child: TextField(
                              decoration:
                                  InputDecoration(hintText: "Card Number"),
                            ),
                          )
                        ],
                      )
                : Container()
          ],
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text(
            'CANCEL',
            style: TextStyle(color: Color.fromRGBO(100, 100, 100, 1)),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(
            "PROCESS",
            style: TextStyle(color: Color.fromRGBO(100, 100, 100, 1)),
          ),
          onPressed: () => print("PROCESSING VIA API"),
        )
      ],
    );
  }
}

class WalletsState extends State<Wallets> {
  _displayAddingDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return MyDialog();
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 50;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: true,
            title: Text(
              'MyVallets',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "SF",
                  fontWeight: FontWeight.w500),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.only(top: 0),
          child: Center(
            child: Container(
                width: width,
                child: ListView.builder(
                  itemCount: user["countcards"] + 1,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return index == user["countcards"]
                        ? Center(
                            child: IconButton(
                              onPressed: () => _displayAddingDialog(context),
                              icon: Icon(
                                Icons.add_circle,
                                color: Colors.blueGrey,
                                size: 40.0,
                              ),
                            ),
                          )
                        : Container(
                            height: 190,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: FlipCard(
                                direction: FlipDirection.VERTICAL,
                                front: Stack(
                                  children: <Widget>[
                                    Container(
                                      width: width,
                                      decoration: new BoxDecoration(
                                        border: Border.all(width: 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40)),
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      left: 20,
                                      child: Image.network(
                                        user["cards"][index]["bankLogo"],
                                        height: 30,
                                        color: Color.fromRGBO(100, 100, 100, 1),
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 20,
                                      child: Text(
                                        user["cards"][index]["name"],
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                100, 100, 100, 1),
                                            fontSize: 20,
                                            fontFamily: "SF",
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Positioned(
                                      left: 20,
                                      bottom: 15,
                                      child: Container(
                                          width: width,
                                          child: Text(
                                            "Mr. " +
                                                user["cards"][index]
                                                    ["cardName"],
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          )),
                                    ),
                                    Positioned(
                                      top: 90,
                                      child: Container(
                                        width: width,
                                        child: Center(
                                            child: Text(
                                          user["cards"][index]["cardNumber"],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            letterSpacing: 1.2,
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        )),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 15,
                                      right: 20,
                                      child: Container(
                                        child: 
                                            Text(
                                          "\$"+user["cards"][index]["totalAmount"].toString(),
                                          style: TextStyle(
                                            letterSpacing: 1.2,
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                back: Stack(
                                  children: <Widget>[
                                    Container(
                                      decoration: new BoxDecoration(
                                        border: Border.all(width: 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40)),
                                        color: Color.fromRGBO(100, 100, 100, 1),
                                      ),
                                      width: width,
                                    ),
                                    Positioned(
                                      top: 65,
                                      left: 50,
                                      child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(18.0),
                                        ),
                                        color: Colors.black45,
                                        onPressed: () => Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  OperationList()),
                                        ),
                                        child: Container(
                                          width: 70,
                                          child: Center(
                                            child: Text(
                                              "Operation",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 65,
                                      right: 50,
                                      child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0)),
                                        color: Colors.black45,
                                        onPressed: () => Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context) => History(
                                                    user["cards"][index]
                                                        ["cardNumber"]))),
                                        child: Container(
                                          width: 70,
                                          child: Center(
                                            child: Text("History",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                )),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                  },
                )),
          ),
        ));
  }
}
