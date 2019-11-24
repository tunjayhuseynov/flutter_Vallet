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
          child: new Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("PROCESS"),
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
              'Wallets',
              style: TextStyle(color: Colors.black, fontFamily: "Lobster"),
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
                  itemCount: 2 + 1,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return index == 2
                        ? Center(
                            child: IconButton(
                              onPressed: () => _displayAddingDialog(context),
                              icon: Icon(
                                Icons.add_circle,
                                color: Colors.blueGrey,
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
                                      child: Image.network(
                                        "https://st4.depositphotos.com/2060305/22518/v/600/depositphotos_225182764-stock-video-dynamic-animation-smooth-gradient-background.jpg",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Positioned(
                                      left: 5,
                                      child: Image.network(
                                        "http://rookie.az/wp-content/uploads/2018/08/Pasha-Bank1s.png",
                                        height: 30,
                                      ),
                                    ),
                                    Positioned(
                                      top: -4,
                                      right: 5,
                                      child: Image.network(
                                        "https://seeklogo.net/wp-content/uploads/2016/11/visa-logo-preview.png",
                                        height: 40,
                                      ),
                                    ),
                                    Positioned(
                                      left: 15,
                                      bottom: 5,
                                      child: Container(
                                          width: width,
                                          child: Text(
                                            "Mr. Tuncay Huseynov",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.black87,
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
                                          "1456 7894 6541 1234",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                                back: Stack(
                                  children: <Widget>[
                                    Container(
                                      width: width,
                                      child: Image.network(
                                        "https://st4.depositphotos.com/2060305/22518/v/600/depositphotos_225182764-stock-video-dynamic-animation-smooth-gradient-background.jpg",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Positioned(
                                      top: 65,
                                      left: 50,
                                      child: RaisedButton(
                                        color: Colors.black12,
                                        onPressed: () => print("s"),
                                        child: Text(
                                          "Operation",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 65,
                                      right: 50,
                                      child: RaisedButton(
                                        color: Colors.black12,
                                        onPressed: () => print("s"),
                                        child: Text("History",
                                            style: TextStyle(
                                              color: Colors.white,
                                            )),
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
