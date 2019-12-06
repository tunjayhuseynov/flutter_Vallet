part of vallet;

class OperationList extends StatefulWidget{

  OperationList({
    Key key,
  }) : super(key: key);

  @override
  OperationListState createState() => OperationListState();
}


class OperationListState extends State<OperationList>{
    _displayAddingDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Limitation();
        });
  }
  @override
  Widget build(BuildContext context) {

return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: Text(
            'Operations',
            style: TextStyle(
                color: Colors.black,
                fontFamily: "SF",
                fontWeight: FontWeight.w400),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          ListTile(
            onTap: (){
              Navigator.push(context, CupertinoPageRoute(builder: (context)=> ShopingList()));
            },
            leading: Icon(Icons.shopping_cart),
            title: Text("Online Shoping"),
            trailing: Icon(Icons.arrow_forward),
          ),
          ListTile(
            onTap: ()=>_displayAddingDialog(context),
            leading: Icon(Icons.timer),
            title: Text("Set a Limitation to the card"),
            trailing: Icon(Icons.arrow_forward),
          )
        ],
      ),
    );
  }
}


class ShopingList extends StatefulWidget{

  ShopingList({
    Key key,
  }) : super(key: key);

  @override
  ShopingListState createState() => ShopingListState();
}


class ShopingListState extends State<ShopingList>{
    _displayAddingDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Limitation();
        });
  }
  @override
  Widget build(BuildContext context) {

return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: Text(
            'Operations',
            style: TextStyle(
                color: Colors.black,
                fontFamily: "SF",
                fontWeight: FontWeight.w400),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Image.network("https://lh3.googleusercontent.com/UcWrK2a9MfU21Ujp7F40mHiPU9LaBVkp59wB7XFoVt-9_wtd4N-W-jUxg3fTBL-uC-k", fit: BoxFit.cover, width: 50,),
            title: Text("Azal"),
            trailing: Icon(Icons.arrow_forward),
          ),
          ListTile(
            onTap: ()=>print("Balance"),
            leading: Image.network("https://static-s.aa-cdn.net/img/gp/20600011855442/HXtwVa6qp11WIJValMRleCwyFg5YUHubLjjagBT7qpahFY72l7qVFPBGFyvzSRyjsIM=s300?v=1", fit: BoxFit.cover, width: 50,),
            title: Text("Azercell"),
            trailing: Icon(Icons.arrow_forward),
          )
        ],
      ),
    );
  }
}



class Limitation extends StatefulWidget {
  @override
  LimitationState createState() => new LimitationState();
}

class LimitationState extends State<Limitation> {

  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Set Limitation'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
           TextField(
             decoration: InputDecoration(
               helperText: "Get a notice when the limit's passed"
             ),
             autofocus: true,
             controller: _controller,
             keyboardType: TextInputType.number,
           )
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



