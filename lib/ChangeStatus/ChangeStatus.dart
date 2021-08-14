import 'dart:convert';
import 'package:Easy_shopping_admin/DeliveredOrderList/DeliveredOrderList.dart';
import 'package:Easy_shopping_admin/ErrorLogIn/ErrorLogIn.dart';
import 'package:Easy_shopping_admin/HomePage/HomePage.dart';
import 'package:Easy_shopping_admin/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_shopping_admin/PendingOrderList/PendingOrderList.dart';
import 'package:Easy_shopping_admin/ProcessingOrderList/ProcessingOrderList.dart';
import 'package:Easy_shopping_admin/api/api.dart';
import 'package:Easy_shopping_admin/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ChangeStatus extends StatefulWidget {
  final data;
  final id;
  ChangeStatus(this.data,this.id);

  @override
  _ChangeStatusState createState() => _ChangeStatusState();
}

class _ChangeStatusState extends State<ChangeStatus> {


bool _isLoading = false;
    ///// Status Status Drop Down////////
  var statusList = ['Pending', 'Processing', 'Delivered'];
  //var statusList = [];
  var _currentStatusSelected="Pending";
  void statusListSelected(String newValueSelected) {

    if(newValueSelected=='Delivered'){
      _cancelOrder("Are you want to make this order delivered?");
    }
    else{
setState(() {
      this._currentStatusSelected = newValueSelected;
    });
    }
    
  }

    void initState() {
 _currentStatusSelected = widget.data;
  
  
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
          backgroundColor: appColor,
          title: Text("Change Status"),
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
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: [

            /////////////////  Status Status dropdown start ///////////////////

                  Container(
                    //color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Status",
                            style: TextStyle(
                                color: appColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),

                        ////////  Status Status dropdown /////////

                        Container(
                          margin: EdgeInsets.only(top: 6),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(
                              bottom: 1, top: 1, left: 20, right: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color: Color(0xFFE4E4E4), width: 1.5)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              icon: Icon(Icons.keyboard_arrow_down,
                                  size: 25, color: Color(0xFFC0C0C0)),
                              items: statusList.map((dynamic dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Text(
                                      dropDownStringItem,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Color(0xFF656565),
                                          fontSize: 16,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500),
                                    ));
                              }).toList(),
                              onChanged: (String newValueSelected) {
                                statusListSelected(newValueSelected);
                              },
                              value: _currentStatusSelected,
                            ),
                          ),
                        ),

                        GestureDetector(
                onTap: () {
                 
                  _isLoading? null : _submit();
                },
                child: Container(
                  margin:
                      EdgeInsets.only(bottom: 20, top: 25),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: appColor.withOpacity(0.9),
                      border: Border.all(width: 0.2, color: Colors.grey)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    
                      Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(  _isLoading?"Updaing...":"Update",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17)))
                    ],
                  ),
                ),
              ),
                      ],
                    ),
                  ),

                  ///////////////// Status Status dropdown End///////////////
          ],
        ),
      ),
      
    );
  }

  void _cancelOrder(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.all(5),
          title: Text(
            msg,
            // textAlign: TextAlign.,
            style: TextStyle(
                color: Color(0xFF000000),
                fontFamily: "grapheinpro-black",
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
          content: Container(
              height: 70,
              width: 250,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                          borderSide:
                              BorderSide(color: Colors.black, width: 0.5),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0)),
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
                              setState(() {
      this._currentStatusSelected = "Delivered";
    });
                              Navigator.of(context).pop();
                            
                            },
                            borderSide:
                                BorderSide(color: Colors.green, width: 0.5),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0))))
                  ])),
        );
      },
    );
  }
      void _submit() async {



    setState(() {
      _isLoading = true;
    });

    var data = {

      'id':widget.id,
      'status': _currentStatusSelected
     
    };


    var res = await CallApi().postData(data, '/api/editOrderStatus');
    var body = json.decode(res.body);
    print(body);


     if (res.statusCode == 200) {
     
if(_currentStatusSelected=="Pending"){
  Navigator.pushReplacement( context, SlideLeftRoute(page: PendingOrderList()));
}
else if(_currentStatusSelected=="Processing"){
  Navigator.pushReplacement( context, SlideLeftRoute(page: ProcessingOrderList()));
}
else if(_currentStatusSelected=="Delivered"){
  Navigator.pushReplacement( context, SlideLeftRoute(page: DeliveredOrderList()));
}
 }
     else if (res.statusCode == 401) {
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

    setState(() {
      _isLoading = false;
    });
  }
}
