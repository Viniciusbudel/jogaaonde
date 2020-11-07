import 'package:flutter/material.dart';
import 'package:jogaaonde/utils/checkbox_model.dart';
import 'package:jogaaonde/utils/constants.dart';
import 'package:jogaaonde/utils/widgets/custom_checkbox.dart';

class CheckBoxField extends StatelessWidget {
  CheckBoxModel item;

  CheckBoxField(this.item);


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyleGreen,
      height: 60.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 10,
            child: Container(
                padding: EdgeInsets.only(left: 8),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                )),
          ),
          Expanded(
            flex: 95,
            child: CheckboxWidget(item: item),
          ),
        ],
      ),
    );
  }
}
