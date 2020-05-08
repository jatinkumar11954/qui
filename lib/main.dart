import 'package:flutter/material.dart';

import 'firstscreen.dart';
import 'firstuset.dart';
import 'login_page.dart';
import 'otp.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
         routes: <String, WidgetBuilder>{
   
          'otp': (BuildContext context) => new PhoneLogin(),
          'Main': (BuildContext context) => new FirstScreen(),
          'login': (BuildContext context) => new LoginPage(),
          'first': (BuildContext context) => new FirstUser(),
          // 'SignUp': (BuildContext context) => new SignUp(),
        }
    );
  }
}