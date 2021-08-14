import 'dart:convert';
import 'package:Easy_shopping_admin/TimeConvert/TimeConvert.dart';
import 'package:Easy_shopping_admin/api/api.dart';
import 'package:Easy_shopping_admin/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {

ScrollController _controller = new ScrollController();
int _lastId;
bool _isLoadMore = false;
List loadList = [];
bool _isDelete = false;

List notific=[
{
"id": 1334,
"user_id": 88,
"userName": "bbh",
"url": "/pages/29",
"profilePic": "https://joincarevan.com//uploads/image_1606076644465.jpeg",
"notification_text": "Kollol Chakraborty is now following your page Bijoya's page",
"meta_text": null,
"seen": 0,
"created_at": "2020-11-24 16:29:01",
"updated_at": "2020-11-24 16:29:01"
},];

    @override
  void initState() {
    //     _controller.addListener(() {
    //   if (_controller.position.atEdge) {
    //     if (_controller.position.pixels == 0) {
    //        if (!mounted) return;   
    //       setState(() {
    //         print("top");
    //       });
    //     }
    //     // you are at top position

    //     else {
    //       print("bottom");
    //       loadMore(_lastId); //api will be call at the bottom at the list

    //     }
    //     // you are at bottom position
    //   }
    // });
  //  _showNotifications();
    super.initState();
  }

    Future<void> _showNotifications() async {
    var res = await CallApi().getData('/app/mobile/get/notificaiton');

    if (res.statusCode == 200) {
      var body = json.decode(res.body);
      print(body['notifications']);
       if (body['notifications'].length > 0) {
        _lastId = body['notifications'][body['notifications'].length - 1]['id'];
      }
     // store.dispatch(NotificationListAction(body['notifications']));
    }
    else if (res.statusCode == 401) {
      
      // Navigator.push( context, SlideLeftRoute(page: ErrorLogIn()));
    }
    else{

        Fluttertoast.showToast(
        msg: "Something went wrong!! Try again",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor:appColor.withOpacity(0.9),
        textColor: Colors.white,
        fontSize: 13.0);

    }
   // store.dispatch(NotificationLoading(false));
  }

  //   Future<void> loadMore(lastID) async {
  //   // feedList.clear();
  //   if (!mounted) return;   
  //   setState(() {
  //     _isLoadMore = true;
  //   });
  //   var res = await CallApi()
  //       .getData('/app/mobile/get/notificaiton?last_id=$lastID');

  //    var body = json.decode(res.body);

  //   if (res.statusCode == 200) {
  //     loadList = body['notifications'];
  //     if (loadList.length > 0) {
  //       _lastId = loadList[loadList.length - 1]['id'];
  //     }
  //     for (int i = 0; i < loadList.length; i++) {
  //       notific.add(loadList[i]);
  //     }
  //     // print(loadList);
  //     // print(store.state.feedState.length);
  //   }
  //   else if (res.statusCode == 401) {
      
  //     // Navigator.push( context, SlideLeftRoute(page: ErrorLogIn()));
  //   }
  //   else{

  //       Fluttertoast.showToast(
  //       msg: "Something went wrong!! Try again",
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.BOTTOM,
  //       backgroundColor:appColor.withOpacity(0.9),
  //       textColor: Colors.white,
  //       fontSize: 13.0);

  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     _isLoadMore = false;
  //   });
  // }

    Future<void> _pull() async {
   // _showNotifications();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
         backgroundColor: Colors.white,
        appBar: AppBar(
          titleSpacing: 0,
         backgroundColor: appColor,
         elevation: 1,
          title: Center(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
               
                children: <Widget>[
                  Text(
                    "Notifications",
                    style: TextStyle(
                      fontSize: 20,
                      color: white
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
                child: RefreshIndicator(
                  onRefresh: _pull,
                                child: Container(
            child: Column(
              children: [
                        SizedBox(height:5),
                
              // notific.length == 0?Container(): 
               Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){
                            //_markAll();
                          },
                                                  child: Container(
                            margin: EdgeInsets.only(right:10, top:2,bottom: 5),
                            padding: EdgeInsets.all(8),
                               decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all( color: appColor, width: 1)
              ),
                            alignment: Alignment.topRight,
                            child: Text(
                              "Mark all as read",
                              style: TextStyle(
                                fontSize: 14,
                                color: appColor,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                  ),
                  //       Container(
                  //         child: IconButton(
                  //           onPressed: () {},
                  //           icon: Icon(
                  //             Icons.search,
                  //             color: Colors.black,
                  //             size: 27,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  //////////////////
                  //  store.state.notificationLoading
                  //   ? 
                    // Expanded(
                    //     child: ListView.builder(
                    //      // physics: BouncingScrollPhysics(),
                    //       itemCount: 5,
                    //       itemBuilder: (BuildContext ctx, int index) {
                    //         return Container(
                             
                    //           child: Column(
                    //             children: <Widget>[
                                  
                    //               Container(
                    //                 padding: EdgeInsets.only(top: 5, bottom: 5),
                    //                 child: Row(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.spaceBetween,
                    //                   children: <Widget>[
                    //                     Container(
                    //                       margin: EdgeInsets.only(
                    //                           left: 10, right: 10, top: 0),
                    //                       // padding: EdgeInsets.only(right: 10),
                    //                       child: Row(
                    //                         mainAxisAlignment:
                    //                             MainAxisAlignment.start,
                    //                         children: <Widget>[
                    //                           Container(
                    //                             margin: EdgeInsets.only(right: 10),
                    //                             // //transform: Matrix4.translationValues(0.0, 0.0, 0.0),
                    //                             // padding: EdgeInsets.all(1.0),
                    //                             child: Shimmer.fromColors(
                    //                               baseColor: Colors.grey[200],
                    //                               highlightColor: Colors.grey[200],
                    //                               child: CircleAvatar(
                    //                                 radius: 20.0,
                    //                                 //backgroundColor: Colors.white,
                    //                               ),
                    //                             ),
                    //                             decoration: new BoxDecoration(
                    //                               shape: BoxShape.circle,
                    //                             ),
                    //                           ),
                    //                           Column(
                    //                             crossAxisAlignment:
                    //                                 CrossAxisAlignment.start,
                    //                             children: <Widget>[
                    //                               Container(
                    //                                 decoration: BoxDecoration(
                    //                                   borderRadius:
                    //                                       BorderRadius.circular(15),
                    //                                 ),
                    //                                 child: Shimmer.fromColors(
                    //                                   baseColor: Colors.grey[300],
                    //                                   highlightColor:
                    //                                       Colors.grey[200],
                    //                                   child: Container(
                    //                                     width: MediaQuery.of(context)
                    //                                             .size
                    //                                             .width-80,
                    //                                     height: 60,
                    //                                     child: Container(
                    //                                       decoration: BoxDecoration(
                    //                                         color: Colors.black,
                    //                                         borderRadius:
                    //                                             BorderRadius.circular(
                    //                                                 8),
                    //                                       ),
                    //                                     ),
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //   )
                    // : 
                    notific.length == 0
                        ? Expanded(
                            child: Container(
                              child:Stack(
                                alignment: Alignment.center,
                                children: [
                                   ListView(),
                                  Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                     //   color: Colors.white,
                                        transform:
                                            Matrix4.rotationZ(-0.2), // rotate -10 deg
                                      //  width: MediaQuery.of(context).size.width,
                                       // height: MediaQuery.of(context).size.height/5,
                                        child: Image.asset(
                                          'assets/notification.png',
                                          fit: BoxFit.contain,
                                          color: appColor,
                                         // colorBlendMode: BlendMode.lighten,
                                          height:MediaQuery.of(context).size.height/8
                                         // width: MediaQuery.of(context).size.width,
                                        ),
                                        // ),
                                      ),
                                      Container(
                                        child: Text(
                                          'No Notifications yet',
                                          style: TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        :Expanded(
                    child: Container(
                      child: ListView.builder(
                       // physics: BouncingScrollPhysics(),
                        controller: _controller,
                        itemCount: notific.length,
                        itemBuilder: (BuildContext context, int index) => Container(
                          padding: EdgeInsets.only(top: 0, bottom: 0),
                          child: Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: (){
                                 //_seen(index);
                                },
                                                              child: Container(
                                  color: notific[index]['seen']==1
                                      ? Colors.transparent
                                      : Color(0xFFDB1F25).withOpacity(0.1),
                                  padding: EdgeInsets.all(15),
                                  child: Row(
                                    children: <Widget>[
                                      Stack(
                                        children: <Widget>[      
                                          Container(

                                            decoration: BoxDecoration(
                                              border:Border.all(color:Colors.grey),
                                              shape:BoxShape.circle
                                            ),
                                      
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(100.0),
                                          child: 
                                         notific[index]['profilePic']==null? 
                                         Image.asset(
                                                                  'assets/images/logo.png',
                                                                   height: 48,
                                                                   width: 48,
                                                                  fit: BoxFit.contain,
                                                                )
                                                                :CachedNetworkImage(
                                            imageUrl: 
                                            notific[index]['profilePic']=="/Carevanfavicon.png"?
                                            CallApi().getUrl()+notific[index]['profilePic']:
                                            notific[index]['profilePic'],
                                            fit: BoxFit.cover,
                                            height: 48,
                                            width: 48,
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
                                          ),
                                        ),
                                      ),
                                          
                                        ],
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text.rich(
                                                TextSpan(
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: notific[index]['notification_text']==null?"":notific[index]['notification_text'],
                                                      style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    // can add more TextSpans here...
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 5),
                                                child: Text(
                                                 TimeAgo.timeAgoSinceDate(notific[index]['created_at']),
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 12),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _showOptionsModalBottomSheet(context,index);
                                        },
                                        child: Container(
                                            margin: EdgeInsets.only(left: 15, right: 0),
                                            child: Icon(Icons.more_horiz)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                               notific.length - 1 == index
                                          ? _isLoadMore
                                              ? Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  padding: EdgeInsets.all(20),
                                                  color: Colors.white,
                                                  child: Center(
                                                    child: SizedBox(
                                                      height: 32,
                                                      width: 32,
                                                      child:
                                                          CircularProgressIndicator(
                                                        backgroundColor: Colors
                                                            .grey
                                                            .withOpacity(0.3),
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Colors
                                                                    .grey[400]),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container()
                                          : Container()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
                ),
        ),
      );
  
        }
      //  );
  }
  // Future<void> _seen(index) async {
                                                                              
  //     var data = {
  //         'id':notific[index]['id']
  //     };

  //     print(data);

  //     var res =
  //         await CallApi().postData(data, '/app/mobile/post/specificNotifUpdateToSeen');
  //     var body = json.decode(res.body);
  //     print(body);
         
  //     if (res.statusCode == 200) {

  //       for(var d in notific){ 
  //        if(notific[index]['id']==d['id']){
  //             d['seen']=1;
  //        }
  //       }

  //       store.dispatch(NotificationListAction(notific));
       
  //     } else {
  //        _showMessage("Something went wrong", 1);
  //     }
  //   }
  
  // Future<void> _markAll() async {
                                                                              
  //     var data = {
      
  //     };

  //     print(data);

  //     var res =
  //         await CallApi().postData(data, '/app/mobile/post/allNotifUpdateToSeen');
  //     var body = json.decode(res.body);
  //     print(body);
         
  //     if (res.statusCode == 200) {

  //       for(var d in notific){
  //         d['seen']=1;
  //       }

  //       store.dispatch(NotificationListAction(notific));
       
  //     } else {
  //       _showMessage("Something went wrong", 1);
  //     }
  //   }

  _showMessage(msg, numb) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        //timeInSecForIos: 1,
        backgroundColor:
            numb == 1 ? Colors.red.withOpacity(0.9) : Colors.grey[600],
        textColor: Colors.white,
        fontSize: 13.0);
  }

  /////////////// notification options sheet ui start /////////////////
  _showOptionsModalBottomSheet(context,index ) {
    return showModalBottomSheet(
        elevation: 5,
        isScrollControlled: true,
        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            height: MediaQuery.of(context).size.height / 4,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      width: 65,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // border color
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                 
                 
                  GestureDetector(
                    onTap: (){
                       Navigator.pop(context);
                         // _showDeleteDialog(index);
                    },

                                      child: Container(
                      margin: EdgeInsets.only(right: 25, left: 25, top: 15),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: CircleAvatar(
                              radius: 23.0,
                              backgroundColor: Colors.grey[300],
                              child: Icon(
                                Icons.delete,
                                color: appColor,
                              ),
                            ),
                            decoration: new BoxDecoration(
                              color: Colors.grey[50], // border color
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            child: Text(
                             'Delete this notification',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
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
          );
        });
  }

  //   Future<Null> _showDeleteDialog(index) async {
  //   return showDialog<Null>(
  //       context: context,
  //       barrierDismissible: true,
  //       builder: (BuildContext context) {
  //         return StatefulBuilder(builder: (context, setState) {
  //           return AlertDialog(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.all(Radius.circular(10.0))),
  //             title: Container(
  //                 margin: EdgeInsets.only(top: 5),
  //                 child: Text(
  //                   _isDelete ? "Deleting..." : "Want to delete the post?",
  //                   textAlign: TextAlign.start,
  //                   style: TextStyle(
  //                       color: Colors.black87,
  //                       fontSize: 16,
  //                       fontFamily: 'Oswald',
  //                       fontWeight: FontWeight.w400),
  //                 )),
  //             content: _isDelete
  //                 ? Row(
  //                     mainAxisSize: MainAxisSize.min,
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: <Widget>[
  //                       Container(
  //                         margin: EdgeInsets.only(bottom: 20),
  //                         height: 28,
  //                         width: 28,
  //                         child: CircularProgressIndicator(
  //                           strokeWidth: 2,
  //                           backgroundColor: Colors.grey.withOpacity(0.3),
  //                           valueColor:
  //                               AlwaysStoppedAnimation<Color>(Colors.grey[400]),
  //                         ),
  //                       ),
  //                     ],
  //                   )
  //                 : Container(height: 0),
  //             actions: [
  //               _isDelete
  //                   ? Container(height: 0)
  //                   : Container(
  //                       margin: EdgeInsets.only(bottom: 20),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.end,
  //                         children: <Widget>[
  //                           Container(
  //                             child: GestureDetector(
  //                                                  onTap: () async{

  //                             var data = {
  //         'id':notific[index]['id']
  //     };

  //     print(data);
  //        if (!mounted) return;   
  //      setState(() {
  //           _isDelete = true;
  //         });


  //     var res =
  //         await CallApi().postData(data, '/app/mobile/post/deleteNotification');
  //     var body = json.decode(res.body);
  //     print(body);
         
  //     if (res.statusCode == 200) {


  //           notific.remove(notific[index]);

  //       store.dispatch(NotificationListAction(notific));
  //       Navigator.of(context).pop();
       
  //     } else {
  //        _showMessage("Something went wrong", 1);
  //     }

  //      setState(() {
  //           _isDelete = false;
  //         });
  //                   },
  //                               child: Text(
  //                                 "Delete",
  //                                 style: TextStyle(
  //                                   color: appColor,
  //                                   fontSize: 15,
  //                                   fontFamily: 'Oswald',
  //                                 ),
  //                                 textAlign: TextAlign.center,
  //                               ),
  //                             ),
  //                           ),
  //                           Container(
  //                             margin: EdgeInsets.only(left: 20, right: 10),
  //                             child: GestureDetector(
  //                               onTap: () {
  //                                 Navigator.of(context).pop();
  //                                 setState(() {
  //                                   _isDelete = false;
  //                                 });
  //                               },
  //                               child: Text(
  //                                 "Cancel",
  //                                 style: TextStyle(
  //                                     color: Colors.black54,
  //                                     fontSize: 15,
  //                                     fontFamily: 'Oswald',
  //                                     fontWeight: FontWeight.w500),
  //                                 textAlign: TextAlign.center,
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //             ],
  //           );
  //         });
  //       });
  // }
  /////////////// notification options sheet ui end /////////////////



