// import 'package:flutter/material.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:intl/intl.dart';

// class ScheduleCard extends StatefulWidget {
//   final String day;

//   ScheduleCard({this.day});

//   @override
//   _ScheduleCardState createState() => _ScheduleCardState();
// }

// class _ScheduleCardState extends State<ScheduleCard> {
//   TimeOfDay _time = TimeOfDay.now();
//   bool state = false;
//   @override
//   Widget build(BuildContext context) {
//     final deviceSize = MediaQuery.of(context).size;
//     // TextEditingController timeCtl = TextEditingController();

//     Future<TimeOfDay> _selectTime(BuildContext context) async {
//       final TimeOfDay picked =
//           await showTimePicker(context: context, initialTime: _time);

//       if (picked != null && picked != _time) {
//         print('Time selected: ${_time.toString()}');
//         setState(() {
//           _time = picked;
//           print('pickedTime: $_time');
//         });
//       }

//       return _time;
//     }

//     return Container(
//       width: deviceSize.width,
//       height: 80.0,
//       // color: Colors.red,
//       child: Card(
//         elevation: 5.0,
//         child: Row(
//           children: <Widget>[
//             Container(
//               width: 80,
//               color: Colors.cyan,
//               child: Center(child: Text(widget.day)),
//             ),
//             Container(
//                 padding: EdgeInsets.all(10.0),
//                 width: 100.0,
//                 color: Colors.pink[100],
//                 child: Row(
//                   children: <Widget>[
//                     GestureDetector(
//                       onTap: () {
//                         _selectTime(context);
//                       },
//                       child: Opacity(
//                         opacity: state == true ? 1.0 : 0.5,
//                         alwaysIncludeSemantics: true,
//                         child: Column(
//                           children: <Widget>[
//                             Text('From:', style: TextStyle(
//                                   fontSize: 14.0, fontWeight: FontWeight.normal),),
//                             Spacer(),
//                             Text(
//                               _time.format(context),
//                               style: TextStyle(
//                                   fontSize: 20.0, fontWeight: FontWeight.bold),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     Column()
//                   ],
//                 )

//                 //  ],
//                 // )
//                 ),
//             Container(
//                 padding: EdgeInsets.all(10.0),
//                 width: 100.0,
//                 color: Colors.pink[100],
//                 child: Row(
//                   children: <Widget>[
//                     GestureDetector(
//                       onTap: () {
//                         _selectTime(context);
//                       },
//                       child: Column(
//                         children: <Widget>[
//                           Text('To:'),
//                           Spacer(),
//                           Text(
//                             _time.format(context),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 )

//                 //  ],
//                 // )
//                 ),
//             Expanded(
//               child: Container(

//                   color: Colors.purple[200],
//                   child: Transform.scale(
//                     scale: 1,
//                                       child: Switch(
//                       value: state,
//                       onChanged: (bool s) {
//                         setState(() {
//                           state = s;
//                           print(state);
//                         });
//                       },
//                     ),
//                   )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class ScheduleCard extends StatefulWidget {
  final String day;

  ScheduleCard({this.day});

  @override
  _ScheduleCardState createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  TimeOfDay _time1 = TimeOfDay.now();
  TimeOfDay _time2 = TimeOfDay.now();
  bool state = false;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // TextEditingController timeCtl = TextEditingController();

    Future<TimeOfDay> _selectTime(BuildContext context) async {
      final TimeOfDay picked =
          await showTimePicker(context: context, initialTime: _time1);

      if (picked != null && picked != _time1) {
        print('Time selected: ${_time1.toString()}');
        setState(() {
          _time1 = picked;
          print('pickedTime: $_time1');
        });
      }

      return _time1;
    }

    Future<TimeOfDay> _time(BuildContext context) async {
      final TimeOfDay picked =
          await showTimePicker(context: context, initialTime: _time2);

      if (picked != null && picked != _time2) {
        print('Time selected: ${_time2.toString()}');
        setState(() {
          _time2 = picked;
          print('pickedTime: $_time2');
        });
      }

      return _time2;
    }

    return Container(
      width: deviceSize.width,
      height: 80.0,
      // color: Colors.red,
      child: Card(
        elevation: 5.0,
        child: Row(
          children: <Widget>[
            Container(
              width: 80,
              color: Colors.cyan,
              child: Center(child: Text(widget.day)),
            ),
            Container(
                padding: EdgeInsets.all(10.0),
                width: 100.0,
                color: Colors.pink[100],
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _selectTime(context);
                      },
                      child: Opacity(
                        opacity: state == true ? 1.0 : 0.5,
                        alwaysIncludeSemantics: true,
                        child: Column(
                          children: <Widget>[
                            Text(
                              'From:',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal),
                            ),
                            Spacer(),
                            Text(
                              _time1.format(context),
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    Column()
                  ],
                )

                //  ],
                // )
                ),
            Container(
                padding: EdgeInsets.all(10.0),
                width: 100.0,
                color: Colors.pink[100],
                child: Opacity(
                  opacity: state == true ? 1.0 : 0.5,
                  alwaysIncludeSemantics: true,
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _time(context);
                        },
                        child: Column(
                          children: <Widget>[
                            Text('To:'),
                            Spacer(),
                            Text(
                              _time2.format(context),
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )

                //  ],
                // )
                ),
            Expanded(
              child: Container(
                  color: Colors.purple[200],
                  child: Transform.scale(
                    scale: 1,
                    child: Switch(
                      value: state,
                      onChanged: (bool s) {
                        setState(() {
                          state = s;
                          print(state);
                        });
                      },
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
