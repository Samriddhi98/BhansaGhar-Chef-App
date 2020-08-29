import 'package:BhansaGharChef/widgets/forminput.dart';
import 'package:flutter/material.dart';

class AddFood extends StatefulWidget {
  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
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
                  child: Column(
                    children: <Widget>[
                      FormInputs(
                        input: 'Name',
                        inputType: TextInputType.text,
                      ),
                      FormInputs(
                        input: 'Price',
                        inputType: TextInputType.number,
                      ),
                      FormInputs(
                        input: 'Preparation Time',
                        inputType: TextInputType.text,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 165.0,
                //   color: Colors.yellowAccent,
                child: Stack(
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
                      child: Center(
                          child: Text(
                        'Add a photo',
                        style: TextStyle(color: Colors.grey),
                      )),
                    ),
                    Positioned(
                        top: 120.0,
                        left: 130.0,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.amber,
                            ),
                          ),
                        ))
                  ],
                ),
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
                onPressed: () {},
                icon: Icon(Icons.add,color: Colors.yellow[700],),
                label: Text('Add item',style: TextStyle(color:Colors.yellow[700]),),
                ),
          ),
        ),
      ]),
    );
  }
}
