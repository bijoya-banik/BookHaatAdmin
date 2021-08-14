import 'dart:convert';
import 'package:Easy_shopping_admin/ChangeStatus/ChangeStatus.dart';
import 'package:Easy_shopping_admin/ErrorLogIn/ErrorLogIn.dart';
import 'package:Easy_shopping_admin/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_shopping_admin/OrderDetails/OrderDetails.dart';
import 'package:Easy_shopping_admin/api/api.dart';
import 'package:Easy_shopping_admin/main.dart';
import 'package:Easy_shopping_admin/redux/action.dart';
import 'package:Easy_shopping_admin/redux/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PendingOrderList extends StatefulWidget {
  @override
  _PendingOrderListState createState() => _PendingOrderListState();
}

class _PendingOrderListState extends State<PendingOrderList> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _status = ['Block', 'House', 'Road', 'Street', 'Area'];
  var _sendType = 'asc';
  var _currentStatusSelected = 'Block';
  double amount = 0.0;
  String dateFr = '';
  String dateTo = '';
  DateTime selectedDateFrom = DateTime.now();
  DateTime selectedDateTo = DateTime.now();
  void _statusDropDownSelected(String newValueSelected) {
    setState(() {
      this._currentStatusSelected = newValueSelected;
    });
  }

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
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }


  var body;

  var statusData;
  bool _isLoading = true;
  bool _isDropData = true;
  bool _isSearched = false;
   var userData;
  DateTime selectedDate = DateTime.now();
  var format;
  @override
  void initState() {
  _getUserInfo();
  
  
    super.initState();
  }

      Future<void> _showOrders() async {
    var res = await CallApi().getData('/api/showOrdersType/Pending');

    if (res.statusCode == 200) {
      var body = json.decode(res.body);

      print(body);
      List orderList =  body['Order'];

      store.dispatch(PendingOrderListAction(orderList.reversed.toList()));
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
    store.dispatch(PendingOrderLoadingAction(false));
  }

  
    void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    if (userJson != null) {
      var user = json.decode(userJson);
      //setState(() {
        userData = user;
    //  });

       _showOrders();
    }
  }

  Future<void> _allData() async {
    
    _showOrders();
  }





  

  @override
  Widget build(BuildContext context) {
       return  StoreConnector<AppState, AppState>(
          ////// this is the connector which mainly changes state/ui
          converter: (store) => store.state,
          builder: (context, items) {
            return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: appColor,
          titleSpacing: 0,
          title: Text("Pending Orders"),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigator.push( context, FadeRoute(page: OrderType()));
                },
              );
            },
          ),
          
        ),
        body: 
        store.state.pendingOrderLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : 
            store.state.pendingOrderList.length == 0
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Container(
                      //     width: 100,
                      //     height: 110,
                      //     decoration: new BoxDecoration(
                      //         shape: BoxShape.rectangle,
                      //         image: new DecorationImage(
                      //           fit: BoxFit.fill,
                      //           image: new AssetImage(
                      //               'assets/images/empty_box.png'),
                      //         ))),
                      Container(
                        margin: EdgeInsets.only(top:40),
                        child: Text(
                          "You have no order",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: appColor,
                              fontFamily: "sourcesanspro",
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ))
                : RefreshIndicator(
                    onRefresh: _allData,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Container(
                        padding: EdgeInsets.only(top: 5, bottom: 12),
                        margin: EdgeInsets.only(left: 5, right: 5, top: 2),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: _showOrdersList()),
                      ),
                    ),
                  ),

      
      );
          }
    );
  }

  List<Widget> _showOrdersList() {
    List<Widget> list = [];
    // int checkIndex=0;
    for (var d in store.state.pendingOrderList) {
      
     

      list.add(
        // Slidable(
        //   actionPane: SlidableDrawerActionPane(),
        //   actionExtentRatio: 0.25,
        //   child: 
          GestureDetector(
            onTap: () {
               Navigator.push( context, FadeRoute(page: OrderDetails(d)));
            },
            child: Stack(
              children: <Widget>[
                Card(
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
                    padding: EdgeInsets.only(
                        right: 12, left: 12, top: 10, bottom: 10),
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
                              Expanded(
                                child: Container(
                                  //color: Colors.red,
                                  margin: EdgeInsets.only(left: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2 +
                                                10,
                                            child: Text(
                                              d['id'] == null
                                                  ? "---"
                                                  : "Order Id: " +
                                                      d['id'].toString(),
                                              overflow: TextOverflow.ellipsis,
                                              //  textDirection: TextDirection.ltr,
                                              style: TextStyle(
                                                  color: appColor,
                                                  fontFamily: "sourcesanspro",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          // Container(
                                          //   child: Text(
                                          //     "\$ 45.00",
                                          //     textDirection: TextDirection.ltr,
                                          //     style: TextStyle(
                                          //         color: appColor,
                                          //         fontFamily: "sourcesanspro",
                                          //         fontSize: 15,
                                          //         fontWeight: FontWeight.bold),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text(
                                          d['status'] == null
                                              ? "---"
                                              : 'Order Status is ' +
                                                  d['status'].toString(),
                                          overflow: TextOverflow.ellipsis,
                                          //  textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                              color: Color(0xFF343434),
                                              fontFamily: "sourcesanspro",
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text(
                                          d['phone'] == null
                                              ? "":"Mobile: "+d['phone'].toString(),
                                          overflow: TextOverflow.ellipsis,
                                          // textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                              color: Color(0xFF343434),
                                              fontFamily: "sourcesanspro",
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      d['grandTotal'] == null
                                          ? Container()
                                          : Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text(
                                                 d['grandTotal'] == null
                                                    ? ''
                                                    : "Total : " +
                                                        d['grandTotal']
                                                            .toString() +
                                                        " BHD",

                                                overflow: TextOverflow.ellipsis,
                                                // textDirection: TextDirection.ltr,
                                                style: TextStyle(
                                                    color: Color(0xFF343434),
                                                    fontFamily: "sourcesanspro",
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                      Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text(
                                                d['created_at'] == null
                                                    ? ''
                                                    : "Order Date : " +
                                                    DateFormat.yMMMd().add_jm().format(DateTime.parse(d['created_at']).add(new Duration(hours: 6))).toString(),

                                                overflow: TextOverflow.ellipsis,
                                                // textDirection: TextDirection.ltr,
                                                style: TextStyle(
                                                    color: Color(0xFF343434),
                                                    fontFamily: "sourcesanspro",
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                      d['updated_at'] == null
                                          ? Container()
                                          : Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text(
                                                d['updated_at'] == null
                                                    ? ''
                                                    : "Status Date : " +
                                                        DateFormat.yMMMd().add_jm().format(DateTime.parse(d['updated_at']).add(new Duration(hours: 6))).toString(),

                                                overflow: TextOverflow.ellipsis,
                                                // textDirection: TextDirection.ltr,
                                                style: TextStyle(
                                                    color: Color(0xFF343434),
                                                    fontFamily: "sourcesanspro",
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ),

                              // IconButton(
                              //   icon: Icon(Icons.delete,
                              //   color: appColor),
                              //   onPressed: (){
                              //               _deleteOrder();

                              //   }

                              // )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                d['isClick'] != null
                    ? Container(
                        margin: EdgeInsets.all(8),
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.check_circle,
                          color: appColor,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          );
    }

    return list;
  }



}
