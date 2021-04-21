import 'package:BhansaGharChef/models/foodModel.dart';
import 'package:BhansaGharChef/screens/addfood.dart';
import 'package:BhansaGharChef/screens/editfood.dart';
import 'package:BhansaGharChef/services/foodservice.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  ScrollController _hideButtonController;
  String id;
  bool verified;
  String token;

  Future<dynamic> _future;

  setTokenValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    token = prefs.getString("token");
    // print('add food token$token');
  }

  setDetailValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    id = prefs.getString("id");
    verified = prefs.getBool("verified");
    print('add food verified$verified');
  }

  @override
  initState() {
    super.initState();
    // read userid from prefs
    setDetailValuesSF();
    _isVisible = true;
    _hideButtonController = new ScrollController();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible == true) {
          /* only set when the previous state is false
                 * Less widget rebuilds 
                 */
          print("**** ${_isVisible} up"); //Move IO away from setState
          setState(() {
            _isVisible = false;
          });
        }
      } else {
        if (_hideButtonController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (_isVisible == false) {
            /* only set when the previous state is false
                   * Less widget rebuilds 
                   */
            print("**** ${_isVisible} down"); //Move IO away from setState
            setState(() {
              _isVisible = true;
            });
          }
        }
      }
    });

    Future<List<FoodModel>> getFood() async {
      var listOfFood = await FoodService().getFoodDetails();
      return listOfFood;
    }

    _future = getFood();
  }

  Widget foodWidget() {
    return FutureBuilder(
      future: _future, //FoodService().getFoodDetails(),
      builder: (context, foodSnap) {
        //  final deviceSize = MediaQuery.of(context).size;
        if ( // foodSnap.connectionState == ConnectionState.none &&
            foodSnap.data == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Center(
            child: Text(
              'Create your menu and start your food journey',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
          );
        } else {
          return ListView.builder(
            controller: _hideButtonController,
            itemCount: foodSnap.data.length,
            itemBuilder: (context, index) {
              final deviceSize = MediaQuery.of(context).size;
              List<FoodModel> foodlist = foodSnap.data;
              FoodModel foodItem = foodlist[index];
              return Card(
                elevation: 5.0,
                child: Stack(children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10.0),
                    height: 150.0,
                    width: deviceSize.width,
                    //  color: Colors.red
                  ),
                  Positioned(
                    left: 10.0,
                    top: 10.0,
                    bottom: 10.0,
                    child: Container(
                        margin: EdgeInsets.all(10.0),
                        height: 130.0,
                        width: 110.0,
                        //   width:deviceSize.width/3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(55.0),
                            color: Colors.grey),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(55.0),
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            imageUrl:
                                //  'https://bhansagharapi.herokuapp.com/uploads/${product.image}',
                                'http://10.0.2.2:5000/uploads/${foodItem.image}',
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          // child: Image.network(
                          //     //  'http://bhansagharapi.herokuapp.com/uploads/${foodItem.image}'
                          //     'http://10.0.2.2:5000/uploads/${foodItem.image}'),
                        )
                        //  fit: BoxFit.cover,

                        ),
                  ),
                  Positioned(
                    left: 140.0,
                    top: 10.0,
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      height: 150.0,
                      width: 250.0,
                      // color: Colors.yellow,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                //  Container(
                                //  height: 50.0,
                                // color: Colors.red,
                                // child:
                                Text(
                                  foodItem.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                //   ),
                              ],
                            ),
                            Text(
                              ('Rs.${foodItem.price.toString()}'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                            SizedBox(height: 7.0),
                            Container(
                              height: 65.0,
                              width: 190.0,
                              // color: Colors.blue,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Text(
                                  foodItem.description,
                                ),
                              ),
                            ),
                            Spacer(),
                            Row(
                              //  mainAxisAlignment: MainAxisAlignment.end,

                              children: <Widget>[
                                InkWell(
                                  child: Icon(
                                    Icons.edit,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => AddFood(
                                            navigation: 'Edit',
                                            foodData: FoodModel(
                                                name: foodItem.name,
                                                description: foodItem.description,
                                                price: foodItem.price,
                                                time: foodItem.time,
                                                category: foodItem.category,
                                                type: foodItem.type,
                                                photo: foodItem.photo,
                                                image:
                                                    //'http://10.0.2.2:5000/uploads/${foodItem.image}'
                                                    'http://192.161.1.121:5000/uploads/${foodItem.image}'),
                                            foodID: foodItem.id)));
                                    // Navigator.of(context).pushNamed('/add-food',
                                    //     arguments:
                                    //         FoodModel(name: foodItem.name),
                                    //         navigation: Text('Edit'));
                                  },
                                ),
                                SizedBox(width: 5),
                                InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                                title: Text('Are you sure?'),
                                                content: Text(
                                                  'Do you want to remove this item from the menu?',
                                                ),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: Text('No'),
                                                    onPressed: () {
                                                      Navigator.of(ctx)
                                                          .pop(false);
                                                    },
                                                  ),
                                                  FlatButton(
                                                    child: Text('Yes'),
                                                    onPressed: () {
                                                      FoodService()
                                                          .deleteSingleFood(
                                                              foodItem.id)
                                                          .then((value) => {
                                                                if (value
                                                                        .statusCode ==
                                                                    200)
                                                                  {
                                                                    setState(
                                                                        () {
                                                                      foodlist.remove(
                                                                          index);
                                                                    }),
                                                                    Fluttertoast
                                                                        .showToast(
                                                                      msg:
                                                                          'Food Deleted',
                                                                      toastLength:
                                                                          Toast
                                                                              .LENGTH_SHORT,
                                                                      gravity:
                                                                          ToastGravity
                                                                              .BOTTOM,
                                                                      timeInSecForIosWeb:
                                                                          1,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .grey,
                                                                      textColor:
                                                                          Colors
                                                                              .white,
                                                                      fontSize:
                                                                          10.0,
                                                                    ),
                                                                    Navigator.of(
                                                                            ctx)
                                                                        .pop(
                                                                            true),
                                                                  }
                                                                else
                                                                  {
                                                                    Fluttertoast
                                                                        .showToast(
                                                                      msg:
                                                                          'Error deleting food',
                                                                      toastLength:
                                                                          Toast
                                                                              .LENGTH_SHORT,
                                                                      gravity:
                                                                          ToastGravity
                                                                              .BOTTOM,
                                                                      timeInSecForIosWeb:
                                                                          1,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .grey,
                                                                      textColor:
                                                                          Colors
                                                                              .white,
                                                                      fontSize:
                                                                          10.0,
                                                                    ),
                                                                  }
                                                              });
                                                    },
                                                  ),
                                                ],
                                              ));
                                    },
                                    child: Icon(Icons.delete)),
                              ],
                            ),
                          ]),
                    ),
                  )
                ]),
              );
            },
          );
        }
      },
    );
  }

  var _isVisible;

  @override
  Widget build(BuildContext context) {
// validation dialog
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Validation Dialog'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'To get validated as a chef and start creating you menu'),
                  Text('Contact: 9863330414'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK!'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    Future<bool> _onBackPressed() {
      return showDialog(
              context: context,
              builder: (context) => new AlertDialog(
                    title: Text('Are you sure?'),
                    content: Text(
                      'Do you want to exit the App?',
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      FlatButton(
                        child: Text('Yes'),
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                      ),
                    ],
                  )) ??
          false;
    }

    // final deviceSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          /*  floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                backgroundColor: Colors.yellow[700],
                onPressed: () {
                  Navigator.of(context).pushNamed('/add-food');
                },
              ), */
          floatingActionButton: new Visibility(
            visible: _isVisible,
            child: new FloatingActionButton(
              onPressed: () {
                print('verified $verified');
                // check verified ko value
                if (verified != true) {
                  print('alert dialog box');
                  _showMyDialog();
                } else {
                  Navigator.of(context).pushNamed('/add-food');
                }
              },
              backgroundColor: Colors.yellow[700],
              child: new Icon(Icons.add),
            ),
          ),
          appBar: AppBar(
            title: Text(
              'My Menu',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          body: foodWidget()),
    );
  }
}

// class AlertBox extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: AlertDialog(
//         title: Text('Get Verified First'),
//         content: Text(
//             'Please contact 9860197955 to get verified as a chef and start creating menu'),
//       ),
//     );
//   }
// }
//
//
