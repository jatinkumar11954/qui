import 'package:flutter/material.dart';

import 'package:qui/short.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Material(
                    color: Colors.white,
                child: Text(
                  "Login",
                  style:
                      TextStyle(color: Colors.green, fontSize: Short.h * 0.046),
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
                // validator: emailValidator,
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
                // validator: emailValidator,
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
