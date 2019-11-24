part of vallet;

class Wallets extends StatefulWidget {
  final String title;
  final String type;
  Wallets({
    Key key,
    this.title,
    this.type,
  }) : super(key: key);

  @override
  WalletsState createState() => WalletsState();
}
