import 'dart:ui';

import 'package:business/model/documents/file_model.dart';
import 'package:common/constants/initializer_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DocumentArchiveDialog extends StatefulWidget {
  final WebFileModel files;

  DocumentArchiveDialog({this.files});

  @override
  _DocumentArchiveDialogState createState() => _DocumentArchiveDialogState();
}

class _DocumentArchiveDialogState extends State<DocumentArchiveDialog> {
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
                  'Archive File',
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
            // List files at here
            Container(
              margin: EdgeInsets.only(top: 16.0),
              child: Row(
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
                  Flexible(
                    child:
                        Text('${widget.files.name}', style: fileNmDialogStyle),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: TextFormField(
                style: inputContentStyle,
                decoration: InputDecoration(
                    labelText: 'Password', labelStyle: inputLblStyle),
              ),
            ),
            TextFormField(
              style: inputContentStyle,
              decoration: InputDecoration(
                  labelText: 'Re-enter Password', labelStyle: inputLblStyle),
            ),
            SizedBox(height: 24.0),
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
