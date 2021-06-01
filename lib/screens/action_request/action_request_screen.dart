import 'package:common/constants/constant.dart';
import 'package:flutter/material.dart';

class ActionRequestScreen extends StatefulWidget {
  @override
  _ActionRequestScreenState createState() => _ActionRequestScreenState();
}

class _ActionRequestScreenState extends State<ActionRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * mainSizeBarRatio),
      child: Center(
          child: Text(
        'Action Request',
        style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w900),
      )),
    );
  }
}
