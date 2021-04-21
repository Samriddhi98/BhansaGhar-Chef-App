import 'package:BhansaGharChef/services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditAlertBox extends StatefulWidget {
  final String title;
  EditAlertBox({@required this.title});
  @override
  _EditAlertBoxState createState() => _EditAlertBoxState();
}

class _EditAlertBoxState extends State<EditAlertBox> {
  final TextEditingController _oldpassword = new TextEditingController();
  final TextEditingController _newpassword = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (widget.title != 'Change Password') {
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
    } else {
      return AlertDialog(
        title: Text(widget.title),
        content: Container(
          height: 200.0,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 4, right: 4),
                alignment: Alignment.center,
                height: 70,
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: new BoxDecoration(
                  //color: Colors.amber,
                  borderRadius: new BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.amber),
                ),
                child: TextFormField(
                    controller: _oldpassword,
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText: "Current Password")),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.only(left: 4, right: 4),
                alignment: Alignment.center,
                height: 70,
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: new BoxDecoration(
                  //color: Colors.amber,
                  borderRadius: new BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.amber),
                ),
                child: TextFormField(
                    controller: _newpassword,
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText: "New Password")),
              ),
              // Container(
              //   height: 50,
              //   width: 150,
              //   decoration:
              //       BoxDecoration(border: Border.all(color: Colors.amber)),

              // ),
            ],
          ),
        ),
        actions: <Widget>[
          new TextButton(
            child: new Text("Save Changes"),
            onPressed: () {
              print('oldpass:${_oldpassword.text}');
              print('newpass:${_newpassword.text}');

              AuthService()
                  .updatePassword(
                      newpass: _newpassword.text, oldpass: _oldpassword.text)
                  .then((value) => Navigator.pop(context));
              Fluttertoast.showToast(
                msg: 'Password updated',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey,
                textColor: Colors.white,
                fontSize: 14.0,
              );
            },
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
