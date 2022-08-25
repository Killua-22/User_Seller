import 'package:flutter/material.dart';
import 'package:user_seller/screens/screen_login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Home());
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("error");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return ScreenLogin();
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
