import 'dart:convert';


import 'dart:io';

import 'package:BhansaGharChef/models/foodModel.dart';
import 'package:BhansaGharChef/services/foodservice.dart';
import 'package:BhansaGharChef/widgets/forminput.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddFood extends StatefulWidget {
  
  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  String _imagePath;
  File _image;
 // Future getImage() async {
     
     
     /*final picker = ImagePicker(); 

    var _pickedFile = await picker.getImage(
    source: ImageSource.gallery,
    imageQuality: 50, // <- Reduce Image quality
    maxHeight: 500,  // <- reduce the image size
    maxWidth: 500);
    */
  // _image = _pickedFile;
Future getImage() async {
File _image = File(await  ImagePicker().getImage(
      source: ImageSource.gallery, imageQuality: 50
  ).then((pickedFile) => pickedFile.path));

   _upload(_image);
   setState(() {
    _image = _image;

  });

}

void _upload(File file) async {
   String fileName = file.path.split('/').last;

   var headers = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'authorization': 'Bearer $token',
      };

   FormData data = FormData.fromMap({
      "Photo": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
      "name": "Momo",
      "price":20,
      "description":"aksjfaigfifbe",
      "preparation time":30,
      "category":"veg",
      "type":"lunch",
   });
  
  Dio dio = new Dio();
     String baseUrl = "https://bhansagharapi.herokuapp.com";
      String endPoint = "/api/v1/foods";
    String url = baseUrl + endPoint;

    final response = await dio.post(url,
          data: DataCell, options: Options(method: "POST", headers: headers));
          
  //dio.options.contentType= Headers.formUrlEncodedContentType;
 /* dio.post(url, 
  options: Options(
              headers: {HttpHeaders.contentTypeHeader: 'application/json', 
                        HttpHeaders.authorizationHeader:'Bearer $token',}),
  data: data)
  .then((response) => print(response))
  .catchError((error) => print(error)); */
}

 
  _imgFromCamera() async {
  File image = File(await ImagePicker().getImage(
    source: ImageSource.camera, imageQuality: 50
  ).then((pickedFile) => pickedFile.path)) ;

  setState(() {
    _image = image;
  });
}

_imgFromGallery() async {
  File image = File(await  ImagePicker().getImage(
      source: ImageSource.gallery, imageQuality: 50
  ).then((pickedFile) => pickedFile.path));

  setState(() {
    _image = image;
  });


} 

void _showPicker(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () {
                      getImage();
                     //_imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    getImage();
                    //_imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
}



  FoodModel foodModel;
  String token;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController name= TextEditingController(),
      
      description = TextEditingController(),
      time = TextEditingController(),
      price = TextEditingController(),
      category = TextEditingController(),
      type = TextEditingController();
  

    getTokenValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  var tokenValue = prefs.getString("token");
  print('add food token$tokenValue');
  return tokenValue;
}


