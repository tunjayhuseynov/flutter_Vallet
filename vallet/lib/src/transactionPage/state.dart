part of vallet;

class TransactionState extends State<Transaction> {
  List<dynamic> transactions;

  @override
  void initState() {
    super.initState();
    transactions = user['transactions'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: Text(
            'Transaction',
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
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (BuildContext ctx, int i) {
          return ListTile(
            leading: Image.network(
              transactions[i]["image"],
              width: 100,
              height: 100,
            ),
            title: Text(transactions[i]["name"]),
            trailing: Text('-' + transactions[i]["money"].toStringAsFixed(2) + "\$"),
            subtitle: Text(
              transactions[i]["cardNumber"],
              style: TextStyle(fontSize: 10),
            ),
          );
        },
      ),
    );
  }
}

