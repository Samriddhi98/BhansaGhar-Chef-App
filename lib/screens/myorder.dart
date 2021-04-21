import 'package:BhansaGharChef/models/foodModel.dart';
import 'package:BhansaGharChef/models/orderModel.dart';
import 'package:BhansaGharChef/services/foodservice.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderPage extends StatefulWidget {
  var currentDate = DateTime.now();

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  var currentDate = DateTime.now();

  void _increaseDate() {
    setState(() {
      currentDate = currentDate.add(Duration(days: 1));
      // DateTime cDate = DateTime.parse(currentDate);
      // cDate = cDate.add(Duration(days: 1));
      // currentDate = DateFormat.yMMMEd().format(cDate);
    });
  }

  void _decreaseDate() {
    setState(() {
      currentDate = currentDate.subtract(Duration(days: 1));
    });
  }

  //void _updateDate(){
  // setSt
  // }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              'My Orders',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white),
        body: FutureBuilder(
            future: FoodService().getOrderDetails(),
            builder: (context, orderSnap) {
              List<OrderModel> orderList = orderSnap.data;
              if (orderSnap.data == null) {
                return Container();
              } else {
                return Container(
                  height: deviceSize.height,
                  width: deviceSize.width,
                  // padding: EdgeInsets.only(top:10.0,left:10.0),
                  //  color: Colors.pink[300],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child:
                            Text('${DateFormat.yMMMEd().format(currentDate)}'),
                      ),
                      Column(
                        children: orderList
                            .map((order) => Container(
                                height: 150,
                                width: deviceSize.width,
                                color: Colors.blue[50],
                                child: OrderCard(
                                  orderModel: order,
                                )))
                            .toList(),
                      ),
                    ],
                  ),
                );
              }
            }),
        floatingActionButton: Container(
          margin: EdgeInsets.only(left: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton(
                color: Colors.yellow[700],
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                onPressed: () {
                  _decreaseDate();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(Icons.navigate_before),
                    Text("Previous"),
                  ],
                ),
              ),
              RaisedButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                color: Colors.yellow[700],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Text("Next"), Icon(Icons.navigate_next)],
                ),
                onPressed: () {
                  _increaseDate();
                },
              )
            ],
          ),
        )

        /* Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton.extended(
              isExtended: false,
              onPressed: () {},
              label: Text('Previous'),
              icon: Icon(Icons.arrow_back_ios),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
            ),
            FloatingActionButton.extended(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_ios),
              label: Text('Next'),
              
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
            )
          ]), */
        );
  }
}

class OrderCard extends StatefulWidget {
  final OrderModel orderModel;

  const OrderCard({Key key, this.orderModel}) : super(key: key);
  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  var _isMarked = false;

  void _togglemarkstatus() {
    setState(() {
      _isMarked = !_isMarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      width: deviceSize.width,
      height: 150.0,
      color: Colors.red,
      child: Card(
        elevation: 5.0,
        child: Column(
          children: widget.orderModel.food
              .map((food) => buildOrderFoodCard(deviceSize, food))
              .toList(),
        ),
      ),
    );
  }

  Row buildOrderFoodCard(Size deviceSize, FoodModel food) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            width: deviceSize.width / 3,
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.yellow,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.all(10.0),
            width: deviceSize.width / 2,
            color: Colors.blue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  food.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                Text(
                  'Price:',
                  style: TextStyle(fontSize: 14.0),
                ),
                Text(
                  'Ordered By:',
                  style: TextStyle(),
                ),
                Text(
                  'From:',
                  style: TextStyle(),
                ),
                Text(
                  'Time:',
                  style: TextStyle(fontSize: 14.0),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                      onTap: _togglemarkstatus,
                      child: _isMarked
                          ? Icon(
                              Icons.check_circle,
                              size: 35.0,
                            )
                          : Icon(
                              Icons.check_circle_outline,
                              size: 35.0,
                            )),
                  SizedBox(height: 10.0),
                  _isMarked
                      ? Text(
                          'Order Delivered',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )
                      : Text(
                          'Mark as Done',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )
                ],
              ),
            )),
      ],
    );
  }
}

// // // order page incomplete
// Widget foodWidget() {
//   return FutureBuilder(
//     future: FoodService().getOrderDetails(), //FoodService().getFoodDetails(),
//     builder: (context, orderSnap) {
//       //  final deviceSize = MediaQuery.of(context).size;
//       if ( // foodSnap.connectionState == ConnectionState.none &&
//           orderSnap.data == null) {
//         //print('project snapshot data is: ${projectSnap.data}');
//         return Center(
//           child: Text(
//             'You do not have any orders',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
//           ),
//         );
//       } else {
//         return ListView.builder(
//           itemCount: orderSnap.data.length,
//           itemBuilder: (context, index) {
//             final deviceSize = MediaQuery.of(context).size;
//             List<OrderModel> foodlist = orderSnap.data;
//             OrderModel orderItem = foodlist[index];
//             return Card(
//               elevation: 5.0,
//               child: Stack(children: <Widget>[
//                 Container(
//                   margin: EdgeInsets.all(10.0),
//                   height: 150.0,
//                   width: deviceSize.width,
//                   // color: Colors.red
//                 ),
//                 Positioned(
//                   left: 10.0,
//                   top: 10.0,
//                   bottom: 10.0,
//                   child: Container(
//                       margin: EdgeInsets.all(10.0),
//                       height: 130.0,
//                       width: 110.0,
//                       //   width:deviceSize.width/3,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(55.0),
//                           color: Colors.grey),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(55.0),
//                         child: CachedNetworkImage(
//                           placeholder: (context, url) => Container(
//                             child: Center(
//                               child: CircularProgressIndicator(),
//                             ),
//                           ),
//                           imageUrl:
//                               //  'https://bhansagharapi.herokuapp.com/uploads/${product.image}',
//                               'http://10.0.2.2:5000/uploads/${orderItem.food.image}',
//                           fit: BoxFit.cover,
//                           errorWidget: (context, url, error) =>
//                               Icon(Icons.error),
//                         ),
//                         // child: Image.network(
//                         //     //  'http://bhansagharapi.herokuapp.com/uploads/${foodItem.image}'
//                         //     'http://10.0.2.2:5000/uploads/${foodItem.image}'),
//                       )
//                       //  fit: BoxFit.cover,

