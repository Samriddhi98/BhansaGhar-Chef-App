import 'dart:io';

import 'package:BhansaGharChef/models/foodModel.dart';
import 'package:BhansaGharChef/services/foodservice.dart';
import 'package:BhansaGharChef/widgets/forminput.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

//category class
class MyCategory {
  String title;
  bool value;
  MyCategory(this.title, this.value);
  //@override
  // String toString() {
  //   return 'MyClass{title: $title, value: $value}';
  // }
}

//type class
class MyType {
  String title;
  bool value;
  MyType(this.title, this.value);
  //@override
  // String toString() {
  //   return 'MyClass{title: $title, value: $value}';
  // }
}

MyCategory selectedcategory;
List<MyType> selectedtype = [];

class AddFood extends StatefulWidget {
  final String navigation;
  final FoodModel foodData;
  final String foodID;

  const AddFood({Key key, this.navigation, this.foodData, this.foodID})
      : super(key: key);
  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  bool brkval = false;
  bool lunchval = false;
  bool dinval = false;
  bool vegval = false;
  bool nonvegval = false;

  TextEditingController name;
  TextEditingController price;
  TextEditingController time;
  TextEditingController description;
  String oldName;
  int oldPrice;
  int oldTime;
  String oldDesc;
  String oldcategory;
  List<String> oldtype;
  File oldPhoto;

  File _image;

  Future getImage() async {
    File img = File(await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50)
        .then((pickedFile) => pickedFile.path));

