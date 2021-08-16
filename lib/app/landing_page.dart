import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tracker/app/home_page.dart';
import 'package:flutter_tracker/app/sign_in/signinpage.dart';
import 'package:flutter_tracker/services/auth.dart';
import 'package:provider/provider.dart';


class LandingPage extends StatelessWidget {
  // LandingPage({@required this.auth});

  // final AuthBase auth;
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<GUser>(
        stream:auth.onAuthStateChanged,
        builder: (context,snapshot)
        {
          if (snapshot.connectionState==ConnectionState.active){
            GUser gUser = snapshot.data;
            if (gUser == null) {
              return SignInPage(


              );
            }
            return HomePage(


            );
          }
          else{
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );

          }
        }
    );

  }
}
