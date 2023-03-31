import 'package:baiq/view/dashboard_view.dart';
import 'package:baiq/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String uid = prefs.getString('uid');
  print(uid);
  runApp(MyApp(uid: uid,));
}

class MyApp extends StatelessWidget {
  final String uid;
  const MyApp({Key key, this.uid}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baca Iqra',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: uid == null ? Login() : Dashboard()
    );
  }
}

//class SplashScreenPage extends StatefulWidget {
//  @override
//  SplashScreenPageState createState() => SplashScreenPageState();
//}
//
//class SplashScreenPageState extends State<SplashScreenPage> {
//
//  SharedPreferences prefs;
//  String uid ;
//
//  Future<void> initPref() async {
//    prefs = await SharedPreferences.getInstance();
//    uid = prefs.getString('uid');
//    print(uid);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    initPref();
//    // TODO: implement build
//    return SplashScreen(
//      seconds: 14,
//      navigateAfterSeconds: uid == null ? Login() : Dashboard(),
//      title: Text("Belajar Iqra'", style: TextStyle(
//        fontWeight: FontWeight.bold,
//        fontSize: 20
//      ),),
//      image: Image.asset("assets/img/logo_login.png"),
//      backgroundColor: Colors.white,
//      styleTextUnderTheLoader: TextStyle(),
//      photoSize: 100,
//      onClick: () => print("BaIq"),
//      loaderColor: Colors.deepOrange,
//    );
//  }
//}
