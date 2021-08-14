import 'dart:convert';
import 'package:Easy_shopping_admin/ChangeStatus/ChangeStatus.dart';
import 'package:Easy_shopping_admin/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_shopping_admin/OrderItem/OrderItem.dart';
import 'package:Easy_shopping_admin/api/api.dart';
import 'package:Easy_shopping_admin/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatefulWidget {
  var data;
  OrderDetails(this.data);
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var body;
  var taxStatus;
  var taxAmount;
  bool _isLoading = false;
  double taxFinal = 0.0;
  @override
  void initState() {
    //  print(widget.data.status);
  //  _showTax();
    super.initState();
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: new AppBar(
      //   backgroundColor: appColor,
      //   title: const Text('Order Details'),
      // ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              iconTheme: IconThemeData(color: Colors.white),
              automaticallyImplyLeading: false,
              // leading:
              backgroundColor: appColor,
              expandedHeight: 180.0,
              //floating: false,
              pinned: true,

              title: Container(
                //color: Colors.red,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 0, bottom: 8, top: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white.withOpacity(0.2),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.arrow_back),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Order Details",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "DINPro",
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
              ),

              // actions: <Widget>[
              //   Row(
              //     children: <Widget>[
              //       IconButton(
              //         icon: Icon(Icons.edit),
              //         onPressed: () {

              //             Navigator.push(context, SlideLeftRoute(page: EditOrder(widget.data)));
              //         },
              //       ),
              //       IconButton(
              //         icon: Icon(Icons.delete),
              //         onPressed: () {
              //           _deleteOrder();
              //         },
              //       )
              //     ],
              //   )
              // ],

              flexibleSpace: new FlexibleSpaceBar(

                  ////////////////////Collapsed Bar/////////////////
                  background: Container(
                child: Container(
                  //constraints: new BoxConstraints.expand(height: 256.0, ),
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: new AssetImage('assets/images/ecom.jpg'),
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.darken),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )

                  ////////////////////Collapsed Bar  End/////////////////

                  ),
            ),
            // ShopPageTopBar(widget.shop)
          ];
        },
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            // width: MediaQuery.of(context).size.width,
            //color: Colors.red,
            child: Column(
              children: <Widget>[
                ////////// Order /////////
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.fromLTRB(15, 15, 15, 2),
                  padding: EdgeInsets.fromLTRB(15, 18, 15, 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        blurRadius: 17,
                        //offset: Offset(0.0,3.0)
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Order# ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: appColor,
                            fontFamily: "DINPro",
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                      ),

                      Divider(
                        color: Colors.grey[600],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      //////// Order Number/////////

                      Row(
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Order Number: ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "DINPro",
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Container(
                            child: Text(
                              widget.data['id'] == null
                                  ? "---"
                                  : widget.data['id'].toString(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: appColor,
                                  fontFamily: "DINPro",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      //////// Order Number end /////////

                      SizedBox(
                        height: 7,
                      ),
                      //////// Order Status/////////

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Order Status: ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "DINPro",
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              //color: Colors.red,
                              //   height: 100,
                              //width: MediaQuery.of(context).size.width/2+100,
                              child: Text(
                                widget.data['status'] == null
                                    ? "---"
                                    : widget.data['status'].toString(),
                                textAlign: TextAlign.left,
                                // maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color:
                                        Color(0xFF343434), //Color(0xFFffa900),
                                    fontFamily: "DINPro",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //////// Order Status end /////////
                      SizedBox(
                        height: 7,
                      ),
                      /////  Order Date ///

                      Row(
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Order Date: ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "DINPro",
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Container(
                            child: Text(
                              widget.data['created_at'] == null
                                  ? "---"
                                  : DateFormat.yMMMd().add_jm().format(DateTime.parse(widget.data['created_at']).add(new Duration(hours: 6))).toString(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: "DINPro",
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),

                     
                      SizedBox(
                        height: 7,
                      ),

                      buyerInfo(
                          "CustomerId: ",
                          widget.data['user'] == null
                              ? ""
                              : ' ${widget.data['user']['id']}'),
                      SizedBox(
                        height: 7,
                      ),

                      Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      //  color: Colors.red,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                child: Text(
                                                  "Buyer Name: ",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: "DINPro",
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                    child: RichText(
                                                  text: TextSpan(
                                                    //  text: 'Hello ',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontFamily: "DINPro",
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: widget.data
                                                                      ['user']['firstName'] ==
                                                                  null
                                                              ? ""
                                                              : '${widget.data['user']['firstName']}'),
                                                      TextSpan(
                                                        text: widget.data
                                                                   ['user'] ['lastName'] ==
                                                                null
                                                            ? ""
                                                            : ' ${widget.data['user']['lastName']}',
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                              ),
                                            ],
                                          ),


                                        ],
                                      ),
                                    ),
                                 
                                  ],
                                ),
                    ],
                  ),
                ),

                ////////// Order end/////////

                // ///buyer //
                // Column(
                //   children: <Widget>[
                //     Container(
                //       width: MediaQuery.of(context).size.width,
                //       margin: EdgeInsets.fromLTRB(15, 10, 15, 7),
                //       padding: EdgeInsets.fromLTRB(15, 15, 18, 20),
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(8),
                //         boxShadow: [
                //           BoxShadow(
                //             color: Colors.grey[300],
                //             blurRadius: 17,
                //             //offset: Offset(0.0,3.0)
                //           )
                //         ],
                //       ),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: <Widget>[
                //           Text(
                //             "Buyer# ",
                //             textAlign: TextAlign.left,
                //             style: TextStyle(
                //                 color: appColor,
                //                 fontFamily: "DINPro",
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.normal),
                //           ),
                //           Divider(
                //             color: Colors.grey[600],
                //           ),
                //           SizedBox(
                //             height: 5,
                //           ),
                          

                //           ///////////cc
                       
                //         ],
                //       ),
                //     ),
                //   ],
                // ),

                ////////// Amount Details /////////
                Container(
                  margin:
                      EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 5),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        blurRadius: 17,
                        //offset: Offset(0.0,3.0)
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ////// Fee start///////

                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Amount Details# ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: appColor,
                                  fontFamily: "DINPro",
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal),
                            ),
                            Divider(
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            widget.data['subTotal'] == null &&
                                    widget.data['shippingPrice'] == null &&
                                    widget.data['grandTotal'] == null
                                ? Center(
                                    child: Text(
                                    "Amount Information is not available",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: "DINPro",
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  ))
                                : Column(
                                    children: <Widget>[
                                      /////Subtotal////////
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        // width:
                                        //     MediaQuery.of(context).size.width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                "Payment Type",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "DINPro",
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                            Container(
                                              //color: Colors.red,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              alignment: Alignment.centerRight,
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: Text(
                                                widget.data['paymentType'] == null
                                                    ? "---"
                                                    : '${widget.data['paymentType']}',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    color: appColor,
                                                    fontFamily: "DINPro",
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        // width:
                                        //     MediaQuery.of(context).size.width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                "Subtotal",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "DINPro",
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                            Container(
                                              //color: Colors.red,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              alignment: Alignment.centerRight,
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: Text(
                                                widget.data['subTotal'] == null
                                                    ? " 0.00 Tk"
                                                    : '${widget.data['subTotal']} Tk',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "DINPro",
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      //////Subtotal end//////
                                      /////Subtotal////////
                                     
                                      
                                      /////Delivery fee////////
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        // width:
                                        //     MediaQuery.of(context).size.width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                "Shipping Cost",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "DINPro",
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                            Container(
                                              //color: Colors.red,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              alignment: Alignment.centerRight,
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: Text(
                                                widget.data['shippingPrice'] ==
                                                        null
                                                    ? "0.00 Tk"
                                                    : '${widget.data['shippingPrice']} Tk',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "DINPro",
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        height: 0.5,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.grey,
                                      ),

                                      //////// total start///////

                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                "Total",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "DINPro",
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              //color: Colors.red,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              alignment: Alignment.centerRight,
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: Text(
                                                widget.data['grandTotal'] == null
                                                    ? "0.00 Tk"
                                                    : '${widget.data['grandTotal']} Tk',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "DINPro",
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ], 
                                        ),
                                      ),

                                      //////Subtotal end//////
                                      //////Delivery fee end//////
                                    ],
                                  ),
                          ],
                        ),
                      ),

                      //     //////// total end///////
                    ],
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 60),
                  padding: EdgeInsets.fromLTRB(15, 18, 15, 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        blurRadius: 17,
                        //offset: Offset(0.0,3.0)
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //////// Title start///////

                      Text(
                        "Items# ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: appColor,
                            fontFamily: "DINPro",
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                      ),

                      Divider(
                        color: Colors.grey[600],
                      ),
                      SizedBox(
                        height: 5,
                      ),

                      ////// Items start///////
                      widget.data['order_detail'].length == 0
                          ? Center(
                              child: Text(
                              "No Item is Available",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: "DINPro",
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ))
                          : Container(
                              margin: EdgeInsets.only(bottom: 10),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: //<Widget>[
                                    _showItems(),
                                //  OrderItem(),
                                //  OrderItem(),
                                //  OrderItem(),
                                // ],
                                // children: _showItems(),
                              ),
                            ),

                      ////// Items end///////

                      //////// Title end///////
                    ],
                  ),
                ),

                //////// Item Details end/////////
              ],
            ),
          ),
        ),
      ),
     floatingActionButton: widget.data['status']=="Delivered"?
     Container():FloatingActionButton(
          onPressed: () {
            Navigator.push(context, SlideLeftRoute(page: ChangeStatus(widget.data['status'], widget.data['id'])));
          },
          backgroundColor: appColor,
          child: Icon(Icons.edit, color: Colors.white),
        ),
    );
  }

  List<Widget> _showItems() {
    List<Widget> list = [];
    int i = 0;
    int len = widget.data['order_detail'].length;
    for (var d in widget.data['order_detail']) {
      i++;
     // print(d['product']['productImage']);
      list.add(OrderItem(d,));
    }

    return list;
  }

  Row buyerInfo(String label, String details) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(
            label,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black,
                fontFamily: "DINPro",
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
        ),
        Expanded(
          child: Container(
            child: Text(
              details,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black54,
                  fontFamily: "DINPro",
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ],
    );
  }



}
