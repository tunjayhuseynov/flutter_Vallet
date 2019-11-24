part of vallet;

class Log extends StatefulWidget {
  final String title;
  final String type;
  Log({
    Key key,
    this.title,
    this.type,
  }) : super(key: key);

  @override
  LogState createState() => LogState();
}