    // _upload(_image);
    setState(() {
      _image = img;
    });
  }

  // void _upload(FoodModel foodModel, {File file, String name, String price, String description,
  //     String category, String type, String time}) async {

  Future<Response> _upload(FoodModel foodModel) async {
    String fileName = foodModel.photo.path
        .split('/')
        .last; //   String fileName = file.path.split('/').last;

    var headers = {
      'authorization': 'Bearer $token',
    };
    print('hello');
    var image = await MultipartFile.fromFile(foodModel.photo.path,
        filename: fileName, contentType: MediaType('image', 'jpeg'));

    var data = FormData.fromMap({
      "photo": image,
      "name": foodModel.name,
      "price": foodModel.price,
      "description": foodModel.description,
      "time": foodModel.time,
      "category": foodModel.category,
      "type": foodModel.type,
    });

    print(data.fields);
    print(data.files);
    Dio dio =
        new Dio(BaseOptions(headers: headers, contentType: "application/json"));
    String baseUrl = "https://bhansagharapi.herokuapp.com";
    String endPoint = "/api/v1/foods";
    String url = baseUrl + endPoint;
    final response = await dio.post(url, data: data);
    return response;
    // print(response.statusCode);

    //dio.options.contentType= Headers.formUrlEncodedContentType;
    /* dio.post(url,
  options: Options(
              headers: {HttpHeaders.contentTypeHeader: 'application/json',
                        HttpHeaders.authorizationHeader:'Bearer $token',}),
  data: data)
  .then((response) => print(response))
  .catchError((error) => print(error)); */
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
        });
  }

  void checkboxTest(String title) {
    switch (title) {
      case "veg":
        {
          vegval = true;
          selectedcategory = MyCategory('veg', true);
          break;
        }

      case "non-veg":
        {
          nonvegval = true;
          selectedcategory = MyCategory('non-veg', true);

          break;
        }
      case "breakfast":
        {
          brkval = true;
          selectedtype.add(new MyType('breakfast', true));
          break;
        }

      case "lunch":
        {
          lunchval = true;
          selectedtype.add(new MyType('lunch', true));
          break;
        }

      case "dinner":
        {
          dinval = true;
          selectedtype.add(new MyType('dinner', true));
          break;
        }
      default:
        print(title);
    }
    setState(() {});
  }

  FoodModel foodModel;
  String token;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget checkbox(String title, bool isSelected) {
    return Row(
      children: <Widget>[
        Checkbox(
          value: isSelected,
          onChanged: (bool valueAfterTap) {
            // setState(() {
            //   isSelected = value;
            // });
            if (valueAfterTap) {
              // if (title == "Veg" || title == "Non Veg") {
              //   print('here');
              //  // selectedcategory.add(MyCategory(title, boolValue));
              // } else {
              //   if (title == "BreakFast" ||
              //       title == "Lunch" ||
              //       title == "Dinner") {
              //   print('here');

              //    // selectedtype.add(MyType(title, boolValue));
              //   }
              // }

              switch (title) {
                case "Veg":
                  {
                    vegval = true;
                    selectedcategory = MyCategory('veg', true);
                    break;
                  }

                case "Non Veg":
                  {
                    nonvegval = true;
                    selectedcategory = MyCategory('non-veg', true);

                    break;
                  }
                case "BreakFast":
                  {
                    brkval = true;
                    selectedtype.add(new MyType('breakfast', true));
                    break;
                  }

                case "Lunch":
                  {
                    lunchval = true;
                    selectedtype.add(new MyType('lunch', true));
                    break;
                  }

                case "Dinner":
                  {
                    dinval = true;
                    selectedtype.add(new MyType('dinner', true));
                    break;
                  }
                default:
                  print(title);
              }
            } else {
              // if current check box is unselected
              switch (title) {
                case "Veg":
                  {
                    vegval = false;
                    selectedcategory = null;
                    break;
                  }

                case "Non Veg":
                  {
                    nonvegval = false;
                    selectedcategory = null;

                    break;
                  }
                case "BreakFast":
                  {
                    brkval = false;
                    final toRemove = selectedtype
                        .firstWhere((MyType type) => type.title == 'breakfast');
                    selectedtype.remove(toRemove);
                    break;
                  }

                case "Lunch":
                  {
                    lunchval = false;
                    final toRemove = selectedtype
                        .firstWhere((MyType type) => type.title == 'lunch');
                    selectedtype.remove(toRemove);
                    break;
                  }

                case "Dinner":
                  {
                    dinval = false;
                    final toRemove = selectedtype
                        .firstWhere((MyType type) => type.title == 'dinner');
                    selectedtype.remove(toRemove);
                    break;
                  }
                default:
                  print(title);
              }
            }

            setState(() {});
          },
        ),
        Text(
          title,
          style:
              TextStyle(color: Colors.yellow[700], fontWeight: FontWeight.bold),
        ),
      ],
    );

    //});
  }

  setTokenValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    token = prefs.getString("token");
    print('add food token$token');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = widget.navigation == "Edit"
        ? TextEditingController(text: widget.foodData.name)
        : TextEditingController();
    description = widget.navigation == "Edit"
        ? TextEditingController(text: widget.foodData.description)
        : TextEditingController();
    time = widget.navigation == "Edit"
        ? TextEditingController(text: (widget.foodData.time).toString())
        : TextEditingController();
    price = widget.navigation == "Edit"
        ? TextEditingController(text: (widget.foodData.price).toString())
        : TextEditingController();
    //foodId = widget.navigation == "Edit" ? widget.foodData.id : "";

    print('foodID in addfood${widget.foodID}');
    // oldName = widget.foodData.name;
    // oldPrice = widget.foodData.price;
    // oldTime = widget.foodData.time;
    // oldDesc = widget.foodData.description;
    // oldcategory = widget.foodData.category;
    // oldtype = widget.foodData.type;
    // oldPhoto = widget.foodData.photo;

    //  category = TextEditingController();
    // type = TextEditingController();

    setTokenValuesSF();
    String category =
        widget.navigation == 'Edit' ? widget.foodData.category : '';
    List<String> type = widget.navigation == 'Edit' ? widget.foodData.type : [];

    checkboxTest(category);
    for (int i = 0; i < type.length; i++) checkboxTest(type[i]);
  }

  @override
  Widget build(BuildContext context) {
    // final FoodModel foodData = ModalRoute.of(context).settings.;

    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.navigation == 'Edit' ? 'Edit Menu' : 'Add Menu',
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
                margin: EdgeInsets.only(top: 10.0),
                width: 165.0,
                height: 200,
                color: Colors.yellowAccent,
                child: GestureDetector(
                  onTap: widget.navigation != 'Edit'
                      ? () {
                          _showPicker(context);
                          //_choose();
                        }
                      : () {},
                  // child: CircleAvatar(
                  //   radius: 55,
                  //   backgroundColor: Color(0xffFDCF09),
                  child: (widget.navigation == 'Edit')
                      ? widget.foodData.image !=
                              null //|| widget.foodData.photo != null
                          ? ClipRRect(
                              // borderRadius: BorderRadius.circular(55),
                              child: _image != null
                                  ? Image.file(
                                      _image,
                                      width: 140,
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    )
                                  : Image.network(
                                      widget.foodData.image,
                                      fit: BoxFit.fill,
                                    ),

                              // child: Image.file(
                              //   widget.navigation == 'Edit'
                              //       ? widget.foodData.photo
                              //       : _image,
                              //   width: 140,
                              //   height: 200,
                              //   fit: BoxFit.cover,
                              // ),
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
                            )
                      : _image != null
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Image.file(
                                _image,
                                width: 140,
                                height: 100,
                                fit: BoxFit.fitHeight,
                              ),
                            )
                          : Center(
                              child: Text(
                              'Add a photo',
                              style: TextStyle(color: Colors.grey),
                            )),
                ),
                // circle avatar end  ),
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
            ],
          ),

          /* */
        ),
        widget.navigation == 'Edit'
            ? Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.only(right: 10.0),
                  width: deviceSize.width / 3,
                  height: 40.0,
                  //   color: Colors.amberAccent,
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    child: Row(
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Edit Photo',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    onPressed: () {
                      getImage();
                    },
                  ),
                ),
              )
            : Container(),
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
              Text('Details', style: TextStyle(color: Colors.grey[600])),
              Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.only(left: 5, right: 5),
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
              onPressed: () {
                print('edited value${price.text}');
                if (widget.navigation == 'Edit') {
                  FoodService()
                      .updateFood(
                          FoodModel(
                              photo: _image,
                              name: name.text,
                              price: int.parse(price.text),
                              description: description.text,
                              time: int.parse(time.text),
                              category: selectedcategory.title,
                              type: selectedtype
                                  .map((MyType type) => type.title)
                                  .toList()),
                          widget.foodID,
                          _image == null ? false : true)
                      .then((value) {
                    if (value.statusCode == 201) {
                      Fluttertoast.showToast(
                        msg: 'Food Item updated in menu',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 10.0,
                      );
                    }
                  });
                } else {
                  print(selectedcategory);
                  print(selectedtype);

                  FoodService()
                      .addFood(FoodModel(
                          photo: _image,
                          name: name.text,
                          price: int.parse(price.text),
                          description: description.text,
                          time: int.parse(time.text),
                          category: selectedcategory.title,
                          type: selectedtype
                              .map((MyType type) => type.title)
                              .toList()))
                      .then((value) {
                    if (value.statusCode == 201) {
                      Fluttertoast.showToast(
                        msg: 'Food Item added to menu',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 10.0,
                      );
                    }
                  });
                }

                // _upload(FoodModel(
                //     photo: _image,
                //     name: name.text,
                //     price: int.parse(price.text),
                //     description: description.text,
                //     time: int.parse(time.text),
                //     category: selectedcategory.title,
                //     type: selectedtype
                //         .map((MyType type) => type.title)
                //         .toList()));
              },
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
              icon: Icon(
                Icons.add,
                color: Colors.yellow[700],
              ),
              label: Text(
                'Add item',
                style: TextStyle(color: Colors.yellow[700]),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
