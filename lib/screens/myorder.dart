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
      body: Container(
        height: deviceSize.height,
        width: deviceSize.width,
        // padding: EdgeInsets.only(top:10.0,left:10.0),
        //  color: Colors.pink[300],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text('${DateFormat.yMMMEd().format(currentDate)}'),
            ),
            Container(
                height: 440,
                width: deviceSize.width,
                //   color: Colors.blue[50],
                child:
                    ListView.builder(itemBuilder: (context, i) => OrderCard())),
          ],
        ),
      ),
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
      ),
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
        child: Row(
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
                      'Name:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
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
        ),
      ),
    );
  }
}
