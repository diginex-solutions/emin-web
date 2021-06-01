import 'dart:ui';

import 'package:business/model/documents/document_contact_model.dart';
import 'package:business/model/documents/file_model.dart';
import 'package:common/constants/initializer_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShareFileDialog extends StatefulWidget {
  final WebFileModel files;
  final DocumentContactModel contact;
  final Function onShareConfirmed;

  ShareFileDialog({this.files, this.contact, this.onShareConfirmed});

  @override
  _ShareFileDialogState createState() => _ShareFileDialogState();
}

class _ShareFileDialogState extends State<ShareFileDialog> {
  TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

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
                  'Share File(s)',
                  style: titleDialogStyle,
                ),
                Spacer(),
                IconButton(
                    icon: Icon(Icons.close, size: 16, color: Color(0xff111111)),
                    onPressed: () => Navigator.pop(context))
              ],
            ),
            // List files at here
            Container(
              margin: EdgeInsets.only(top: 16.0, bottom: 16, right: 1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: Text('${widget.files.name ?? 'Unknown'}',
                        style: fileNmDialogStyle),
                  ),
                ],
              ),
            ),
            Text(
              'Recipient:',
              style: recipientStyle,
            ),
            SizedBox(
              height: 9,
            ),
            Text(
              '${widget.contact.name ?? 'Unknown'}',
              style: nameStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 25.0),
              child: Text(
                '${widget.contact.email ?? 'Unknown'}',
                style: emailStyle,
              ),
            ),
            Visibility(
              visible: widget.contact.isValid == null
                  ? false
                  : !widget.contact.isValid,
              child: Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  'Connection already removed. File can\'t be shared',
                  style: contentTableStyle.copyWith(color: Colors.red),
                ),
              ),
            ),
            Divider(
              color: Color(0xffE3E3E3),
              height: 1.0,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffE3E3E3), width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(4.0))),
              child: TextField(
                controller: _commentController,
                textAlignVertical: TextAlignVertical.center,
                style: inputContentStyle,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    hintText: 'Comment',
                    hintStyle: hintGreyStyle,
                    prefixIcon:
                        Icon(Icons.chat_bubble, size: 16, color: Colors.black)),
              ),
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
                  onTap: () {
                    widget.onShareConfirmed(widget.files.sId,
                        _commentController.text, widget.files.name);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffA82E25),
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    padding: EdgeInsets.only(
                        left: 15.0, right: 15, top: 13, bottom: 9),
                    child: Text('SHARE', style: buttonDialogStyle),
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
