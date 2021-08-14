import 'dart:convert';
import 'package:Easy_shopping_admin/ErrorLogIn/ErrorLogIn.dart';
import 'package:Easy_shopping_admin/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_shopping_admin/ProductsCard/OfferProductsCard.dart';
import 'package:Easy_shopping_admin/ProductsCard/ProductsCard.dart';
import 'package:Easy_shopping_admin/api/api.dart';
import 'package:Easy_shopping_admin/main.dart';
import 'package:Easy_shopping_admin/redux/action.dart';
import 'package:Easy_shopping_admin/redux/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OfferProducts extends StatefulWidget {
  @override
  _OfferProductsState createState() => _OfferProductsState();
}

class _OfferProductsState extends State<OfferProducts> {
  var body, body1, body2;
  int catId = 0;
  bool _isLoading = true;
  bool isSearch = false;
  bool isFilter = false;
  TextEditingController searchController = new TextEditingController();
  String search = "";
  String result = '',
      maxPrice = "",
      minPrice = "",
      cat = "",
      catName = "",
   
      orderName = "",
      nameOrder = "",
      orderType = "",
      typeOrder = "";
  var catList, user;
  // List filterList=[
  //   {
  //     'image':"assets/images/products.png",
  //     "name":"rice",
  //     "price":500,
  //     "description":"good",
  //     'discount':10
  //   },
  //   {
  //     'image':"assets/images/products.png",
  //     "name":"rice",
  //     "price":500,
  //     "description":"good",
  //     'discount':10
  //   },
  //   {
  //     'image':"assets/images/products.png",
  //     "name":"rice",
  //     "price":500,
  //     "description":"good",
  //     'discount':10
  //   },
  //   {
  //     'image':"assets/images/products.png",
  //     "name":"rice",
  //     "price":500,
  //     "description":"good",
  //     'discount':10
  //   },
  //   {
  //     'image':"assets/images/products.png",
  //     "name":"rice",
  //     "price":500,
  //     "description":"good",
  //     'discount':10
  //   },
  //   {
  //     'image':"assets/images/products.png",
  //     "name":"rice",
  //     "price":500,
  //     "description":"good",
  //     'discount':10
  //   },
  //   {
  //     'image':"assets/images/products.png",
  //     "name":"rice",
  //     "price":500,
  //     "description":"good",
  //     'discount':10
  //   },
  //   {
  //     'image':"assets/images/products.png",
  //     "name":"rice",
  //     "price":500,
  //     "description":"good",
  //     'discount':10
  //   },
  //   {
  //     'image':"assets/images/products.png",
  //     "name":"rice",
  //     "price":500,
  //     "description":"good",
  //     'discount':10
  //   },
  // ];
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();

  @override
  void initState() {
    _showProducts();
  
    super.initState();
  }

    Future<void> _showProducts() async {
    var res = await CallApi().getData('/api/showOfferProduct');

    if (res.statusCode == 200) {
      var body = json.decode(res.body);

      print(body);

      store.dispatch(OfferProductListAction(body['Product']));
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
    store.dispatch(OfferProductLoadingAction(false));
  }

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

  // Future<void> getFilterData() async {
  //   var res = await CallApi().getData(
  //       '/app/showProduct?max=${maxController.text}&min=${minController.text}&cat=$cat&sub=$subCat&ordercoloum=$orderName&ordersort=$orderType&searchtext=$search');
  //   body = json.decode(res.body);

  //   print(body);

  //   if (res.statusCode == 200) {
  //     _getFilterlist();
  //   }

  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  // void _getFilterlist() {
  //   var newFilter = AllProductModel.fromJson(body);
  //   if (!mounted) return;
  //   setState(() {
  //     filterList = newFilter.product;
  //   });
  // }

  // Future<void> getCategory() async {
  //   var res = await CallApi().getData('/app/showCategory');
  //   body1 = json.decode(res.body);

  //   //print(body);

  //   if (res.statusCode == 200) {
  //     _getCategorylist();
  //   }

  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  // void _getCategorylist() {
  //   var newCat = CategoryModel.fromJson(body1);
  //   if (!mounted) return;
  //   setState(() {
  //     catList = newCat.status;
  //   });
  // }

  // Future<void> getSubcategory() async {
  //   var res = await CallApi().getData('/app/showSubCategory?cat=$catId');
  //   body2 = json.decode(res.body);

  //   //print(body1);

  //   if (res.statusCode == 200) {
  //     _getSubCategorylist();
  //   }

  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  // void _getSubCategorylist() {
  //   var newSub = SubCategoryModel.fromJson(body2);
  //   if (!mounted) return;
  //   setState(() {
  //     subCatList = newSub.status;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: StoreConnector<AppState, AppState>(
            ////// this is the connector which mainly changes state/ui
            converter: (store) => store.state,
            builder: (context, items) {
              return Scaffold(
        appBar: new AppBar(
          backgroundColor: appColor,
          titleSpacing: 0,
          title: isSearch == false
              ? Text("Offer Books")
              : Container(
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
                      suffixIcon: search != ""
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  searchController.text = "";
                                  search = "";
                                });
                              },
                              icon: Icon(Icons.arrow_forward),
                              color: Colors.grey,
                            )
                          : Icon(
                              Icons.cancel,
                              color: Colors.transparent,
                            ),
                    ),
                    onChanged: (val) {
                      setState(() {
                       
                        //filterList = null;
                        store.dispatch(ProductListAction([]));
                        search = val;
                            // getFilterData
                     
                      
                      });
                    },
                  ),
                ),
          // actions: <Widget>[
          //   Container(
          //     height: 45.0,
          //     padding: EdgeInsets.only(bottom: 5, right: 10, top: 5),
          //     child: GestureDetector(
          //       onTap: () {
          //         //_filterPage();
          //       },
          //       child: Container(
          //         padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
          //         decoration:
          //             BoxDecoration(borderRadius: BorderRadius.circular(6)),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: <Widget>[
          //             GestureDetector(
          //               onTap: () {
          //                 setState(() {
          //                   if (isSearch == false) {
          //                     isSearch = true;
          //                   } else {
          //                     isSearch = false;
          //                   }
          //                 });
          //               },
          //               child: Container(
          //                   margin: EdgeInsets.only(right: 10),
          //                   child: Icon(
          //                       isSearch == true ? Icons.close : Icons.search,
          //                       color: Colors.white)),
          //             ),
                   
          //           ],
          //         ),
          //       ),
          //     ),
          //   )
          // ],
        ),
        body: SafeArea(
          child: store.state.offerProductLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : store.state.offerProductList.length == 0
                ? RefreshIndicator(
                    onRefresh: _showProducts,
                                  child: SingleChildScrollView(
                                    physics: AlwaysScrollableScrollPhysics(),

                                                                      child: Center(
                      child: Container(
                        margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/2.5),
                      child: Text("No books found",
                      style: TextStyle(color:appColor, fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                    )),
                                  ),
                )
                : RefreshIndicator(
                    onRefresh: _showProducts,
                          child: Container(
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
                                margin: EdgeInsets.only(
                                    top: isFilter == false ? 0 : 60),
                                child: GridView.builder(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio:
                                                  (MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          3) /
                                                      (MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          4),
                                            ),
                                            itemBuilder:
                                                (BuildContext context, int index) =>
                                                    new Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: OfferProductsCard(
                                                  user, index),
                                            ),
                                            itemCount: store.state.offerProductList.length,
                                          )
                                     
                                 
                              ),
                           
                            ],
                          )),
                ),
                  )
        
      

                  
      );
            }
              )
    );
  }


}


