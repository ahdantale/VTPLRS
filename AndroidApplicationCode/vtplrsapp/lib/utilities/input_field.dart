
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input_Field extends StatelessWidget {
  const Input_Field({this.labal_text, this.hint_text});
  final String ?labal_text;
  final String ?hint_text;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        onChanged: (value){

        },
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            labelStyle: TextStyle(color: Colors.black),
            focusedBorder: OutlineInputBorder(),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            labelText: '$labal_text',
            hintText: '$hint_text'),
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
