import 'package:flutter/material.dart';
import 'package:flutter_tracker/app/sign_in/emailsigninform.dart';
import 'package:flutter_tracker/services/auth.dart';

class EmailSignInPage extends StatelessWidget {
  // EmailSignInPage({@required this.auth});
  // final AuthBase auth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Center(
          child: Text('Sign In'),
        ),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18.0),
          child: Card(
            child: EmailSignInForm(),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
