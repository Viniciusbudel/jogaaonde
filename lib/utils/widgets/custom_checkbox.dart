import 'package:flutter/material.dart';
import 'package:jogaaonde/utils/checkbox_model.dart';
import 'package:jogaaonde/utils/constants.dart';

class CheckboxWidget extends StatefulWidget {
  const CheckboxWidget({ Key key, this.item }) : super(key: key);

  final CheckBoxModel item;

  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: Colors.white,),
      child: CheckboxListTile(
        title: Container(padding: EdgeInsets.only(right: 40),child: Text(widget.item.texto, style: kFieldTextStyle,)),
        value: widget.item.checked,
        activeColor:  Colors.green,
        onChanged: (bool value){
          setState((){
            widget.item.checked = value;
          });
        },
      ),
    );
  }
}