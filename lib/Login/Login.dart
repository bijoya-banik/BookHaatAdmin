import 'dart:convert';
import 'package:Easy_shopping_admin/HomePage/HomePage.dart';
import 'package:Easy_shopping_admin/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_shopping_admin/api/api.dart';
import 'package:Easy_shopping_admin/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';




class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
 
 final _scaffoldKey = GlobalKey<ScaffoldState>();
var appToken;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _showMsg(msg) {
   
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
    @override
  void initState() {
 _firebaseMessaging.getToken().then((token) async {
      print("Notification app token");
      print(token);
      appToken = token;
    });
    super.initState();
  }
  

    bool _isLoading = false;

   TextEditingController loginEmailController  = TextEditingController();
   TextEditingController loginPasswordController  = TextEditingController();

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(
              "Exit",
              //  textAlign: TextAlign.center,
              style: TextStyle(
                  color: appColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            content: new Text(
              "Are you sure want to exit the app?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(
                  "No",
                  style: TextStyle(
                      color: Colors.red[900],
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              new FlatButton(
                  onPressed: () => SystemChannels.platform
                      .invokeMethod('SystemNavigator.pop'),
                  child: new Text(
                    "Yes",
                    style: TextStyle(
                        color: appColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  )),
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
              key: _scaffoldKey,
                    body: Container(
            
                 decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/ecom.jpg"),
                fit: BoxFit.cover,
                 colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
              ),
            ),
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                  content: SingleChildScrollView(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          color: Colors.transparent,
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(20),
                              margin: EdgeInsets.only(top: 35),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(top: 25),
                                      child: Text(
                                        "Sign in to your account",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: appColor,
                                            fontSize: 14,
                                            fontFamily: 'Oswald',
                                            fontWeight: FontWeight.w500),
                                      )),


                                      ////////////////////////   log in phone start //////////////////
                               
                               
                                  Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(5),
                                    margin: EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(5.0)),
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 0.2, color: Colors.grey)),
                                    child: TextFormField(
                                      autofocus: false,
                                      controller: loginEmailController,
                                      cursorColor: Colors.grey,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(fontSize: 14),
                                      decoration: InputDecoration(
                                        icon: Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: const Icon(
                                            Icons.phone,
                                            color: Colors.black38,
                                            size: 17,
                                          ),
                                        ),
                                        hintText: 'Phone',
                                        hintStyle: TextStyle(fontSize: 14),
                                        //labelText: 'Enter E-mail',
                                        contentPadding:
                                            EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 15.0),
                                        border: InputBorder.none,
                                      ),
                                      //validator: _validateEmail,
                                    ),
                                  ),

                                      ////////////////////////   log in phone end //////////////////
                                  
                                  SizedBox(height: 2,),
                                      ////////////////////////   log in password start //////////////////
                                  
                                  Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(5),
                                    margin: EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(5.0)),
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 0.2, color: Colors.grey)),
                                    child: TextFormField(
                                      cursorColor: Colors.grey,
                                      autofocus: false,
                                      obscureText: true,
                                      controller: loginPasswordController,
                                      keyboardType: TextInputType.text,
                                      style: TextStyle(fontSize: 14),
                                      decoration: InputDecoration(
                                        icon: Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: const Icon(
                                            Icons.lock,
                                            color: Colors.black38,
                                            size: 17,
                                          ),
                                        ),
                                        hintText: 'Password',
                                        hintStyle: TextStyle(fontSize: 14),

                                        //labelText: 'Enter E-mail',
                                        contentPadding:
                                            EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 15.0),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),

                                      ////////////////////////   log in password end //////////////////
                                
                                    ////////////////////////   log in Button start //////////////////
                                
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                             
                                              
                                                  _isLoading?null:_logInButton();
                                            
                                            },
                                            child: Container(
                                                padding: EdgeInsets.all(10),
                                                margin: EdgeInsets.only(
                                                    left: 0,
                                                    right: 0,
                                                    top: 10,
                                                    bottom: 0),
                                                decoration: BoxDecoration(
                                                  color: appColor,
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(5))),
                                                child: Text(
                                                  _isLoading?"Please wait...":"Login",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),


                                      ////////////////////////   log in button end //////////////////
                                
                                
                                  
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[


                                       ////////////////////////   skip login start //////////////////
                                  // GestureDetector(
                                  //   onTap: (){

                                  //    Navigator.pop(context);
                                  //   },
                                  //                               child: Container(
                                  //       margin: EdgeInsets.only(
                                  //           left: 0, top: 15, bottom: 0),
                                  //       child: Text(
                                  //         "Skip",
                                  //         style: TextStyle(
                                  //             color: Colors.black54,
                                  //             fontSize: 12,
                                  //             fontWeight: FontWeight.w400),
                                  //       )),
                                  // ),

                                       ////////////////////////   skip login  end //////////////////
                                     
                                     
                                       ////////////////////////   forget password start //////////////////
                              //          GestureDetector(
                              //           onTap: (){

                              // //              Navigator.push(
                              // // context, SlideLeftRoute(page: VerifyEmail()));
                              //           },
                              //                                       child: Container(
                              //               margin: EdgeInsets.only(
                              //                   left: 0, top: 15, bottom: 0),
                              //               child: Text(
                              //                 "Forget password?",
                              //                 style: TextStyle(
                              //                     color: appColor,
                              //                     fontSize: 12,
                              //                     fontWeight: FontWeight.w400),
                              //               )),
                              //         ),
                                    ],
                                  ),

                                       ////////////////////////   forget password end //////////////////
                                ],
                              ),
                            ),


                             
                          ],
                        ),
                        
                      ],
                    ),
                  ),
                ),
              
            ),
          ),
        );
    }



    
    void _logInButton() async {


  // String patternEmail =
  //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  //   RegExp regExpEmail = new RegExp(patternEmail);

    if (loginEmailController.text.isEmpty) {
      return _showMsg("Phone number is empty");
    }
    if (loginEmailController.text.length !=11 ) {
      return _showMsg("Phone number is invalid");
    }
    // else if (!regExpEmail.hasMatch(loginEmailController.text)) {
    //   return _showMsg("Invalid Email");
    // } 
    else if (loginPasswordController.text.isEmpty) {
      return _showMsg("Password is empty");
    }


    setState(() {
      _isLoading = true;
    });

    var data = {

      'phone': loginEmailController.text,
      'password': loginPasswordController.text,
      'deviceToken': appToken,
     
    };
print(data);

    var res = await CallApi().withoutTokenPostData(data, '/api/login');
    var body = json.decode(res.body);
    print(body);


     if (res.statusCode == 200) {
       

    if(body['user']['userType']!="Admin"){
         _showMsg("You are not admin");
    }
    else{

      SharedPreferences localStorage = await SharedPreferences.getInstance();
       
       localStorage.setString('user', json.encode(body['user']));
       localStorage.setString('token', body['token']);
  Navigator.push( context, SlideLeftRoute(page: HomePage()));
    }

 

     }
       else if (res.statusCode == 400){
         _showMsg("Invalid Phone Number or Password");
      }
      else{
         _showMsg("Something Wrong! Try again");
      }
   

    setState(() {
      _isLoading = false;
    });
  }
}