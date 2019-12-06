part of vallet;

class Transaction extends StatefulWidget {
  final String title;
  final String type;
  Transaction({
    Key key,
    this.title,
    this.type,
  }) : super(key: key);

  @override
  TransactionState createState() => TransactionState();
}
