import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tracker/app/home_page.dart';
import 'package:flutter_tracker/app/sign_in/signinpage.dart';

class LandingPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<LandingPage> {
  User _user;

  void _updateUser(User user) {
    setState(() {
      _user = user;
    });
    // print('UserId: ${user.uid}');
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInPage(
        onSignIn: _updateUser,
      );
    }
    return HomePage(
      onSignOut: () => _updateUser(null),
    );
  }
}
