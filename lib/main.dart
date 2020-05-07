import 'package:flutter/material.dart';
import 'package:qui/short.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
      
        title: Text(widget.title),
      ),
      body: Container(

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
              Padding(
                padding: EdgeInsets.only(
                    top: Short.h * 0.02, bottom: Short.h * 0.05),
                child:
                    Divider(color: Colors.grey[300], thickness: Short.h * 0.01),
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Material(
                        color: Colors.white,
                        child: Text(
                          "Don't have an account ? ",
                          style: TextStyle(
                              color: Colors.grey, fontSize: Short.h * 0.025),
                        )),
                    FlatButton(
                      onPressed:() =>Navigator.pushNamed(context,'SignUp'),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.green, fontSize: Short.h * 0.025),
                      ),
                    ),
                  ]),
            ],
          ),
        )),
  )
    );
  }
}
