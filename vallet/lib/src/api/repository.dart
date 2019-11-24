part of vallet;

class Repository {
  final apiProvider = ApiProvider();

  Future<User> fetchUser(username, password) => apiProvider.fetchUser(username, password);


}
