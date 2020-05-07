import 'package:flutter/material.dart';
import 'package:qui/short.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
         
          primarySwatch: Colors.blue,
        ),
        home: Home(),
        routes: <String, WidgetBuilder>{
          // 'LoginA': (BuildContext context) => new LoginA(),
          // 'Login': (BuildContext context) => new Login(),
          // 'LoginOtp': (BuildContext context) => new LoginOtp(),
          // 'Otp': (BuildContext context) => new Otp(),
          // 'Main': (BuildContext context) => new FirstScreen(),
          // 'Second': (BuildContext context) => new SecondScreen(),
          // 'Desc': (BuildContext context) => new Description(),
          // 'SignUp': (BuildContext context) => new SignUp(),
        });
  }
}

class Home extends StatefulWidget {
 



  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
 
  @override
  Widget build(BuildContext context) {
    Short().init(context);
  
    return Scaffold(
      appBar: AppBar(
      
        title: Text("widget.title"),
      ),
      body: Center(
        child: Container(

    height: Short.h * 0.8,
    width: Short.w,
    child: Padding(
          padding: EdgeInsets.only(
              bottom: Short.h * 0.14,
              top: Short.h * 0.18,
              left: Short.w * 0.03,
              right: Short.w * 0.03),
          child: Card(
            elevation: 15.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                    child: FlatButton(
                  onPressed: (){},
                  child: Text(
                    "Login via Email / Phone",
                    style:
                        TextStyle(color: Colors.green, fontSize: Short.h * 0.025),
                  ),
                )),
                Row(children: <Widget>[
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                        child: Divider(
                          color: Colors.grey,
                          height: 36,
                        )),
                  ),
                  Material(
                      color: Colors.white,
                      child: Text(
                        "or",
                        style: TextStyle(
                            color: Colors.grey, fontSize: Short.h * 0.02),
                      )),
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                        child: Divider(
                          color: Colors.grey,
                          height: 36,
                        )),
                  ),
                ]),
                Center(
                    child: Padding(
                  padding: EdgeInsets.only(
                      top: Short.h * 0.02, bottom: Short.h * 0.02),
                  child: FlatButton(
                    onPressed: () {
                      print("Login via otp");
                      Navigator.pushNamed(context, "LoginOtp");
                    },
                    child: Text(
                      "Login via OTP",
                      style: TextStyle(
                          color: Colors.green, fontSize: Short.h * 0.025),
                    ),
                  ),
                )),
               
              ],
            ),
          )),
  ),
      )
    );
  }
}
