import 'package:flutter/material.dart';

class FormInputs extends StatelessWidget {
  final String input;
  final TextInputType inputType;

  FormInputs({this.input,this.inputType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
       keyboardType: inputType,
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 14.0),
      
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 0.0, top: 15.0),
        // isDense: true,
        hintText: input,

        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        // border: InputBorder.none,
      ),
    );
  }
}