@override
  void initState() {
     
    // TODO: implement initState
    super.initState();
   
    
  }
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    bool brkval = false;
    bool lunchval = false;
    bool dinval = false;

    bool vegval = false;
    bool nonvegval = false;

    Widget checkbox(String title, bool boolValue) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Row(
          children: <Widget>[
            Checkbox(
              value: boolValue,
              onChanged: (bool value) {
                setState(() {
                  boolValue = value;
                });
              },
            ),
            Text(
              title,
              style: TextStyle(color: Colors.yellow[700],fontWeight: FontWeight.bold),
            ),
          ],
        );
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Add Menu',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white),
      body: Column(children: <Widget>[
        Container(
          padding:
              EdgeInsets.only(top: 1.0, left: 5.0, right: 5.0, bottom: 5.0),
          width: deviceSize.width,
          height: 150.0,
          //   color: Colors.red,
          child: Row(
            children: <Widget>[
              Container(
                width: deviceSize.width / 2,
                margin: EdgeInsets.only(right: 5.0),
                //    color: Colors.cyan,
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      FormInputs(
                        input: 'Name',
                        inputType: TextInputType.text,
                        controller: name,
                      ),
                      FormInputs(
                        input: 'Price',
                        inputType: TextInputType.number,
                        controller: price,
                      ),
                      FormInputs(
                        input: 'Preparation Time',
                        inputType: TextInputType.text,
                        controller: time,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:10.0),
                width: 165.0,
                height:200,
                //   color: Colors.yellowAccent,
                child: GestureDetector(
            onTap: () {
              _showPicker(context);
             //_choose();

            },
            child: CircleAvatar(
              
              radius: 55,
              backgroundColor: Color(0xffFDCF09),
              child: _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        _image,
                        width: 140,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50)),
                      width: 140,
                      height: 200,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
            ),
                
                
                /* Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      width: 140.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(3, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: _image != null ?
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),),
                      
                      child: Image.file(
                        _image,
                        width: 140,
                        height: 100,
                        fit: BoxFit.fitHeight,
                      )  ,
                    )
                      :Center(
                          child: Text(
                        'Add a photo',
                        style: TextStyle(color: Colors.grey),
                      )),
                    ),
                    Positioned(
                        top: 120.0,
                        left: 130.0,
                        child: InkWell(
                          onTap: () {
                             _showPicker(context);
                          },
                          child: Container(
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.amber,
                            ),
                          ),
                        ))
                  ],
                ), */
              )
              )
            ],
          ),

          /* */
        ),
        Container(
          margin: EdgeInsets.all(5.0),
          padding: EdgeInsets.all(10.0),
          //     color: Colors.pink[100],
          height: 85.0,
          width: deviceSize.width,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Type',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Row(
                  children: <Widget>[
                    checkbox('BreakFast', brkval),
                    checkbox('Lunch', lunchval),
                    checkbox('Dinner', dinval)
                  ],
                )
              ]),
        ),
        Container(
          margin: EdgeInsets.all(5.0),
          padding: EdgeInsets.only(top: 10.0, left: 10, right: 10),
          //  color: Colors.pink[100],
          height: 85.0,
          width: deviceSize.width,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Category',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Row(
                  children: <Widget>[
                    checkbox('Non Veg', nonvegval),
                    checkbox('Veg', vegval),
                  ],
                )
              ]),
        ),
        Container(
          margin: EdgeInsets.only(left: 5),
          padding: EdgeInsets.all(10),
          // color: Colors.amber,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Details',style: TextStyle(color: Colors.grey[600])),
              Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.only(left:5,right:5),
                height: 90,
                width: deviceSize.width,
                // color: Colors.amber,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: new Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                child: TextField(
                  controller: description,
                  decoration: InputDecoration(border: InputBorder.none),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  style: TextStyle(fontSize: 14.0, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin: EdgeInsets.only(right: 5.0, bottom: 5.0),
            padding: EdgeInsets.only(right: 5, bottom: 5.0),
            height: 30,
            //   color: Colors.amber,
            child: FlatButton.icon(
              onPressed:(){
                _upload(_image);
              } ,
             /*   onPressed: () async {
                  String fileName = _image.path.split('/').last;
                   Map<String, dynamic> formData = {
              "photo": await MultipartFile.fromFile(_image.path,filename: fileName),
              "name":name.text,
              "description":description.text,
              "time":time.text,
              "price":price.text,
              "category":category.text,
              "type":type.text
            };
                  if(_formkey.currentState.validate()){
                  //   foodModel = FoodModel(
                  //      name: name.text,
                  // description: description.text,
                  // time: time.text,
                  // price: price.text,
                  // category: category.text,
                  // type: type.text,
                  // photo: _image.path,
                  //   );
                    token = await getTokenValuesSF();
                     FoodService().postAddFood(formData,token).then((value) {
                  if (value.statusCode == 200) {
                    Navigator.pop(context);
                  } else if (value.statusCode == 400) {
                    print("eereafsdfasdfadsf");
                    print(value.data['error']);
                  }
                });
              } else {
                print("not validated");
              }
                  
                },
                */
                icon: Icon(Icons.add,color: Colors.yellow[700],),
                label: Text('Add item',style: TextStyle(color:Colors.yellow[700]),),
                
                ),
          ),
        ),
      ]),
    );
  }
}
