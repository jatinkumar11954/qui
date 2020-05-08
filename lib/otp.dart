import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:indeed/short.dart';

class PhoneLogin extends StatefulWidget {
  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
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

  String status, actualCode;
  String phone;
  String smsCode;
  String verificationId;
  var _authCredential;

  Future<void> Phone(String smsCode) async {
    var firebaseAuth = await FirebaseAuth.instance;

    _authCredential = await PhoneAuthProvider.getCredential(
        verificationId: actualCode, smsCode: smsCode);
    firebaseAuth.signInWithCredential(_authCredential).catchError((error) {
      setState(() {
        status = 'Something has gone wrong, please try later';
      });
    }).then((user) {
      if (user.additionalUserInfo.isNewUser) {
        print("firest uset");
        return Navigator.pushNamed(context, "first", arguments: "otp");
      }
      setState(() {
        status = 'Authentication successful';
      });
      Navigator.pushNamed(context, "Main", arguments: "otp");
    });
  }

  Future<void> verifyPhone() async {
    var firebaseAuth = await FirebaseAuth.instance;

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.actualCode = verificationId;
      smsCodeDialog(context).then((value) {
        print("signed in");
      });

      setState(() {
        print('Code sent to $phone');
        status = "\nEnter the code sent to " + phone;
      });
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.actualCode = verificationId;
      setState(() {
        status = "\nAuto retrieval time out";
      });
    };
    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        status = '${authException.message}';

        print("Error message: " + status);
        if (authException.message.contains('not authorized'))
          status = 'Something has gone wrong, please try later';
        else if (authException.message.contains('Network'))
          status = 'Please check your internet connection and try again';
        else
          status = 'Something has gone wrong, please try later';
      });
    };
//     final PhoneCodeSent smsCodeSent =(String verId,[int forceCodeResend]){
//       this.verificationId=verId;
//       smsCodeDialog(context).then((value){
//         print("signed in");
//       });
//     };

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential auth) {
      setState(() {
        status = 'Auto retrieving verification code';
      });

      _authCredential = auth;
      print("auth");
      firebaseAuth
          .signInWithCredential(_authCredential)
          .then((AuthResult value) {
        if (value.user != null) {
          if (value.additionalUserInfo.isNewUser) {
            print("firest uset");
            return Navigator.pushNamed(context, "first", arguments: "otp");
          }
          setState(() {
            status = 'Authentication successful';
          });
          Navigator.pushNamed(context, "Main", arguments: "otp");
        } else {
          setState(() {
            status = 'Invalid code/invalid authentication';
          });
        }
      }).catchError((error) {
        setState(() {
          status = 'Something has gone wrong, please try later';
        });
      });
    };
    firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);

    // final PhoneVerificationCompleted verifiedSuccess = (FirebaseUser user){
    //   print("verified succcess");
    // };

    // final PhoneVerificationFailed veriFailed=(AuthException exception){
    //   print('${exception.message}');
    // };

    // await FirebaseAuth.instance.verifyPhoneNumber(
    //   phoneNumber: this.phoneNo,
    //   codeAutoRetrievalTimeout: autoRetrieve,
    //   codeSent:  smsCodeSent,
    //   timeout: const Duration(seconds: 3),
    //   verificationCompleted: verifiedSuccess,
    //   verificationFailed:  veriFailed,
    // );
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            // elevation: 200.0,
            // backgroundColor: Colors.white60,
            title: Text("Please Enter SMS Code"),
            titlePadding: EdgeInsets.all(20.0),
            content: TextFormField(
              // maxLength: 6,
              decoration: InputDecoration(
                  //  labelStyle:textStyle,
                  labelText: "SMS Code",
                  hintText: "Enter your 6 digits SMS Code",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          SizeConfig.blockSizeVertical * 1.5))),
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                child: Text("Done"),
                onPressed: () {
                  SmsValidator(smsCode);
                },
              )
            ],
          );
        });
  }

  // signIn(){
  //   FirebaseAuth.instance.signInWithPhoneNumber(
  //     verificationId: verificationId,
  //     smsCode: smsCode,

  //   ).then((user){
  //     Navigator.pushReplacementNamed(context, "HomeScreen");
  //   });

  // }

  String phoneValidator(String value) {
    if (value.length != 13 || value.length == null) {
      print("validation failed");
      // return 'Phone Number must be of 10 digits';
      callSnackBar("Phone Number must be of 10 digits");
    } else {
      callSnackBar("Sending Otp to mobile Number");
      verifyPhone();
      return null;
    }
  }

  String SmsValidator(String value) {
    if (value.length != 6 || value.length == null) {
      print("validation failed");
      // return 'Phone Number must be of 10 digits';
      callSnackBar(
          "Please Enter Proper 6 digit SMS code sent to your Mobile Number");
    } else {
      callSnackBar("You are signing in please wait !!");
      FirebaseAuth.instance.currentUser().then((user) {
        if (user != null) {
          Navigator.of(context).pop();
          Navigator.pushReplacementNamed(context, 'Main');
        } else {
          Navigator.of(context).pop();
          Phone(value);
        }
      });
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODOd: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Login with Phone Number"),
      ),
      body: WillPopScope(
        onWillPop: () {
          Navigator.pushReplacementNamed(context, "Login");
        },
        child: new Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 5.5,
                    bottom: SizeConfig.blockSizeVertical * 1.5,
                    right: SizeConfig.blockSizeVertical * 2.5),
                child: Text("Please Enter Your Mobile Number")),
            Padding(
              padding: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 0.5,
                  bottom: SizeConfig.blockSizeVertical * 1.5,
                  left: SizeConfig.blockSizeVertical * 2.5,
                  right: SizeConfig.blockSizeVertical * 2.5),
              child: TextFormField(
                // controller: phoneInput,
                onChanged: (value) {
                  this.phone = "+91" + value;
                },
                maxLength: 10,
                validator: phoneValidator,
                keyboardType: TextInputType.number,
                // style:textStyle,
                // keyboardType: Text(),
                decoration: InputDecoration(
                  // labelStyle:textStyle,

                  labelText: "Mobile",
                  hintText: "Enter your Mobile Number ",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          SizeConfig.blockSizeVertical * 2.5)),
                ),
              ),
            ),
            _isLoading
                ? CircularProgressIndicator()
                : SizedBox(
                    child: RaisedButton(
                    child: Text("Verify"),
                    color: Colors.green,
                    onPressed: () {
                      print("clicked verify button");
                      phoneValidator(phone);
                      setState(() {
                        print(" in first set");
                        _isLoading = true;
                      });
                      // callSnackBar("Sending Otp to mobile Number");
                      //  verifyPhone();
                      setState(() {
                        print("in 2 nd");
                        _isLoading = false;
                      });
                    },
                  )),
          ],
        ),
      ),
    );
  }
}
