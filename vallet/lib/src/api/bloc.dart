part of vallet;

class Bloc {
  final _repository = Repository();
  final _user = PublishSubject<User>();


  Observable<User> get user => _user.stream;


  fetchUser(String username, String password) async {
    
    User items = await _repository.fetchUser(username, password);
    _user.sink.add(items);
  }


  dispose() {
    _user.close();

  }
}

final bloc = Bloc();
