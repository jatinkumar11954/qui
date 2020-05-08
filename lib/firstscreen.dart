import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:indeed/singin_page.dart';
import 'short.dart';
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
        final i = ModalRoute.of(context).settings.arguments;
        print(i);
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            FutureBuilder(
            future: FirebaseAuth.instance.currentUser(),
            // . then((user){
            //       if(user!=null){
            //          print("Navigator.of(context).pop();");
            //          Text('Loading...');
            //           print("Navigator.of(context).pop();");
            //       }
            //       else{
            //         print("Navigator");
            //       }
            //     }),
            builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Text("\n   Gmail ID:  "+snapshot.data.phoneNumber,style: TextStyle(color:Colors.red,fontSize:SizeConfig.blockSizeVertical * 2.5),),
                );
              }
              else {
                return Text('Loading...');
              }
            },
    ),
    Padding(
      padding: const EdgeInsets.all(58.0),
      child: FlatButton(onPressed: (){signOutGoogle(); FirebaseAuth.instance
                  .signOut()
                  .then((result) =>
                      Navigator.pushReplacementNamed(context, "login"))
                  .catchError((err) => print(err));
      }, child: Text("Logout")),
    )
          ],
        ),
      ),
      
    );
  }
}