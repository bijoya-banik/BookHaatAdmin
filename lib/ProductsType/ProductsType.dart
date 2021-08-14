
import 'package:Easy_shopping_admin/AddProductForm/AddProduct.dart';
import 'package:Easy_shopping_admin/AllProducts/AllProducts.dart';
import 'package:Easy_shopping_admin/AvailableProducts/AvailableProducts.dart';
import 'package:Easy_shopping_admin/EmptyStockProduct/EmptyStockProduct.dart';
import 'package:Easy_shopping_admin/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_shopping_admin/OfferProducts/OfferProducts.dart';
import 'package:Easy_shopping_admin/main.dart';
import 'package:flutter/material.dart';

class ProductsType extends StatefulWidget {
  @override
  _ProductsTypeState createState() => _ProductsTypeState();
}

class _ProductsTypeState extends State<ProductsType> {

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
          backgroundColor: appColor,
          leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () { 
             Navigator.of(context).pop();
            //  Navigator.push(
            // context, new MaterialPageRoute(builder: (context) => HomePage()));
          },
        );
      },
  ),
          title: Text("Books",
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
            context, new MaterialPageRoute(builder: (context) => AllProducts()));
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
                                              'All Books',
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
                                    Navigator.push( context, FadeRoute(page: AvailableProducts()));
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
                                              'Available Books',
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
                                    Navigator.push( context, FadeRoute(page: EmptyStockProduct()));
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
                                              'Empty Stock',
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
                                    Navigator.push( context, FadeRoute(page: OfferProducts()));
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
                                              'Offer',
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
             
                             
                               
                     
                             


                              
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              ),
     
  floatingActionButton: FloatingActionButton(
          onPressed: () {
             Navigator.push( context, FadeRoute(page: AddProduct()));
          },
          backgroundColor: appColor,
          child: Icon(Icons.add, color: Colors.white),
        )
        
      ),
    );
  }

  
}