import 'package:BhansaGharChef/widgets/schedulecard.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    TextEditingController timeCtl = TextEditingController();

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'My Orders',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white),
      body:  Column(
        children: <Widget>[
         Padding(
            padding: EdgeInsets.all(5.0),
            child: Text('Please let us know when you are available to cook'),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                Container(
                  height: 80,
                  width: deviceSize.width,
                  child: ScheduleCard(day: 'Sun'),
                ),

                /*    Container(
                  height: 80,
                  width: deviceSize.width,
                  child: ScheduleCard(),
              ),
              Container(
                  height: 80,
                  width: deviceSize.width,
                  child: ScheduleCard(),
              ),
              Container(
                  height: 80,
                  width: deviceSize.width,
                  child: ScheduleCard(),
              ),
              Container(
                  height: 80,
                  width: deviceSize.width,
                  child: ScheduleCard(),
              ),
              Container(
                  height: 80,
                  width: deviceSize.width,
                  child: ScheduleCard(),
              ),
              Container(
                  height: 80,
                  width: deviceSize.width,
                  child: ScheduleCard(),
              ), */
              ],
            ),
          ), 
          
        ],
      ), 

    
          );
  }
}

