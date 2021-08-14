import 'dart:convert';
import 'dart:io';
import 'package:Easy_shopping_admin/AllOrderList/AllOrderList.dart';
import 'package:Easy_shopping_admin/AllProducts/AllProducts.dart';
import 'package:Easy_shopping_admin/Category/CategoryList.dart';
import 'package:Easy_shopping_admin/ErrorLogIn/ErrorLogIn.dart';
import 'package:Easy_shopping_admin/FeedbackScreen.dart';
import 'package:Easy_shopping_admin/Login/Login.dart';
import 'package:Easy_shopping_admin/Logout/Logout.dart';
import 'package:Easy_shopping_admin/Menu.dart';
import 'package:Easy_shopping_admin/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_shopping_admin/NotificationsScreen/NotificationsScreen.dart';
import 'package:Easy_shopping_admin/OrderType/OrderType.dart';
import 'package:Easy_shopping_admin/PdfBook/PdfBookScreen.dart';
import 'package:Easy_shopping_admin/ProductsType/ProductsType.dart';
import 'package:Easy_shopping_admin/User/UserScreen.dart';
import 'package:Easy_shopping_admin/api/api.dart';
import 'package:Easy_shopping_admin/main.dart';
import 'package:Easy_shopping_admin/redux/action.dart';
import 'package:Easy_shopping_admin/redux/state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var body;
  List productsData = ["4", "5"];
  List orderData = ["2"];
  List initialList = [
    {"name": "Books", "image": "assets/images/book.png"},
    {"name": "PDF", "image": "assets/images/pdf.png"},
    {"name": "Category", "image": "assets/images/cat.png"},
    {"name": "Order", "image": "assets/images/order.png"},
    {"name": "Users", "image": "assets/images/user.png"},
    {"name": "Feedback", "image": "assets/images/feed.png"},
  ];
  var unseenNotific = 0;
  bool _isLoading = true;
  TextEditingController taxController = new TextEditingController();
  bool _fromTop = true;
  var appToken;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    /// add firebase notification/////

    _showInitData();

    /// add firebase notification/////

    // _firebaseMessaging.getToken().then((token) async {
    //   print("Notification app token");
    //   print(token);
    //   appToken = token;
    // });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");

        _showNotificationPop(message['notification']['title'], message['notification']['body']);
      },
      onLaunch: (Map<String, dynamic> message) async {
        pageLaunch(message);
      },
      onResume: (Map<String, dynamic> message) async {
        pageDirect(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    super.initState();
  }

  ///// handle looping onlaunch firebase //////
  void pageDirect(Map<String, dynamic> msg) {
    print("onResume: $msg");
    setState(() {
      index = 1;
    });
    Navigator.push(context, FadeRoute(page: AllOrderList()));
  }

  void pageLaunch(Map<String, dynamic> msg) {
    print("onLaunch: $msg");
    pageRedirect();
  }

  void pageRedirect() {
    if (index != 1 && index != 2) {
      Navigator.push(context, FadeRoute(page: AllOrderList()));
      setState(() {
        index = 2;
      });
    }
  }

  ///// end handle looping onlaunch firebase //////

  // void _sendApptoken() async {
  //   var data = {'app_token': appToken};

  //   print(data);
  //   var res = await CallApi().postData(data, '/app/storeApptoken');
  //   var body = json.decode(res.body);
  //   print(body);
  // }

  Future<void> _allData() async {
    _showInitData();
  }

  ///// end handle looping onlaunch firebase //////

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            //   title: new Text('Are you sure?'),
            content: new Text('Do you want to exit this App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(
                  'No',
                  style: TextStyle(color: appColor),
                ),
              ),
              new FlatButton(
                onPressed: () => exit(0),
                child: new Text(
                  'Yes',
                  style: TextStyle(color: appColor),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  void choiceAction(String choice) {
    if (choice == Menu.Logout) {
      _logoutDialog();
    }
  }

  Future<void> _showInitData() async {
    var res = await CallApi().getData('/api/totalData');

    if (res.statusCode == 200) {
      var body = json.decode(res.body);

      store.dispatch(TotalProduct(body['TotalProduct']));
      store.dispatch(TotalCategory(body['TotalCategory']));
      store.dispatch(TotalOrder(body['TotalOrder']));
    } else if (res.statusCode == 401) {
      Navigator.push(context, SlideLeftRoute(page: ErrorLogIn()));
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong!! Try again",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: appColor.withOpacity(0.9),
          textColor: Colors.white,
          fontSize: 13.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: StoreConnector<AppState, AppState>(
          ////// this is the connector which mainly changes state/ui
          converter: (store) => store.state,
          builder: (context, items) {
            return Scaffold(
              body:
                  //  _isLoading
                  //     ? Center(
                  //         child: CircularProgressIndicator(),
                  //       )
                  //     :
                  SafeArea(
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            color: appColor,
                            //
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  // alignment: Alignment.topRight,
                                  child: PopupMenuButton<String>(
                                    onSelected: choiceAction,
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: Colors.white,
                                    ),
                                    itemBuilder: (BuildContext context) {
                                      return Menu.choices.map((String choice) {
                                        return PopupMenuItem<String>(
                                          value: choice,
                                          child: Text(choice),
                                        );
                                      }).toList();
                                    },
                                  ),
                                ),
                                //
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 40, left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                   
                                    Image.asset(
                                      'assets/images/books.png',
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.fill,
                                    ),
                                     Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "BookHaat",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(color: Colors.white, fontSize: 30),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                          child: Container(
                        margin: EdgeInsets.only(top: 130),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          gradient: LinearGradient(begin: Alignment.centerRight, end: Alignment.topLeft, stops: [
                            0.1,
                            0.4,
                            0.6,
                            0.9
                          ], colors: [
                            Colors.grey[200],
                            Colors.grey[200],
                            Colors.white,
                            Colors.white,
                          ]),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          child: RefreshIndicator(
                            onRefresh: _allData,
                            child: Container(
                              margin: EdgeInsets.all(5),
                              child: GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 0,
                                  childAspectRatio: (MediaQuery.of(context).size.width / 3) / (MediaQuery.of(context).size.height / 5),
                                ),
                                itemBuilder: (BuildContext context, int index) => new Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: GestureDetector(
                                      onTap: () {
                                        if (index == 0) {
                                          Navigator.push(context, FadeRoute(page: ProductsType()));
                                        } else if (index == 1) {
                                          Navigator.push(context, FadeRoute(page: PdfBookScreen()));
                                        } else if (index == 2) {
                                          Navigator.push(context, FadeRoute(page: CategoryList()));
                                        } else if (index == 3) {
                                          Navigator.push(context, FadeRoute(page: AllOrderList()));
                                        } else if (index == 4) {
                                          Navigator.push(context, FadeRoute(page: UserScreen()));
                                        } else if (index == 5) {
                                          Navigator.push(context, FadeRoute(page: FeedbackScreen()));
                                        }
                                      },
                                      child: cardDesign(initialList[index]['name'], initialList[index]['image'])),
                                ),
                                itemCount: initialList.length,
                              ),
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Container cardDesign(String title, String img) {
    return Container(
      child: Card(
        color: Colors.red,
        elevation: 0,
        margin: EdgeInsets.only(left: 5, right: 5, top: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: Colors.white,
            border: Border.all(width: 0.2, color: Colors.grey),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[200],
                blurRadius: 17,
              ),
            ],
          ),
          height: 100,
          width: MediaQuery.of(context).size.width / 2,
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  color: Colors.white,
                ),
                child: Image.asset(
                  img,
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _logOutDialog() {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        //   title: new Text('Are you sure?'),
        content: new Text('Do you want to logout'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text(
              'No',
              style: TextStyle(color: appColor),
            ),
          ),
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              _logout();
            },
            child: new Text(
              'Yes',
              style: TextStyle(color: appColor),
            ),
          ),
        ],
      ),
    );
  }

  ////////////////////////  Log Out Start  //////////////////////
  void _logout() async {
    Navigator.push(context, new MaterialPageRoute(builder: (context) => Logout()));
  }
  ///////////////////////////  Log Out End /////////////////////////

  void _showNotificationPop(String title, String msg) {
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (BuildContext context, anim1, anim2) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            // Navigator.push(context, SlideLeftRoute(page: NotificationPage()));
          },
          child: Material(
            type: MaterialType.transparency,
            child: Align(
              alignment: _fromTop ? Alignment.topCenter : Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  bottomNavIndex = 4;
                  Navigator.push(context, FadeRoute(page: AllOrderList()));
                },
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    //  final item = items[index];

                    return Dismissible(
                      key: Key("item"),
                      onDismissed: (direction) {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 80,
                        child: SizedBox.expand(
                            child: Container(
                          padding: EdgeInsets.only(left: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ////////////   Address  start ///////////

                              ///////////// Address   ////////////

                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 5, top: 2, bottom: 0),
                                  child: Text(title,
                                      textAlign: TextAlign.left, style: TextStyle(color: appColor, fontSize: 16, fontWeight: FontWeight.bold))),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 5, top: 2, bottom: 8),
                                  child: Text(msg,
                                      textAlign: TextAlign.left, style: TextStyle(color: appColor, fontSize: 14, fontWeight: FontWeight.normal))),
                            ],
                          ),
                        )),
                        margin: EdgeInsets.only(top: 50, left: 12, right: 12, bottom: 50),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, _fromTop ? -1 : 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }

  void _logoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.all(5),
          title: Text(
            "Are you sure want to logout?",
            // textAlign: TextAlign.,
            style: TextStyle(color: Color(0xFF000000), fontFamily: "grapheinpro-black", fontSize: 14, fontWeight: FontWeight.w500),
          ),
          content: Container(
              height: 70,
              width: 250,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    width: 110,
                    height: 45,
                    margin: EdgeInsets.only(
                      top: 25,
                      bottom: 15,
                    ),
                    child: OutlineButton(
                      child: new Text(
                        "No",
                        style: TextStyle(color: Colors.black),
                      ),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                    )),
                Container(
                    decoration: BoxDecoration(
                      color: appColor.withOpacity(0.9),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    width: 110,
                    height: 45,
                    margin: EdgeInsets.only(top: 25, bottom: 15),
                    child: OutlineButton(
                        // color: Colors.greenAccent[400],
                        child: new Text(
                          "Yes",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          _logout();
                        },
                        borderSide: BorderSide(color: Colors.green, width: 0.5),
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0))))
              ])),
        );
        //return SearchAlert(duration);
      },
    );
  }
}
