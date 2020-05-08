import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:indeed/singin_page.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("WELCOME",
                    style: TextStyle(color: Colors.green, fontSize: 35)),
               FlatButton(
                   onPressed: () {
                     signOutGoogle();
                     FirebaseAuth.instance
                         .signOut()
                         .then((result) =>
                             Navigator.pushReplacementNamed(context, "login"))
                         .catchError((err) => print(err));
                   },
                   child: Text(
                     "Logout",
                     style: TextStyle(color: Colors.green, fontSize: 35),
                   ))
            ],
          ),
        ),
        
      ),
    );
  }
}