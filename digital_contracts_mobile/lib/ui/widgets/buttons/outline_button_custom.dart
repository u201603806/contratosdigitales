import 'package:flutter/material.dart';

class OutlineButtonCustom extends StatelessWidget {
  final VoidCallback action;
  final String label;
  final Color labelColor;

  OutlineButtonCustom({Key key, @required this.action, @required this.label, this.labelColor = Colors.white}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.07,
      child: OutlineButton(
        onPressed: this.action,
        borderSide: BorderSide(color: Color(0xff1357BD), width: 2.0),
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(50.0)),
        child: Text(this.label, style: TextStyle(color: this.labelColor,fontWeight: FontWeight.bold)),
      ),
    );
  }
}
