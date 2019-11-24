part of vallet;


Map<String, dynamic> user;

class SpendPerCategory {
  final String category;
  final int money;
  final charts.Color color;

  SpendPerCategory(this.category, this.money, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class User{
  String _fullName;
  int _id;
  double _totalBalance;
  List<Transactions> _transactions = [];
  List<Activities> _activity = [];

  User.fromJson(Map<String, dynamic> parsedJson) {
    _fullName = parsedJson['fullname'];
    _id = parsedJson['id'];
    _totalBalance = parsedJson['TotalBalance'];
    _transactions = List.from(parsedJson['transactions'])
        .map(
          (r) => Transactions.fromJson(r),
        )
        .toList();
    _activity = List.from(parsedJson['activity'])
        .map(
          (r) => Activities.fromJson(r),
        ).toList();

  }

  List<Transactions> get results => _transactions;
  String get fullName => _fullName;
  int get id => _id;
  double get totalBalance => _totalBalance;
}

class Transactions{
  int _id;
  String _image;
  String _category;
  String _cardNumber;
  String _name;

  Transactions.fromJson(Map<String, dynamic> parsedJson){
    _id = parsedJson["id"];
    _image = parsedJson["image"];
    _category = parsedJson["category"];
    _cardNumber = parsedJson["cardNumber"];
    _name = parsedJson["name"];
  }

  int get id => _id;
  String get image => _image;
  String get category => _category;
  String get cardNumber => _cardNumber;
  String get name => _name;
}

class Activities{
  int _id;
  int _money;
  String _category;

  Activities.fromJson(Map<String, dynamic> parsedJson){
    _id = parsedJson["id"];
    _money = parsedJson["money"];
    _category = parsedJson["category"];
  }

  int get id => _id;
  String get category => _category;
  int get cardNumber => _money;
}


