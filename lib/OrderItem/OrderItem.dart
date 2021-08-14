

import 'package:Easy_shopping_admin/api/api.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatefulWidget {
  final data;
  // final index;
  // final length;
  OrderItem(this.data);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
 // bool _isLoading = true;
  var itemReview;

  @override
  void initState() {
  // print(widget.data['product']['productImage']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.data['product']==null?
    Container(
      child: Row(
        children: [
           Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(right: 10.0, left: 10),
                          child: ClipOval(
                              child: 
                                  Image.asset(
                                     "assets/images/logo.png",
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                    )
                          )
                        ),
                            Container(
                                margin: EdgeInsets.only(right: 10.0, left: 10),
                              child: Text(
                                    "Item is not available",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: "DINPro",
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  ),
                            ),
        ],
      )):
    Container(
      decoration: BoxDecoration(
        //color: Colors.red,
        borderRadius: BorderRadius.circular(15),
        // boxShadow:[
        //    BoxShadow(color:Colors.grey[300],
        //    blurRadius: 6,
        //     //offset: Offset(0.0,3.0)
        //     )

        //  ],
      ),
      // margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.only(
        left: 5,
        top: 6,
      ),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      //color: Colors.blue,
      child: Column(
        children: <Widget>[
          Container(
            //color: Colors.red,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[


                 Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(right: 10.0, left: 10),
                          child: ClipOval(
                              child: //widget.data['product']['productImage']==null?
                                   Image.network(
                                      CallApi().getUrl()+widget.data['product']['productImage'],
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                    )
                                  // :
                                  // Image.asset(
                                  //    "assets/images/logo.png",
                                  //     height: 50,
                                  //     width: 50,
                                  //     fit: BoxFit.cover,
                                  //   )
                          )
                        ),
                Expanded(
                  child: Container(
                    // color: Colors.red,
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        widget.data['product']==null?Container(): Container(
                          child: Text(
                           widget.data['product']['productName']==null?"":
                           widget.data['product']['productName'],
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                color: Colors.black87,
                                fontFamily: "DINPro",
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                         Container(
                            margin: EdgeInsets.only(top: 4),
                            child: Text(
                              widget.data['quantity']==null?"":
                              'Quantity: ${widget.data['quantity']}x',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: "DINPro",
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal))),
                       
                      ],
                    ),
                  ),
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: <Widget>[
                //     Container(
                //       margin: EdgeInsets.only(left: 10, right: 10),
                //       child: Text(
                //         widget.data['product']['discount'] == 0
                //             ? '${widget.data['product']['price']} Tk'
                //             : '${widget.data['product']['discountPrice']} Tk',
                //         textDirection: TextDirection.ltr,
                //         style: TextStyle(
                //           color: appColor,
                //           fontSize: 16.0,
                //           decoration: TextDecoration.none,
                //           fontFamily: 'MyriadPro',
                //           fontWeight: FontWeight.w500,
                //         ),
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 60,top: 10),
            child: Divider(
              color: Colors.grey[350],
            ),
          )
        ],
      ),
    );
  }
  
}
