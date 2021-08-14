import 'dart:convert';
import 'dart:io';

import 'package:Easy_shopping_admin/AllProducts/AllProducts.dart';
import 'package:Easy_shopping_admin/KeyValueModel.dart';
import 'package:Easy_shopping_admin/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:Easy_shopping_admin/api/api.dart';
import 'package:Easy_shopping_admin/main.dart';
import 'package:Easy_shopping_admin/redux/action.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as Path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:http_parser/http_parser.dart';



class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController nameController = new TextEditingController();
 
 
  int imgPercent = 1;

  var dio = new Dio();
  var _cover="";
  bool _isImage = false;
  bool _isCancelImg = false;

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

  bool _isLoading = false;




  Future _pickImage() async {
    var images = await ImagePicker.pickImage(source: ImageSource.gallery);

   
   
    if(images!=null){
       setState(() {
      _isImage = true;
    });
       
      _uploadImage(images);
   
   }

  
  }

      _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    print(localStorage.getString('token'));
    return localStorage.getString('token');
  }

  _setHeaders() async => {
        "Authorization": 'Bearer ' + await _getToken(),
      };
  void _uploadImage(filePath) async {
     if (this.mounted){
    setState(() {
      _isImage = true;
    });
     }
    print("path");
    print(filePath.path);

    try {
      String fileName = Path.basename(filePath.path);
      print("File base name: $fileName");
      print("File path name: $filePath");
       String mimeType = mime(fileName);
  String mimee = mimeType.split('/')[0];
  String type = mimeType.split('/')[1];

      FormData formData = FormData.fromMap({
        "photo": await MultipartFile.fromFile(
          filePath.path, filename: fileName,
          contentType: MediaType(mimee,type)
         // contentType: MediaType('image')//MediaType('image','jpg') 
          ),
      });
      print("formData");
      print(formData);
      // print(mimee);
      // print(type);
      var response = await Dio() 
          .post(CallApi().getUrl()+'/api/uploadImage',
          //.post('https://app.joincarevan.com/app/mobile/status/upload/images',
              data: formData,
              options: Options(
                headers: await _setHeaders(),
              ), onSendProgress: (int sent, int total) {
        //imgPercent=0;
        setState(() {
          imgPercent = ((sent / total) * 100).toInt();

          print("percent");
          print(imgPercent);
        });
      });

      print(response);
      print(response.data['imageUrl']);
      
      if (_isCancelImg == true) {
       setState(() {
          _isCancelImg = false;
       });
      }

      setState(() {
             imgPercent = 100;
          _isImage = false;
          _cover = response.data['imageUrl'];
      });


        
    } catch (e) {
      // print("Exception Caught: $e");
    }
  }


  @override
  void initState() {
   
    super.initState();
  }


  File imageFile;
  String image;

  Container addProductCon(String label, String hint,
      TextEditingController control, TextInputType type) {
    return Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
        child: Column(
          children: <Widget>[
            Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 10, bottom: 8),
                child: Text(label,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: appColor, fontSize: 13))),
            Container(
                margin: EdgeInsets.only(left: 8, top: 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Colors.grey[100],
                    border: Border.all(width: 0.2, color: Colors.grey)),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                          maxHeight: 120.0,
                        ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: TextField(
                       //textInputAction: TextInputAction.newline,
                      cursorColor: Colors.grey,
                      controller: control,
                      keyboardType: type,
                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences,
                      // autofocus: true,
                      style: TextStyle(color: Colors.grey[600]),
                      decoration: InputDecoration(
                        hintText: hint,
                        // labelText: label,
                        // labelStyle: TextStyle(color: appColor),
                        contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 20.0, 15.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                )),
          ],
        ));
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text("Add Category"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Column(
            children: <Widget>[
                          _isImage
                  ? Container(
                      padding: const EdgeInsets.all(12.0),
                      margin: EdgeInsets.only(top: 20,),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: appColor, width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(imgPercent.toString() + "%"),
                      )):GestureDetector(
                        onTap: (){
                        _pickImage();
                        },
                                              child: Container(
                                    margin: EdgeInsets.only(left: 12),
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10, bottom: 20),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey),
                                          shape: BoxShape.rectangle),
                                      child: Container(
                                        child: 
                                        _cover==""?
                                        
                                        Image.asset(
                                          'assets/images/camera.jpg',
                                         
                                          height: MediaQuery.of(context).size.width/3,
                                          width: MediaQuery.of(context).size.width/2,
                                          fit: BoxFit.cover,
                                        ):
                                        Image.network(
                                         CallApi().getUrl()+ _cover,
                                         
                                          height: MediaQuery.of(context).size.width/3,
                                          width: MediaQuery.of(context).size.width/2,
                                          fit: BoxFit.cover,
                                        ), 
                                      ),
                                    ),
                                  ),
                      ),
               

              _isImage
                  ? RaisedButton.icon(
                      color: appColor,
                      onPressed: () {
                        cancelImg();
                      },
                      icon: new Icon(Icons.image, color: Colors.white),
                      label: new Text(
                        "Cancel Uploading",
                        style: TextStyle(color: Colors.white),
                      ))
                  :      GestureDetector(
                        onTap: (){
                        _pickImage();
                        },
                                      child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Upload photo",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: appColor,
                              ),
                            ),
                          ),
                  ),

              SizedBox(
                height: 5,
              ),
          

              SizedBox(height: 15),

              addProductCon(
                  " Category Name", "", nameController, TextInputType.text),

            
              GestureDetector(
                onTap: () {
                 
                  _isLoading ? null : _addCategory();
                },
                child: Container(
                  margin:
                      EdgeInsets.only(left: 25, right: 15, bottom: 20, top: 25),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: appColor.withOpacity(0.9),
                      border: Border.all(width: 0.2, color: Colors.grey)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.create_new_folder,
                        size: 20,
                        color: Colors.white,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(_isLoading ? "Creating..." : "Create",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17)))
                    ],
                  ),
                ),
              ),

              /////////////////   profile editing save end ///////////////
            ],
          ),
        ),
      ),
    );
  }

  void _addCategory() async {
    if (nameController.text.isEmpty) {
      return _showMsg("Category Name is empty");
    } else if (_cover=="") {
      return _showMsg("Upload category image");
    }

    setState(() {
      _isLoading = true;
    });
    

    var data = {
      'categoryName': nameController.text,
      'categoryImage': _cover,
      
    };

    print(data);

    var res = await CallApi().postData(data, '/api/addCategory');

    var body = json.decode(res.body);
    print(body);
// data: {categoryName: Shirts, categoryImage: /uploads/FtmMDTjuOWUg5zl2RQM21Bgb37bo9ZRMVAvArxvT.jpg, 
//  id: 6}
  
      if (res.statusCode == 200) {
        store.state.categoryList.add(
          {
            "id": body['data']['id'],
            "categoryName": body['data']['categoryName'],
            "categoryImage": body['data']['categoryImage'],
          }
        );

        store.dispatch(CategoryListAction(store.state.categoryList));

        store.state.totalCategory = store.state.totalCategory+1;

      store.dispatch(TotalCategory(store.state.totalCategory));
        Navigator.of(context).pop();
      } 
     else if (body['message'].contains("Duplicate entry")) {
         _showMsg("You have already created same category ");      
      } 
     
      else {
        _showMsg("Something is wrong! Try Again");      
    }

    setState(() {
      _isLoading = false;
    });
  }

  void cancelImg() async {
    print("object");

    setState(() {
      _isImage = false;
      _isCancelImg = true;
    });
  }


}