//                       ),
//                 ),
//                 Positioned(
//                   left: 140.0,
//                   top: 10.0,
//                   child: Container(
//                     padding: EdgeInsets.all(5.0),
//                     height: 150.0,
//                     width: 250.0,
//                     // color: Colors.yellow,
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               //  Container(
//                               //  height: 50.0,
//                               // color: Colors.red,
//                               // child:
//                               Text(
//                                 orderItem.food
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16.0,
//                                 ),
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               //   ),
//                             ],
//                           ),
//                           Text(
//                             ('Rs.${foodItem.price.toString()}'),
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 20.0),
//                           ),
//                           SizedBox(height: 7.0),
//                           Container(
//                             height: 65.0,
//                             // color: Colors.blue,
//                             child: SingleChildScrollView(
//                               scrollDirection: Axis.vertical,
//                               child: Text(
//                                 foodItem.description,
//                               ),
//                             ),
//                           ),
//                           Spacer(),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: <Widget>[
//                               InkWell(
//                                 child: Icon(
//                                   Icons.edit,
//                                 ),
//                                 onTap: () {
//                                   Navigator.of(context).push(MaterialPageRoute(
//                                       builder: (context) => AddFood(
//                                           navigation: 'Edit',
//                                           foodData: FoodModel(
//                                               name: foodItem.name,
//                                               description: foodItem.description,
//                                               price: foodItem.price,
//                                               time: foodItem.time,
//                                               category: foodItem.category,
//                                               type: foodItem.type,
//                                               photo: foodItem.photo,
//                                               image:
//                                                   //'http://10.0.2.2:5000/uploads/${foodItem.image}'
//                                                   'http://192.161.1.121:5000/uploads/${foodItem.image}'),
//                                           foodID: foodItem.id)));
//                                   // Navigator.of(context).pushNamed('/add-food',
//                                   //     arguments:
//                                   //         FoodModel(name: foodItem.name),
//                                   //         navigation: Text('Edit'));
//                                 },
//                               ),
//                               SizedBox(width: 5),
//                               InkWell(
//                                   onTap: () {
//                                     showDialog(
//                                         context: context,
//                                         builder: (ctx) => AlertDialog(
//                                               title: Text('Are you sure?'),
//                                               content: Text(
//                                                 'Do you want to remove this item from the menu?',
//                                               ),
//                                               actions: <Widget>[
//                                                 FlatButton(
//                                                   child: Text('No'),
//                                                   onPressed: () {
//                                                     Navigator.of(ctx)
//                                                         .pop(false);
//                                                   },
//                                                 ),
//                                                 FlatButton(
//                                                   child: Text('Yes'),
//                                                   onPressed: () {
//                                                     FoodService()
//                                                         .deleteSingleFood(
//                                                             foodItem.id)
//                                                         .then((value) => {
//                                                               if (value
//                                                                       .statusCode ==
//                                                                   200)
//                                                                 {
//                                                                   setState(() {
//                                                                     foodlist
//                                                                         .remove(
//                                                                             index);
//                                                                   }),
//                                                                   Fluttertoast
//                                                                       .showToast(
//                                                                     msg:
//                                                                         'Food Deleted',
//                                                                     toastLength:
//                                                                         Toast
//                                                                             .LENGTH_SHORT,
//                                                                     gravity:
//                                                                         ToastGravity
//                                                                             .BOTTOM,
//                                                                     timeInSecForIosWeb:
//                                                                         1,
//                                                                     backgroundColor:
//                                                                         Colors
//                                                                             .grey,
//                                                                     textColor:
//                                                                         Colors
//                                                                             .white,
//                                                                     fontSize:
//                                                                         10.0,
//                                                                   ),
//                                                                   Navigator.of(
//                                                                           ctx)
//                                                                       .pop(
//                                                                           true),
//                                                                 }
//                                                               else
//                                                                 {
//                                                                   Fluttertoast
//                                                                       .showToast(
//                                                                     msg:
//                                                                         'Error deleting food',
//                                                                     toastLength:
//                                                                         Toast
//                                                                             .LENGTH_SHORT,
//                                                                     gravity:
//                                                                         ToastGravity
//                                                                             .BOTTOM,
//                                                                     timeInSecForIosWeb:
//                                                                         1,
//                                                                     backgroundColor:
//                                                                         Colors
//                                                                             .grey,
//                                                                     textColor:
//                                                                         Colors
//                                                                             .white,
//                                                                     fontSize:
//                                                                         10.0,
//                                                                   ),
//                                                                 }
//                                                             });
//                                                   },
//                                                 ),
//                                               ],
//                                             ));
//                                   },
//                                   child: Icon(Icons.delete)),
//                             ],
//                           ),
//                         ]),
//                   ),
//                 )
//               ]),
//             );
//           },
//         );
//       }
//     },
//   );
//}
