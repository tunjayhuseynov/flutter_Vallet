part of vallet;

class LogState extends State<Log> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Vallet",
                  style: TextStyle(fontSize: 50, fontFamily: "Lobster"),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                ),
                CupertinoTextField(
                  controller: usernameController,
                  placeholder: "Username",
                  placeholderStyle: TextStyle(color: Colors.black54),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                CupertinoTextField(
                  obscureText: true,
                  controller: passwordController,
                  placeholder: "Password",
                  placeholderStyle: TextStyle(color: Colors.black54),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Container(
                  width: 100,
                  child: RaisedButton(
                    color: Colors.black,
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await bloc.fetchUser(usernameController.value.text,
                          passwordController.value.text);

                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => Main()),
                      );
                    },
                    child: Center(
                      child: !isLoading
                          ? Text(
                              "Log In",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            )
                          : Container(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            valueColor:  new AlwaysStoppedAnimation<Color>(Colors.black),
                          ),
                          ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
