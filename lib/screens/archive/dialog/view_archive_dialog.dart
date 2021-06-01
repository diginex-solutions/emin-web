import 'dart:ui';

import 'package:common/constants/initializer_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewArchiveDialog extends StatefulWidget {
  final String archiveFile;

  ViewArchiveDialog({this.archiveFile});

  @override
  _ViewArchiveDialogState createState() => _ViewArchiveDialogState();
}

class _ViewArchiveDialogState extends State<ViewArchiveDialog> {
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
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                Text(
                  'View File?',
                  style: titleDialogStyle,
                ),
                Spacer(),
                IconButton(
                    icon: Icon(Icons.close, size: 16, color: Color(0xff111111)),
                    onPressed: () => Navigator.pop(context))
              ],
            ),
            SizedBox(
              height: 26.0,
            ),
            Row(
              children: <Widget>[
                SvgPicture.asset(
                  'assets/icons/ic_archive.svg',
                  width: 16.0,
                  height: 16.0,
                  color: Color(0xff646464),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text('${widget.archiveFile}', style: fileNmDialogStyle),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: TextFormField(
                style: inputContentStyle,
                decoration: InputDecoration(
                    labelText: 'Password', labelStyle: inputLblStyle),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff808285),
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    padding: EdgeInsets.only(
                        left: 15.0, right: 15, top: 13, bottom: 9),
                    child: Text(
                      'CANCEL',
                      style: buttonDialogStyle,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.0,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffA82E25),
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    padding: EdgeInsets.only(
                        left: 15.0, right: 15, top: 13, bottom: 9),
                    child: Text('ARCHIVE', style: buttonDialogStyle),
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
