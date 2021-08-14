import 'dart:convert';

import 'package:Easy_shopping_admin/ProductsCard/ProductsCard.dart';
import 'package:Easy_shopping_admin/ProductsCard/SearchProductCard.dart';
import 'package:Easy_shopping_admin/api/api.dart';
import 'package:Easy_shopping_admin/main.dart';
import 'package:Easy_shopping_admin/redux/action.dart';
import 'package:Easy_shopping_admin/redux/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchProduct extends StatefulWidget {
  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  TextEditingController searchController = new TextEditingController();
  bool _isLoading = false;
  var user;

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    if (userJson != null) {
      var users = json.decode(userJson);
      setState(() {
        user = users;
      });
    }
    print("user");
    print(user);
  }

  Future<void> getFilterData() async {
    setState(() {
      _isLoading = true;
     store.dispatch(SearchProductListAction([]));
    });
    var res =
        await CallApi().getData('/api/searchProduct/${searchController.text}');
    var body = json.decode(res.body);

    print(body);

    if (res.statusCode == 200) {
       store.dispatch(SearchProductListAction(body['Product']));
    }

    setState(() {
      _isLoading = false;
    });

   
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
          ////// this is the connector which mainly changes state/ui
          converter: (store) => store.state,
          builder: (context, items) {
            return Scaffold(
          appBar: AppBar(
              backgroundColor: appColor,
              title: Container(
                height: 50.0,
                margin: EdgeInsets.only(right: 0, left: 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: Colors.white),
                child: TextField(
                  cursorColor: grey,
                  controller: searchController,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: appColor,
                    ),
                    hintText: "Search",
                    hintStyle: TextStyle(color: grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 5.0, top: 15.0),
                    // suffixIcon: search != ""
                    //     ? IconButton(
                    //         onPressed: () {
                    //           setState(() {
                    //             searchController.text = "";
                    //             search = "";
                    //           });
                    //         },
                    //         icon: Icon(Icons.arrow_forward),
                    //         color: Colors.grey,
                    //       )
                    //     : Icon(
                    //         Icons.cancel,
                    //         color: Colors.transparent,
                    //       ),
                  ),
                  onChanged: (val) {
                    if (val != "") {
                      getFilterData();
                    }

                    //filterList = null;
                    // store.dispatch(ProductListAction([]));
                    // search = val;
                    //   getFilterData();
                  },
                ),
              )),
          body: SafeArea(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : store.state.searchProductList.length == 0
                    ? SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Center(
                            child: Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 2.5),
                          child: Text(
                            "No books found",
                            style: TextStyle(
                                color: appColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                        )),
                      )
                    : Container(
                        margin: EdgeInsets.only(
                          left: 0,
                          right: 0,
                        ),
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.only(left: 5, right: 5, top: 4, bottom: 5),
                        child: Stack(
                          children: <Widget>[
                            Container(
                                child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio:
                                    (MediaQuery.of(context).size.width / 3) /
                                        (MediaQuery.of(context).size.height / 4),
                              ),
                              itemBuilder: (BuildContext context, int index) =>
                                  new Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SearchProductsCard(user, index),
                              ),
                              itemCount: store.state.searchProductList.length,
                            )),
                          ],
                        )),
          )
    );
          }
          );
  }
}
