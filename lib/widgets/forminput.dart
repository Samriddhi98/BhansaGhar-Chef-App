import 'package:flutter/material.dart';

class FormInputs extends StatelessWidget {
  final String input;
  final TextInputType inputType;
  final TextEditingController controller;

  FormInputs({this.input, this.inputType, this.controller, initialvalue});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 14.0),
      controller: controller,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter correct details';
        }
        return null;
      },
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
