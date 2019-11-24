part of vallet;

class Activity extends StatefulWidget {
  final String title;
  final String type;
  Activity({
    Key key,
    this.title,
    this.type,
  }) : super(key: key);

  @override
  ActivityState createState() => ActivityState();
}
