import 'package:flutter/material.dart';

class EditAlertBox extends StatefulWidget {
  final String title;
  EditAlertBox({@required this.title});
  @override
  _EditAlertBoxState createState() => _EditAlertBoxState();
}

class _EditAlertBoxState extends State<EditAlertBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text('Edit ${widget.title}'),
      content: TextFormField(),
      actions: <Widget>[
        new TextButton(
          child: new Text("Save Changes"),
          onPressed: () {},
        ),
        new TextButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

//   return showAlertDialog(BuildContext context) {

// // set up the buttons
// Widget cancelButton = FlatButton(
//   child: Text("Cancel"),
//   onPressed:  () {},
// );
// Widget continueButton = FlatButton(++++
//   child: Text("Continue"),
//   onPressed:  () {},
// );

// // set up the AlertDialog
// AlertDialog alert = AlertDialog(
//   title: Text("AlertDialog"),
//   content: Text("Would you like to continue learning how to use Flutter alerts?"),
//   actions: [
//     cancelButton,
//     continueButton,
//   ],
// );

// // show the dialog
// showDialog(
//   context: context,
//   builder: (BuildContext context) {
//     return alert;
//   },
// );
//   };
