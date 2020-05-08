import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'firstscreen.dart';
import 'package:indeed/singin_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 150),
              SizedBox(height: 50),
              _signInButton(),
              Padding(
                padding: const EdgeInsets.all(48.0),
                child: FlatButton(
                    onPressed: () => Navigator.popAndPushNamed(context, "otp"),
                    child: Text(
                      "Login Via Phone Nmber",
                      style: TextStyle(color: Colors.green, fontSize:25),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () async {
        AuthResult auth = await signInWithGoogle(context);
        await signInWithGoogle(context).whenComplete(() {
          if (auth.additionalUserInfo.isNewUser) {
            print("firest uset");
            return Navigator.pushNamed(context, "first");
          }
          Navigator.pushNamed(context, "Main", arguments: "gmail");
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
