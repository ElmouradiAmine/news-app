import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shapp/Screens/login_screen.dart';

class SettingScreen extends StatefulWidget {
  static const String id = 'setting_screen';
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
          onTap: () {
            _auth.signOut();
            Navigator.of(context).pushNamedAndRemoveUntil(
                LoginScreen.id, (Route<dynamic> route) => false);
          },
          child: Icon(
            Icons.clear,
            color: Colors.white,
          )),
    );
  }
}
