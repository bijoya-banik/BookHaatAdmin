import 'dart:convert';
import 'package:Easy_shopping_admin/api/api.dart';
import 'package:Easy_shopping_admin/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class EmptyStockProductDetails extends StatefulWidget {
  final index;
  EmptyStockProductDetails(this.index);
  @override
  State<StatefulWidget> createState() {
    return EmptyStockProductDetailsState();
  }
}

class EmptyStockProductDetailsState extends State<EmptyStockProductDetails> {
  Animation<double> animation;
  AnimationController controller;


  List imgList = [];
  int _current = 0, active = 0;
  bool _isVideo = false;
  bool _isImage = true;
  bool _isShow = false;
  bool _changeDataNew = false;

  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  int count = 0;

  int c1 = 0, c2 = 0, idx = 0;
  int last = 1;
  int first = 1;

  Container saleStock(
    String title,
    String subtitle,
  ) {
    return Container(
      // height: 150,

      child: Card(
        elevation: 0,
        margin: EdgeInsets.only(left: 15, right: 15, top: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            //color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: Colors.grey[100],
            //    border: Border.all(width: 0.2, color: Colors.grey),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey[200],
            //     blurRadius: 17,
            //     //offset: Offset(0.0,3.0)
            //   ),
            // ],
          ),
          // height: 150,
          width: MediaQuery.of(context).size.width / 2 - 50,
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: appColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                    Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          subtitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black54, fontSize: 17),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
    Scaffold.of(context).showSnackBar(snackBar);
  }

 

  bool _isLoading = false;
  List vidList = [];
  double disc = 0.0;
  double disPrice = 0.0;
  double newPrice = 0.0;
  @override
  void initState() {
    //   bool _isVideo = false;
    // bool _isImage = false;
    // bool _isShow = false;
//List imgList = [];


    // disc = widget.data['discount'].toDouble();
    // disc = disc / 100;
    // print(disc);
    // disPrice = widget.data['price'].toDouble() * disc;
    // print(disPrice);
    // newPrice = widget.data['price']- disPrice;


// if(widget.data.photo!=null){

//   for (var d in widget.data.photo) {
//       imgList.add(url+d.link);
//       // print(url + d.link);
//     }

// }
      
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appColor,
        title: Center(
          child: Container(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Details",
                      style: TextStyle(fontSize: 20, color: Colors.white)),

                  //       _isVideo == true && _isImage == true && _isShow == false
                  // ? vidList.length==0?Container(): GestureDetector(
                  //     onTap: () {
                  //       setState(() {
                  //         _isShow = true;
                  //       });
                  //     },
                  //     child: Container(
                  //       child: Text(
                  //         "See Video",
                  //         style: TextStyle(color: Colors.white70, fontSize: 12),
                  //       ),
                  //     ),
                  //   )
                  // : Container(),
                ],
              ),
            ),
          ),
        ),

        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
               Navigator.of(context).pop();
              },
            );
          },
        ),

        // actions: <Widget>[
        //    Container(
        //             alignment: Alignment.topRight,
        //             child: PopupMenuButton<String>(
        //               onSelected: choiceAction,
        //               icon: Icon(
        //                 Icons.more_vert,
        //                 color: Colors.white,
        //               ),
        //               itemBuilder: (BuildContext context) {
        //                 return ChangeProductType.choices.map((String choice) {
        //                   return PopupMenuItem<String>(
        //                     value: choice,
        //                     child: Text(choice),
        //                   );
        //                 }).toList();
        //               },
        //             ),
        //           ),
        // ],
      ),
      body: SingleChildScrollView(
        //  physics: BouncingScrollPhysics(),
        child: Container(
          // height: MediaQuery.of(context).size.height,
          color: Colors.white,
          margin: EdgeInsets.only(bottom: 22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 300,
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          color: Colors.white,
                          border: Border.all(width: 0.2, color: Colors.grey)),
                      child: store.state.availableProductList[widget.index]['productImage']==null ||
                            store.state.availableProductList[widget.index]['productImage']==""?
                            Image.asset(
                        'assets/images/placeholder-image.png',
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ): CachedNetworkImage(
                                            imageUrl: CallApi().getUrl()+store.state.availableProductList[widget.index]['productImage'],
                                          
                                            fit: BoxFit.cover,
                                           height: 300,
                        width: MediaQuery.of(context).size.width,
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
                    )),

                  /////////////    product image start ////////////////
                  // Stack(
                  //   children: <Widget>[

                  // Container(
                  //     height: 300,
                  //     child: Container(
                  //       margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                  //       width: MediaQuery.of(context).size.width,
                  //       decoration: BoxDecoration(
                  //           borderRadius:
                  //               BorderRadius.all(Radius.circular(15.0)),
                  //           color: Colors.white,
                  //           border:
                  //               Border.all(width: 0.2, color: Colors.grey)),
                  //             child: Image.asset(
                  //    'assets/images/ecom.jpg',
                  //     height: 300,
                  //     width:  MediaQuery.of(context).size.width,
                  //     fit: BoxFit.cover,
                  //   ),

                  //     )),

                  //  imgList.length == 0?
                  //        Container(
                  //           height: 300,
                  //           child: Container(
                  //             margin: EdgeInsets.only(
                  //                 left: 20, right: 20, top: 10),
                  //             width: MediaQuery.of(context).size.width,
                  //             decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.all(
                  //                     Radius.circular(15.0)),
                  //                 color: Colors.white,
                  //                 border: Border.all(
                  //                     width: 0.2, color: Colors.grey)),
                  //             child: Image.asset(
                  //               'assets/images/placeholder-image.png',
                  //               //    height: 300,
                  //               //  width:  MediaQuery.of(context).size.width,
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ))
                  //            : Stack(
                  //       children: <Widget>[
                  //         Container(
                  //             //height: 300,
                  //             //   width:  MediaQuery.of(context).size.width,
                  //             child: Container(
                  //               margin: EdgeInsets.only(
                  //                   left: 20, right: 20, top: 10),
                  //               width:
                  //                   MediaQuery.of(context).size.width,
                  //               decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.all(
                  //                       Radius.circular(5.0)),
                  //                   color: Colors.white,
                  //                   border: Border.all(
                  //                       width: 0.2,
                  //                       color: Colors.grey)),
                  //               child: CarouselSlider(
                  //                 //aspectRatio: 2.0,
                  //                 //height: 400.0,
                  //                 viewportFraction: 1.0,
                  //                 initialPage: 0,
                  //                 enlargeCenterPage: false,
                  //                 autoPlay: false,
                  //                 reverse: false,
                  //                 enableInfiniteScroll: false,
                  //                 autoPlayInterval:
                  //                     Duration(seconds: 2),
                  //                 autoPlayAnimationDuration:
                  //                     Duration(milliseconds: 2000),
                  //                 pauseAutoPlayOnTouch:
                  //                     Duration(seconds: 10),
                  //                 scrollDirection: Axis.horizontal,
                  //                 onPageChanged: (index) {
                  //                   setState(() {
                  //                     _current = index;
                  //                   });
                  //                 },
                  //                 items: imgList.map((imgUrl) {
                  //                   return Builder(
                  //                     builder:
                  //                         (BuildContext context) {
                  //                       return Container(
                  //                         // width:
                  //                         //     MediaQuery.of(context)
                  //                         //         .size
                  //                         //         .width,
                  //                         // margin:
                  //                         //     EdgeInsets.symmetric(
                  //                         //         horizontal: 10.0),
                  //                         decoration: BoxDecoration(
                  //                           color: Colors.white,
                  //                         ),
                  //                         child: GestureDetector(
                  //                           child: Image.network(
                  //                             imgUrl,
                  //                             fit: BoxFit.cover,
                  //                             height: 300,
                  //                             width: MediaQuery.of(
                  //                                     context)
                  //                                 .size
                  //                                 .width,
                  //                           ),
                  //                         ),
                  //                       );
                  //                     },
                  //                   );
                  //                 }).toList(),
                  //               ),
                  //             )),
                  //         Container(
                  //           margin: EdgeInsets.all(20),
                  //           child: Row(
                  //             mainAxisAlignment:
                  //                 MainAxisAlignment.end,
                  //             children: <Widget>[
                  //               Container(
                  //                 padding: EdgeInsets.all(5),
                  //                 color: Colors.black,
                  //                 child: Text(
                  //                   "${_current + 1}/${imgList.length}",
                  //                   style: TextStyle(
                  //                       color: Colors.white),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 20, top: 30),
                        padding:  store.state.availableProductList[widget.index]['discount'] == 0
                            ? EdgeInsets.only(
                                left: 0, right: 0, top: 0, bottom: 0)
                            : EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                        color: appColor,
                        child: Text(
                           store.state.availableProductList[widget.index]['discount'] == 0
                              ? ""
                              : "${ store.state.availableProductList[widget.index]['discount']}% off",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )
                ],
              ),

              /////////////    product image end ////////////////

              //   ],
              // ),

             
              /////////////    product name start ////////////////
               store.state.availableProductList[widget.index]['productName'] == null
                  ? Container()
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                          top: 10, left: 20, right: 20, bottom: 3),
                      padding: EdgeInsets.only(
                          top: 10, left: 12, right: 10, bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
                          color: Colors.white,
                          border: Border.all(width: 0.2, color: Colors.grey)),
                      child: Container(
                        //  width: MediaQuery.of(context).size.width,
                        child: Text(
                         store.state.availableProductList[widget.index]['productName']==null?"":
                            store.state.availableProductList[widget.index]['productName'],
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),

              /////////////    product name end ////////////////

              /////////////    product price start ////////////////
             store.state.availableProductList[widget.index]['price']==null
                  ? Container()
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 5, bottom: 3),
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 0),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
                          color: Colors.white,
                          border: Border.all(width: 0.2, color: Colors.grey)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              color: Colors.white,
                              // border: Border.all(width: 1, color: appColor)
                            ),
                            padding: EdgeInsets.only(
                                top: 10, right: 10, bottom: 10),
                            child: Row(
                              children: <Widget>[
                                // Icon(
                                //   Icons.attach_money,
                                //   color: appColor,
                                //   size: 20,
                                // ),

                               store.state.availableProductList[widget.index]['discount'] == 0 || 
                               store.state.availableProductList[widget.index]['discount'] == null
                                    ? Text(
                                       store.state.availableProductList[widget.index]['price'].toString()+" Tk",
                                        style: TextStyle(
                                            color: appColor,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Row(
                                        children: <Widget>[
                                          Text(
                                             store.state.availableProductList[widget.index]['discountPrice'].toString()+" Tk",
                                            style: TextStyle(
                                                color: appColor,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                             store.state.availableProductList[widget.index]['price'].toString()+" Tk",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          )
                                        ],
                                      )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
              /////////////    product price end ////////////////
              /////////////    product color start ////////////////
            

              /////////////    product color end ////////////////


              /////////////    product size end ////////////////
              ///
              /////////////    product description start ////////////////
               store.state.availableProductList[widget.index]['description'] == null
                  ? Container()
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                          top: 5, left: 20, right: 20, bottom: 5),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
                          color: Colors.white,
                          border: Border.all(width: 0.2, color: Colors.grey)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                           Container(
                              margin: EdgeInsets.only(bottom:5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Text(
                                  "Category: ",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontSize: 14, color: appColor),
                                ),
                                Text(
                                  store.state.emptyStockProductList[widget.index]['category'] == null
                                      ? ""
                                      : store.state.emptyStockProductList[widget.index]['category']['categoryName'],
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                              ],
                          ),
                            ),
                          
                          Text(
                            store.state.availableProductList[widget.index]['description'] == null
                                ? ""
                                : store.state.availableProductList[widget.index]['description'],
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                    ),

              /////////////    product description end ////////////////

        
            ],
          ),
        ),
      ),
      
    );
  }

}
