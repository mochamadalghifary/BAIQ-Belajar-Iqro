import 'package:baiq_ustadz/model/login_model.dart';
import 'package:baiq_ustadz/presenter/login_presenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mvp/mvp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard_view.dart';

class Login extends StatefulWidget {
  var loginPresenter = new LoginPresenter();

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends MvpScreen<Login, LoginModel> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _username;
  TextEditingController _password;

  @override
  void initializeViewModel() {
    viewModel = LoginModel();
  }

  @override
  void initState() {
    _username = new TextEditingController();
    _password = new TextEditingController();
    // TODO: implement initState
    super.initState();
    widget.loginPresenter.bind(applyState, this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.loginPresenter.unbind();
  }

  @override
  Widget build(BuildContext context) {
    widget.loginPresenter.bind(applyState, this);
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.asset("assets/img/logo_login.png"),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          child: Text("LOGIN Ustadz", textAlign: TextAlign.center,),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Username"
                            ),
                            controller: _username,
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Password"
                            ),
                            controller: _password,
                          ),
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: SizedBox(
                              child: RaisedButton(
                                child: Text("Login Now"),
                                onPressed: (){
                                  setState(() {
                                    setState(() {
                                      widget.loginPresenter.doLogin(_username.text, _password.text);
                                    });
                                  });
                                },
                              ),
                            )
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            child: Text("Login With Google"),
                            onPressed: (){
                              _handleSignIn()
                                  .then((FirebaseUser user) => {
                                    if (user != null) {
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Dashboard()))
                                    }})
                                  .catchError((e) => print(e));
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ),
        ),
      ),
    );
  }

  void nextView(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
  }

  Future<void> showFailedDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rewind and remember'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You will never be satisfied.'),
                Text('You\’re like me. I’m never satisfied.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Regret'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  showFailed() {
    showFailedDialog();
  }

  Future<FirebaseUser> _handleSignIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    print("signed in " + user.uid);
    prefs.setString("uid", user.uid);
    prefs.setString("nama", user.displayName);
    return user;
  }
}