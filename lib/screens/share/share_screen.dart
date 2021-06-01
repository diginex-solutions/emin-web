import 'package:common/constants/constant.dart';
import 'package:flutter/material.dart';

class ShareScreen extends StatefulWidget {
  @override
  _ShareScreenState createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * mainSizeBarRatio),
      child: Center(
          child: Text(
        'Share Screen',
        style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w900),
      )),
    );
  }
}
