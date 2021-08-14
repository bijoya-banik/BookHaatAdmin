import 'package:Easy_shopping_admin/HomePage/HomePage.dart';
import 'package:Easy_shopping_admin/Login/Login.dart';
import 'package:Easy_shopping_admin/redux/reducer.dart';
import 'package:Easy_shopping_admin/redux/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}
final store = Store<AppState>(
  reducer,
  initialState: AppState(
  totalProduct: 0,
  totalCategory: 0,
  totalOrder: 0,

  categoryList: [],
  categoryLoading: true,

  productList: [],
  productLoading: true,

  availableProductList: [],
  availableProductLoading: true,

  emptyStockProductList: [],
  emptyStockProductLoading: true,

  offerProductList: [],
  offerProductLoading: true,

  searchProductList: [],

  orderList: [],
  orderLoading: true,

  pendingOrderList: [],
  pendingOrderLoading: true,

  deliveredOrderList: [],
  deliveredOrderLoading: true,

  processingOrderList: [],
  processingOrderLoading: true,

  userList: [],
  userLoading: true,

  pdfBookList: [],
  pdfBookLoading: true,

  feedbackList: [],
  feedbackLoading: true
  
  )
);

int index = 0;
Color appColor = Color(0XFF008196);//Color(0xFF0B6623);
Color black = Colors.black;
Color white = Colors.white;
Color grey = Colors.grey;
int bottomNavIndex=0;
var visit="";
var visitaddress="";

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 
bool _isLoggedIn = false;

   @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();

     
  }
    void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');

    if (token != null) {
      setState(() {
        _isLoggedIn = true;
      });
    }

    print(token);
    print(_isLoggedIn);
    }
  
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,                                      
      child: StoreConnector<AppState, AppState>(
          ////// this is the connector which mainly changes state/ui
          converter: (store) => store.state,
          builder: (context, items) {
            return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
        
          primarySwatch: Colors.green,
         
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: _isLoggedIn ? HomePage() : Login(),
      );
          }
      )
    );
  }
}