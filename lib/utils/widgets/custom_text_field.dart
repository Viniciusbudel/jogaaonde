import 'package:flutter/material.dart';
import 'package:jogaaonde/utils/constants.dart';

class CustomTextField extends StatelessWidget {
  String title;
  String hint;
  TextEditingController controller;
  IconData icon;
  bool senha;

  CustomTextField(this.title,this.hint,this.controller,this.icon,{this.senha = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyleGreen,

          height: 60.0,
          child: TextField(
            obscureText: senha,
            controller: controller,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
               icon,
                color: Colors.white,
              ),
              hintText: hint,
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
