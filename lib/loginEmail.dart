import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart' as prefix;
import 'package:qui/short.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> _scaffoldKey=GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  
  TextEditingController email;
  TextEditingController pwd;
  bool showPwd = true;
  Icon _icon = Icon(
    Icons.visibility,
  );
  @override
  void initState() {
    // TODO: implement initState
    email = new TextEditingController();
    pwd = new TextEditingController();
    super.initState();
  }
 void callSnackBar(String msg,[int er])
  {
    if(er==1)
    {
      msg="There is no record with this user, please register first by clicking Register or check the user mail id or Password";
      final SnackBar=new prefix.SnackBar(
      content: new Text(msg),
      duration: new Duration(seconds: 10),
      action: new SnackBarAction(label: "Register",
      onPressed: (){
        Navigator.pushNamed(context, "Register");
      },),
    );
     _scaffoldKey.currentState.showSnackBar(SnackBar);
    }

    else if(er==2){
      final SnackBar=new prefix.SnackBar(
      content: new Text(msg),
      duration: new Duration(seconds: 10),
      action: new SnackBarAction(label: "EXIT",
      onPressed: (){
        // Navigator.pushNamed(context, "Exit");
        exit(0);
      },),
    );
     _scaffoldKey.currentState.showSnackBar(SnackBar);
    }

    else{
          final SnackBar=new prefix.SnackBar(
      content: new Text(msg),
      duration: new Duration(seconds: 2),

    );
    _scaffoldKey.currentState.showSnackBar(SnackBar);
  
    }
    }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  void _toggle() {
    setState(() {
      showPwd = !showPwd;
      if (showPwd) {
        _icon = Icon(
          Icons.visibility,
        );
      } else {
        _icon = Icon(Icons.visibility_off, color: Colors.grey);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Short().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          // (

          Padding(
            padding: const EdgeInsets.only(top:90.0,bottom: 90),
            child: Center(
              child: Material(
                color: Colors.white,
                child: Text(
                  "Login Via Email",
                  style:
                      TextStyle(color: Colors.green, fontSize:25),
                ),
              ),
            ),
          ),
          // SizedBox(height:Short.h*0.1),
          Padding(
            padding: EdgeInsets.only(
                top: Short.h * 0.05,
                left: Short.w * 0.07,
                right: Short.w * 0.07),
            child: Material(
              color: Colors.white,
              child: TextFormField(
                decoration: InputDecoration(
                  labelStyle:
                      TextStyle(color: Colors.grey, fontSize: Short.h * 0.02),
                  labelText: 'Email/Phone',
                  hintText: "Enter your email /Phone",
                  hintStyle:
                      TextStyle(color: Colors.grey, fontSize: Short.h * 0.02),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Short.h * 2.5)),
                ),
                controller: email,
                keyboardType: TextInputType.emailAddress,
                validator: emailValidator,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: Short.h * 0.04,
                left: Short.w * 0.07,
                right: Short.w * 0.07),
            child: Material(
              color: Colors.white,
              child: TextFormField(
                obscureText: showPwd,
                decoration: InputDecoration(
                  labelStyle:
                      TextStyle(color: Colors.grey, fontSize: Short.h * 0.02),
                  labelText: 'Password',
                  hintText: "Enter your Password",
                  hintStyle:
                      TextStyle(color: Colors.grey, fontSize: Short.h * 0.02),
                  suffixIcon: IconButton(
                    icon: _icon,
                    onPressed: _toggle,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Short.h * 2.5)),
                ),
                controller: pwd,
                keyboardType: TextInputType.emailAddress,
              validator: pwdValidator,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: Short.h * 0.045),
            child: RaisedButton(
                padding: EdgeInsets.only(
                    top: Short.h * 0.015,
                    bottom: Short.h * 0.015,
                    left: Short.w * 0.30,
                    right: Short.w * 0.30),
                color: Colors.green,
                onPressed: () {
                  print("login button is clicked");
                         if (_loginFormKey.currentState.validate()) {
                        callSnackBar("You are logging in ..  Please wait!!!!");
                        // status._isLogin=true;
                        print("after validation");
                        // FirebaseAuth.instance
                        //     .signInWithEmailAndPassword(
                        //         email: emailInputController.text,
                        //         password: pwdInputController.text)
                        //     .then((currentUser) => Firestore.instance
                        //         .collection("users")
                        //         .document(currentUser.uid)
                        //         .get()
                        //         .then(
                        //           (DocumentSnapshot result) =>Navigator.pushReplacementNamed(context, "HomeScreen"),
                        //                     )
                        //         .catchError((err) => callSnackBar(err.toString())))
                        //     .catchError((err) =>callSnackBar(err.toString(),1));
                      }
                       else{
                        print("no username or password wrong");
                        Text("No Username, Password ");
                        callSnackBar("No Username or wrong password");
                      }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(50.0),
                ),
                child: Text("LOGIN",
                    style: TextStyle(
                        color: Colors.white, fontSize: Short.h * 0.04))),
          ),
        ]),
      ),
    );
  }
}
