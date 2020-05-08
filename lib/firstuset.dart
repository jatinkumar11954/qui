import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:indeed/short.dart';

class FirstUser extends StatefulWidget {
  @override
  _FirstUserState createState() => _FirstUserState();
}

class _FirstUserState extends State<FirstUser> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  void callSnackBar(String msg, [int er]) {
    // msg="There is no record with this user, please register first by clicking Register or check the user mail id or Password";
    final SnackBar = new prefix0.SnackBar(
      content: new Text(msg),
      duration: new Duration(seconds: 1),
      // action: new SnackBarAction(label: "Register",
      // onPressed: (){
      //   Navigator.pushNamed(context, "Register");
      // },),
    );
    _scaffoldKey.currentState.showSnackBar(SnackBar);
  }

  TextEditingController fullName;
  TextEditingController phoneNumber;
  TextEditingController signUPemail;

  TextEditingController address;
  bool showPwd = true;
  Icon _icon = Icon(
    Icons.visibility,
  );
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  void initState() {
    // TODO: implement initState
    fullName = new TextEditingController();
    phoneNumber = new TextEditingController();
    signUPemail = new TextEditingController();

    address = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final i = ModalRoute.of(context).settings.arguments;
    SizeConfig().find(context);
    var child = Container(
      height: SizeConfig.h * 0.82,
      width: SizeConfig.w,
      margin: EdgeInsets.only(top: SizeConfig.h * 0.18),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(80), topRight: Radius.circular(80))),
      child: Column(
        children: <Widget>[
          Center(
            child: Material(
              color: Colors.white,
              child: Text(
                "SignUp",
                style: TextStyle(
                    color: Colors.green, fontSize: SizeConfig.h * 0.046),
              ),
            ),
          ),
          // SizedBox(height: SizeConfig.h*0.1),

          Form(
            key: _form,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: 25,
                      left: SizeConfig.w * 0.07,
                      right: SizeConfig.w * 0.07),
                  child: Material(
                    color: Colors.white,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: Colors.grey, fontSize: SizeConfig.h * 0.02),
                        labelText: 'Full Name',
                        hintText: "Enter your Full Name",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontSize: SizeConfig.h * 0.02),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(SizeConfig.h * 2.5)),
                      ),
                      controller: fullName,
                      keyboardType: TextInputType.text,
                      // validator: emailValidator,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 25,
                      left: SizeConfig.w * 0.07,
                      right: SizeConfig.w * 0.07),
                  child: Material(
                    color: Colors.white,
                    child: TextFormField(
                      
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: Colors.grey, fontSize: SizeConfig.h * 0.02),
                        labelText: 'email',
                        hintText: "Enter your email",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontSize: SizeConfig.h * 0.02),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(SizeConfig.h * 2.5)),
                      ),
                      controller: signUPemail,
                      keyboardType: TextInputType.emailAddress,
                      // validator: pwdValidator,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 25,
                      left: SizeConfig.w * 0.07,
                      right: SizeConfig.w * 0.07),
                  child: Material(
                    color: Colors.white,
                    child: TextFormField(
                     
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: Colors.grey, fontSize: SizeConfig.h * 0.02),
                        labelText: 'Address',
                        hintText: "Enter your Address",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontSize: SizeConfig.h * 0.02),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(SizeConfig.h * 2.5)),
                      ),
                      controller: address,
                      keyboardType: TextInputType.multiline,
                      // validator: pwdValidator,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 25,
                      left: SizeConfig.w * 0.07,
                      right: SizeConfig.w * 0.07),
                  child: Material(
                    color: Colors.white,
                    child: TextFormField(
                     
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: Colors.grey, fontSize: SizeConfig.h * 0.02),
                        labelText: 'Phone num',
                        hintText: "Enter your num",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontSize: SizeConfig.h * 0.02),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(SizeConfig.h * 2.5)),
                      ),
                      controller: phoneNumber,
                      keyboardType: TextInputType.visiblePassword,
                      // validator: pwdValidator,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.h * 0.045),
            child: RaisedButton(
                padding: EdgeInsets.only(
                    top: SizeConfig.h * 0.01,
                    bottom: SizeConfig.h * 0.01,
                    left: SizeConfig.w * 0.3,
                    right: SizeConfig.w * 0.3),
                color: Colors.green,
                onPressed: () {
                  print("Verify OTP button is clicked");
                  if (_form.currentState.validate()) {
                    print("success");
                    FirebaseAuth.instance
                        .currentUser()
                        .then((Cur) => Firestore.instance
                            .collection("users")
                            .document(Cur.uid)
                            .setData({
                              "address": address.text,
                              "uid": Cur.uid,
                              "fname": fullName.text,
                              "email": signUPemail.text,
                              "mobile": phoneNumber.text,
                            })
                            .then((result) => {
                                  print("Successfully Registered Thank You!"),
                                // callSnackBar("user detals are entered successfully"),
                                  Navigator.pushNamed(context, "Main",
                                      arguments: i == "otp" ? "otp" : "gmail"),
                                  fullName.clear(),
                                  phoneNumber.clear(),
                                  signUPemail.clear(),
                                  address.clear()
                                })
                            .catchError((err) => print(err)))
                        .catchError((err) => print(err));
                  } else {
                      Navigator.pushNamed(context, "Main",
                                      arguments: i == "otp" ? "otp" : "gmail");
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(50.0),
                ),
                child: Text("SIGN UP",
                    style: TextStyle(color: Colors.white, fontSize: 22))),
          ),
        ],
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            child,
          ],
        ),
      ),
    );
  }
}
