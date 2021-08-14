

import 'package:Easy_shopping_admin/DeliveredOrderList/DeliveredOrderList.dart';
import 'package:Easy_shopping_admin/HomePage/HomePage.dart';
import 'package:Easy_shopping_admin/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_shopping_admin/AllOrderList/AllOrderList.dart';
import 'package:Easy_shopping_admin/PendingOrderList/PendingOrderList.dart';
import 'package:Easy_shopping_admin/ProcessingOrderList/ProcessingOrderList.dart';
import 'package:Easy_shopping_admin/main.dart';
import 'package:flutter/material.dart';

class OrderType extends StatefulWidget {
  @override
  _OrderTypeState createState() => _OrderTypeState();
}

class _OrderTypeState extends State<OrderType> {

  @override
  void initState() {
    
    super.initState();
  }

   Future<bool> _onWillPop() async {
   Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(

         appBar: AppBar(
           titleSpacing: 0,
          backgroundColor: appColor,
          leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () { 
            // Navigator.of(context).pop();
             Navigator.push(
            context, new MaterialPageRoute(builder: (context) => HomePage()));
          },
        );
      },
  ),
          title: Text("Orders",
              style: TextStyle(fontSize: 20, color: Colors.white)),
        ),

        body: SafeArea(
                child: new Container(
                    padding: EdgeInsets.all(0.0),
                    //color: Colors.white,
                    child: Column(
                      children: <Widget>[
                       
                      
                        Expanded(
                          child: Container(
                            child: ListView(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                     Navigator.push(
            context, new MaterialPageRoute(builder: (context) => AllOrderList()));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(top: 8, bottom: 8),
                                    child: ListTile(
                                      title: Container(
                                          child: Row(
                                        children: <Widget>[
                                         
                                          Container(
                                            margin: EdgeInsets.only(left: 8),
                                            child: Text(
                                              'Orders',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      )),
                                      trailing: Icon(Icons.chevron_right),
                                    ),
                                  ),
                                ),
                                Divider(height: 0,color: Colors.grey,),
                                GestureDetector(
                                  onTap: () {
                                   Navigator.push( context, FadeRoute(page: PendingOrderList()));
                                  },
                                  child: Container(
                                      padding: EdgeInsets.only(top: 8, bottom: 8),
                                    child: ListTile(
                                      title: Container(
                                        
                                          child: Row(
                                        children: <Widget>[
                                         
                                          Container(
                                            

                                            margin: EdgeInsets.only(left: 8),
                                            child: Text(
                                              'Pending Order',
                                              style:
                                                  TextStyle(color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      )),
                                      trailing: Icon(Icons.chevron_right),
                                    ),
                                  ),
                                ),
 Divider(height: 0,color: Colors.grey,),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push( context, FadeRoute(page: ProcessingOrderList()));
                                  },
                                  child: Container(
                                      padding: EdgeInsets.only(top: 8, bottom: 8),
                                    child: ListTile(
                                      title: Container(
                                        
                                          child: Row(
                                        children: <Widget>[
                                         
                                          Container(
                                            

                                            margin: EdgeInsets.only(left: 8),
                                            child: Text(
                                              'Processing Order',
                                              style:
                                                  TextStyle(color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      )),
                                      trailing: Icon(Icons.chevron_right),
                                    ),
                                  ),
                                ),
             
                              Divider(height: 0,color: Colors.grey,),
                                GestureDetector(
                                  onTap: () {
                                  Navigator.push( context, FadeRoute(page: DeliveredOrderList()));
                                  },
                                  child: Container(
                                      padding: EdgeInsets.only(top: 8, bottom: 8),
                                    child: ListTile(
                                      title: Container(
                                        
                                          child: Row(
                                        children: <Widget>[
                                         
                                          Container(
                                            

                                            margin: EdgeInsets.only(left: 8),
                                            child: Text(
                                              'Delivered Order',
                                              style:
                                                  TextStyle(color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      )),
                                      trailing: Icon(Icons.chevron_right),
                                    ),
                                  ),
                                ),
                               
                      /////// for driver/////
                             


                              
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              ),
     

        
      ),
    );
  }

  
}