part of vallet;


class ApiProvider {
final String host = 'http://10.0.2.2:8000';

  Client client = Client();

  Future<User> fetchUser(String phone, String password) async {
    final response = await client.get('$host/api/user/$phone/$password');
    if (response.statusCode == 200) {
      String body  = response.body;
      user = json.decode(body);
      print(body);
      return  User.fromJson(json.decode(body));
    }
    else {
      throw Exception('Failed to load post');
    }
  }
}
