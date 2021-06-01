import 'dart:ui';

import 'package:business/model/documents/document_contact_model.dart';
import 'package:common/constants/initializer_constants.dart';
import 'package:common/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessSentDialog extends StatefulWidget {
  final DocumentContactModel contact;
  final String fileNm;

  SuccessSentDialog({this.fileNm, this.contact});

  @override
  _SuccessSentDialogState createState() => _SuccessSentDialogState();
}

class _SuccessSentDialogState extends State<SuccessSentDialog> {
  @override
  Widget build(BuildContext context) {
    return new BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.25),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        backgroundColor: Colors.transparent.withOpacity(0.8),
        child: _dialogContent(context),
      ),
    );
  }

  Widget _dialogContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Successfully sent!',
                  style: titleDialogStyle,
                ),
                Spacer(),
                IconButton(
                    icon: Icon(Icons.close, size: 16, color: Color(0xff111111)),
                    onPressed: () => Navigator.pop(context))
              ],
            ),
            SizedBox(
              height: 14.0,
            ),
            Text(
              'Your file was successfully sent at ${convertDateHour(DateTime.now().millisecondsSinceEpoch)}',
              style: subTitleStyle,
            ),
            SizedBox(
              height: 24.0,
            ),
            Text(
              '${widget.contact.name ?? ''} ${widget.contact.surname ?? ''}',
              style: nameStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 25.0),
              child: Text(
                '${widget.contact.email ?? ''}',
                style: emailStyle,
              ),
            ),
            Divider(
              color: Color(0xffE3E3E3),
              height: 1.0,
            ),
            SizedBox(
              height: 24.0,
            ),
            // List files at here
            Row(
              children: <Widget>[
                SvgPicture.asset(
                  'assets/icons/ic_file.svg',
                  width: 16.0,
                  height: 16.0,
                  color: Color(0xff646464),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text('${widget.fileNm ?? ''}', style: fileNmDialogStyle),
              ],
            ),
            SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffA82E25),
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    padding: EdgeInsets.only(
                        left: 15.0, right: 15, top: 13, bottom: 9),
                    child: Text('CLOSE', style: buttonDialogStyle),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
