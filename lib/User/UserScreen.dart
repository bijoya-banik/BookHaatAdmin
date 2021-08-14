import 'dart:convert';
import 'package:Easy_shopping_admin/Category/AddCategory.dart';
import 'package:Easy_shopping_admin/Category/EditCategory.dart';
import 'package:Easy_shopping_admin/ErrorLogIn/ErrorLogIn.dart';
import 'package:Easy_shopping_admin/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_shopping_admin/api/api.dart';
import 'package:Easy_shopping_admin/main.dart';
import 'package:Easy_shopping_admin/redux/action.dart';
import 'package:Easy_shopping_admin/redux/state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  TextEditingController categoryController = new TextEditingController();
  var body;
  var categoryData;

  _showMsg(msg) {
    //
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  bool _isLoading = false;

  @override
  void initState() {
    _showCategory();
    super.initState();
  }

  Future<void> _allData() async {
    _showCategory();
  }

  Future<void> _showCategory() async {
    var res = await CallApi().getData('/api/showAllUser');

    if (res.statusCode == 200) {
      var body = json.decode(res.body);

      print(body);

      store.dispatch(UserListAction(body['User']));
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
    store.dispatch(UserLoadingAction(false));
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: StoreConnector<AppState, AppState>(
            ////// this is the connector which mainly changes state/ui
            converter: (store) => store.state,
            builder: (context, items) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: appColor,
                  title: Text("User"),
                ),
                body: RefreshIndicator(
                    onRefresh: _allData,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: store.state.userLoading
                          ? Center(
                              child: Container(
                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
                              child: CircularProgressIndicator(),
                            ))
                          : store.state.userList.length == 0
                              ? Center(
                                  child: Container(
                                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
                                      child: Text(
                                        "No User Found",
                                        overflow: TextOverflow.ellipsis,
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(color: appColor, fontFamily: "sourcesanspro", fontSize: 20, fontWeight: FontWeight.bold),
                                      )),
                                )
                              : Container(
                                  padding: EdgeInsets.only(top: 5, bottom: 12),
                                  margin: EdgeInsets.only(left: 5, right: 5, top: 2),
                                  child: Column(mainAxisAlignment: MainAxisAlignment.start, children: _showuserList()),
                                ),
                    )),
              );
            }));
  }

  List<Widget> _showuserList() {
    List<Widget> list = [];
    // int checkIndex=0;
    for (var d in store.state.userList) {
      list.add(categoryCard(d));
    }

    return list;
  }

  Card categoryCard(d) {
    return Card(
      elevation: 1,
      // margin: EdgeInsets.only(bottom: 5, top: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200],
              blurRadius: 16.0,
              // offset: Offset(0.0,3.0)
            )
          ],
          // border: Border.all(
          //   color: Color(0xFF08be86)
          // )
        ),
        padding: EdgeInsets.only(right: 12, left: 12, top: 10, bottom: 10),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        //color: Colors.blue,
        child: Column(
          children: <Widget>[
            Container(
              //color: Colors.red,
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 8,
                    padding: EdgeInsets.all(1.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Image.asset(
                          'assets/images/profile.png',
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width / 8,
                        )),
                    decoration: new BoxDecoration(
                      color: Colors.grey[300], // border color
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      //color: Colors.red,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                 padding: const EdgeInsets.only(left:15,),        
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                     
                                      child: Row(
                                         mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                         
                                            child: Text(
                                              d['firstName'] == null ? "" : d['firstName']+" ",
                                              overflow: TextOverflow.ellipsis,
                                              textDirection: TextDirection.ltr,
                                              style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                           Container(
                                             child: Text(
                                               d['lastName'] == null ? "" : d['lastName'],
                                               overflow: TextOverflow.ellipsis,
                                               textDirection: TextDirection.ltr,
                                               style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                             ),
                                           ),
                                        ],
                                      ),
                                    ),

                                     Container(
                                         padding: const EdgeInsets.only(top:5,),   
                                               child: Text(
                                              d['phone'] == null ? "" : d['phone'],
                                              overflow: TextOverflow.ellipsis,
                                              textDirection: TextDirection.ltr,
                                              style: TextStyle(color: Colors.black, fontSize: 13, 
                                              fontWeight: FontWeight.normal),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _modalBottomSheet(context, d);
                                },
                                child: Icon(Icons.more_vert),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _modalBottomSheet(context, d) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Wrap(
                  children: <Widget>[
                    ListTile(
                        leading: new Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                        title: Row(
                          children: [
                            new Text('Delete', style: TextStyle(fontWeight: FontWeight.normal, color: Colors.redAccent, fontFamily: "Oswald")),
                          ],
                        ),
                        onTap: () {
                          _delete(d);
                          Navigator.of(context).pop();
                          _isLoading ? _showDeleteDialog() : null;
                        }),
                  ],
                ));
          });
        });
  }

  void _delete(d) async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      'id': d['id'],
    };

    print(data);

    var res = await CallApi().postData(data, '/api/deleteUser');

    var body = json.decode(res.body);
    print(body);

    if (res.statusCode == 200) {
      for (var data in store.state.userList) {
        if (data['id'] == d['id']) {
          store.state.userList.remove(d);
          break;
        }
      }

      store.dispatch(UserListAction(store.state.userList));
      Navigator.of(context).pop();
    }
    //  else if (body['message'].contains("Duplicate entry")) {
    //      _showMsg("You have already created same category ");
    //   }

    else {
      _showMsg("Something is wrong! Try Again");
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<Null> _showDeleteDialog() async {
    return showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                content: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 28,
                      width: 28,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        backgroundColor: Colors.grey.withOpacity(0.3),
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[400]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 12),
                      child: Text(
                        "Processing...",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black87, fontSize: 16, fontFamily: 'Oswald', fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ));
          });
        });
  }

  // void _addCategory() async{

  //   if (categoryController.text.isEmpty) {
  //     return _showMsg("Category name is empty");
  //   }

  //   setState(() {
  //     _isLoading = true;
  //   });

  //   var data = {

  //     'category': categoryController.text,

  //   };

  //   print(data);

  //   var res = await CallApi().postData(data, '/app/storeCategory');
  //   print(res);
  //   var body = json.decode(res.body);
  //   print(body);

  //     if (body['success'] == true) {
  //     //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //     //   localStorage.setString('token', body['token']);
  //     // //  localStorage.setString('pass', loginPasswordController.text);
  //     //   localStorage.setString('user', json.encode(body['user']));

  //   Navigator.push( context, FadeRoute(page: userList()));

  //    }
  //      else {
  //        _showMsg("Invalid Phone or Password");
  //     }

  //   setState(() {
  //     _isLoading = false;
  //   });

  // }
}
