import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:indeed/short.dart';
import 'package:indeed/welcome.dart';

import 'firstscreen.dart';
import 'firstuset.dart';
import 'login_page.dart';
import 'otp.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Login',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
                future: FirebaseAuth.instance.currentUser(),
              
                builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
                  if (snapshot.hasData) {
                    return Welcome();
                      
                    
                  } else {
                    return LoginPage();
                  }
                },
              ),
        routes: <String, WidgetBuilder>{
          'otp': (BuildContext context) => new PhoneLogin(),
          'Main': (BuildContext context) => new FirstScreen(),
          'login': (BuildContext context) => new LoginPage(),
          'first': (BuildContext context) => new FirstUser(),
          // 'SignUp': (BuildContext context) => new SignUp(),
        });
  }
}
