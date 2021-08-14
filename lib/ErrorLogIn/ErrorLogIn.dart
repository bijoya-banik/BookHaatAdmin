import 'package:Easy_shopping_admin/Login/Login.dart';
import 'package:Easy_shopping_admin/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_shopping_admin/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class ErrorLogIn extends StatefulWidget {
  @override
  _ErrorLogInState createState() => _ErrorLogInState();
}

class _ErrorLogInState extends State<ErrorLogIn> {

     Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(
              "Exit",
              //  textAlign: TextAlign.center,
              style: TextStyle(
                  color: appColor,
                  fontFamily: "Oswald",
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            content: new Text(
              "Are you sure want to exit the app?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  //  color: Color(0xFFFF9100),
                  fontFamily: "Oswald",
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(
                  "No",
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontFamily: "Oswald",
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              new FlatButton(
                onPressed: () =>
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
                child: new Text(
                  "Yes",
                  style: TextStyle(
                      color: appColor,
                      fontFamily: "Oswald",
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                )
              ),
            ],
          ),
        )) ??
        false;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
          child: Scaffold(
          backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
                    child: Center(
              child: Container(
                margin: EdgeInsets.only(left:20, right:20),
                child: Column(
                  
                  children: [
                    Container(
                          margin: EdgeInsets.only(left:10, right:10, top:60),
                          child: Column(
                            children: [
                              Image.asset('assets/logo.png',
                              width: MediaQuery.of(context).size.width/1.5,
                              ),
                               Image.asset('assets/tagline.png',
                          ),
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 30),
                          child: Column(
                      children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              "Session Expired!",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontFamily: 'Oswald',
                                  fontWeight: FontWeight.w500),
                            )),

                      Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              "Your session has expired.Please log in again to continue",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            )),
                      ],
                    ),
                        ),
                   

                   GestureDetector(
                            onTap: (){
                              Navigator.push( context, SlideLeftRoute(page: Login()));
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(left: 20, right: 20, top:40),
                                decoration: BoxDecoration(
                                    color: appColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                child: Text(
                                "Log in",
                                  style: TextStyle(
                                    color:  Colors.white,
                                    fontSize: 17,
                                  ),
                                  textAlign: TextAlign.center,
                                )),
                          ),

                     
                  ],
                ),
              ),
            ),
          )),
        
      ),
    );
  }
}