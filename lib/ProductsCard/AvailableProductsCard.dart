import 'dart:convert';

import 'package:Easy_shopping_admin/EditProductForm/EditProductForm.dart';
import 'package:Easy_shopping_admin/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_shopping_admin/ProductPage/AvailableProductDetails.dart';
import 'package:Easy_shopping_admin/ProductPage/EmptyStockProductDetails.dart';
import 'package:Easy_shopping_admin/ProductPage/ProductDetails.dart';
import 'package:Easy_shopping_admin/api/api.dart';
import 'package:Easy_shopping_admin/main.dart';
import 'package:Easy_shopping_admin/redux/action.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class AvailableProductsCard extends StatefulWidget {
  final user;
  final index;
  AvailableProductsCard(this.user, this.index);
  @override
  _AvailableProductsCardState createState() => _AvailableProductsCardState();
}

class _AvailableProductsCardState extends State<AvailableProductsCard> {
  double price = 0.0, discountPrice = 0.0, rating = 0.0;
  int userDiscount, productDiscount, totalDiscount;
  bool _isLoading = false;

    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //List categoryList = [];
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
    //Scaffold.of(context).showSnackBar(snackBar);
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
  @override
  void initState() {
    // setState(() {
    //   if (widget.user != null) {
    //     String userDisc = widget.user['discount'];
    //     double discUser = double.parse(userDisc);

    //     userDiscount = discUser.toInt();
    //     productDiscount = widget.filterList.discount;
    //   } else {
    //     double discUser = 0.0;

    //     userDiscount = discUser.toInt();
    //     productDiscount = widget.filterList.discount;
    //   }

    //   if (widget.filterList.average == null) {
    //     rating = 0.0;
    //   } else {
    //     String ratingProduct = widget.filterList.average.averageRating;
    //     rating = double.parse(ratingProduct);
    //   }

      // if (userDiscount > productDiscount) {
      //   setState(() {
      //     totalDiscount = userDiscount;
      //   });
      // } else {
      // setState(() {
      //   totalDiscount = productDiscount;
      // });
      // }

    //   String p = "${widget.filterList.price}";
    //   price = double.parse(p);
    //   double disc = totalDiscount / 100;
    //   double newDisc = price * disc;
    //   discountPrice = price - newDisc;
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              SlideLeftRoute(
                  page: AvailableProductDetails(widget.index)));
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 0, top: 5, left: 2.5, right: 2.5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                blurRadius: 1.0,
                color: Colors.black.withOpacity(.5),
              ),
            ],
          ),
          child: GridTile(
            child: Container(
              padding: EdgeInsets.only(bottom: 0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: <Widget>[

                          Positioned(
                            top:5,
                            right: 5,
                            child:  GestureDetector(
                                              onTap: () {
                                                _editDeleteBottomSheet(store.state.availableProductList[widget.index]);
                                              },
                                              child: Icon(Icons.more_vert))),
                        ////// <<<<< Pic start >>>>> //////
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            margin: EdgeInsets.only(top: 5),
                            child: 
                            store.state.availableProductList[widget.index]['productImage']==null ||
                            store.state.availableProductList[widget.index]['productImage']==""?
                            Image.asset(
                              'assets/images/logo.png',
                              height: 130,
                              width: 120,
                              fit: BoxFit.cover,
                            ):
                            CachedNetworkImage(
                                            imageUrl: CallApi().getUrl()+store.state.availableProductList[widget.index]['productImage'],
                                          
                                            fit: BoxFit.cover,
                                            height: 130,
                                            width: 120,
                                            placeholder: (context, url) => Center(
                                              child: SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child: Container(
                                                    padding: EdgeInsets.all(8),
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      backgroundColor:
                                                          Colors.grey.withOpacity(0.3),
                                                      valueColor:
                                                          AlwaysStoppedAnimation<Color>(
                                                              Colors.grey[400]),
                                                    ),
                                                  )),
                                            ),
                                            errorWidget: (context, url, error) =>
                                                Center(child: new Icon(Icons.error)),
                                          )
                          ),
                        ),
                        ////// <<<<< Pic end >>>>> //////

                        ////// <<<<< New tag start >>>>> //////
                     store.state.availableProductList[widget.index]['discount']==0 ||
                     store.state.availableProductList[widget.index]['discount']==null?
                     Container():
                        Container(
                          margin: EdgeInsets.only(top: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.all(5),
                                  color: productDiscount != 0
                                      ? appColor
                                      : Colors.transparent,
                                  child: Text(
                                    productDiscount != 0
                                        ? "${store.state.availableProductList[widget.index]['discount']}% "+"Off"
                                        : "",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  )),
                            ],
                          ),
                        )
                        ////// <<<<< New tag end >>>>> //////
                      ]),
                    )),
                  ),
                  Divider(
                    color: Colors.grey[300],
                  ),
                  
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ////// <<<<< Name start >>>>> //////
                        Expanded(
                          child: Container(
                          //  alignment: Alignment.center,
                            child: Text(store.state.availableProductList[widget.index]['productName']==null?"":
                            store.state.availableProductList[widget.index]['productName'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                        ////// <<<<< Name end >>>>> //////
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ////// <<<<< Price start >>>>> //////
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child: Container(
                                  //  alignment: Alignment.center,
                                    child: Text(
                                         store.state.availableProductList[widget.index]['discountPrice']==null?"0.00 Tk":
                                         "${store.state.availableProductList[widget.index]['discountPrice']} Tk",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: appColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                             store.state.availableProductList[widget.index]['discount']==0 ||
                             store.state.availableProductList[widget.index]['discount']==null
                                    ? Container()
                                    : Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: Text(
                                            "${store.state.availableProductList[widget.index]['price']} Tk",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ////// <<<<< Price end >>>>> //////
                  Container(
                    margin: EdgeInsets.only(top: 8, left: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ////// <<<<< Place start >>>>> //////
                        Expanded(
                          child: Container(
                            margin:
                                EdgeInsets.only(right: 8, top: 0, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                // Icon(
                                //   Icons.star,
                                //   size: 13,
                                //   color: Color(0xFFffa900),
                                // ),
                               
                              ],
                            ),
                          ),
                        ),
                        ////// <<<<< Place end >>>>> //////
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

    
  void _editDeleteBottomSheet(d) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: 
                Wrap(
                  children: <Widget>[
                    ListTile(
                        leading: new Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                        title: Row(
                          children: [
                            new Text('Edit',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: "Oswald")),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                                context, SlideLeftRoute(page: EditProductForm(d)));
                        }),
                   
                  
                    ListTile(
                        leading: new Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                        title: Row(
                          children: [
                            new Text('Remove',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.redAccent,
                                    fontFamily: "Oswald")),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          _showDeleteDialog(d);
                        }),
                  ],
                ));
          });
        });
  }

   Future<Null> _showDeleteDialog(d) async {
    return showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              title: Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    "Are you sure want to delete?",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontFamily: 'Oswald',
                        fontWeight: FontWeight.w400),
                  )),
              actions: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontFamily: 'Oswald',
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 10),
                        child: GestureDetector(
                          onTap: () async {
                            
                            _deleteProduct(d);
                            Navigator.of(context).pop();
                            _isLoading ? _showProcessingDialog() : null;
                          },
                          child: Text(
                            "Delete",
                            style: TextStyle(
                              color: appColor,
                              fontSize: 15,
                              fontFamily: 'Oswald',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          });
        });
  }

    Future<Null> _showProcessingDialog() async {
    return showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.grey[400]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 12),
                      child: Text(
                        "Processing...",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontFamily: 'Oswald',
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ));
          });
        });
  }

    void _deleteProduct(d) async {
  

    setState(() {
      _isLoading = true;
    });

    var data = {
      'id': d['id'],
      
    };

    print(data);

    var res = await CallApi().postData(data, '/api/deleteProduct');

    var body = json.decode(res.body);
    print(body);

    if (res.statusCode == 200) {
   
        store.state.availableProductList.remove(d);
      store.dispatch(AvailableProductListAction(store.state.availableProductList));


          if(store.state.productList.length>0){
           for (var data in store.state.productList) {
        if (data['id'] == d['id']) {
           store.state.productList.remove(data);
          break;
        }
      }

       store.dispatch(ProductListAction(store.state.productList));
      }

          if(store.state.offerProductList.length>0){
           for (var data in store.state.offerProductList) {
        if (data['id'] == d['id']) {
           store.state.offerProductList.remove(data);
          break;
        }
      }

       store.dispatch(OfferProductListAction(store.state.offerProductList));
      }
      store.state.totalProduct = store.state.totalProduct - 1;

      store.dispatch(TotalProduct(store.state.totalProduct));
      Navigator.of(context).pop();
    }  else {
      _showMsg("Something is wrong! Try Again");
    }

    setState(() {
      _isLoading = false;
    });
  }
}
