import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:ui';

import 'package:business/model/documents/file_upload_model.dart';
import 'package:common/constants/initializer_constants.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_svg/flutter_svg.dart';

const documentTypes = ['Work Contract'];

class UploadFileDialog extends StatefulWidget {
  final Function(List<FileDocumentModel>, String documentType)
      onUploadConfirmed;

  UploadFileDialog({Key key, this.onUploadConfirmed}) : super(key: key);

  @override
  _UploadFileDialogState createState() => _UploadFileDialogState();
}

class _UploadFileDialogState extends State<UploadFileDialog> {
  List<FileDocumentModel> _files = [];
  DropzoneViewController _controller1;
  DropzoneViewController _controller2;
  String _message1 = 'Drop something here';
  bool _highlighted1 = false;
  List<int> _selectedFile;
  Uint8List _bytesData;
  String _errorMessage;
  String _selectedDocumentType;

  @override
  void initState() {
    super.initState();
    _selectedDocumentType = documentTypes.first;
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
                  'Upload Document',
                  style: titleDialogStyle,
                ),
                Spacer(),
                IconButton(
                    icon: Icon(Icons.close, size: 16, color: Color(0xff111111)),
                    onPressed: () => Navigator.pop(context))
              ],
            ),
            SizedBox(
              height: 24.0,
            ),
            _documentTypeDropDown(),
            SizedBox(
              height: 24.0,
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: startWebFilePicker,
              child: Container(
                width: double.infinity,
                height: 80,
                child: Stack(
                  children: [
                    Container(child: buildZone1(context)),
                    Container(
                      width: double.infinity,
                      child: DottedBorder(
                        padding: const EdgeInsets.all(18.0),
                        color: Color(0xffE3E3E3),
                        borderType: BorderType.RRect,
                        radius: Radius.circular(8.0),
                        dashPattern: [6, 4],
                        strokeWidth: 1,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Icon(
                              Icons.cloud_upload,
                              size: 32,
                              color: Color(0xffB8B8B8),
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text.rich(TextSpan(children: [
                                TextSpan(
                                    text: 'Drag & drop file here or ',
                                    style: emailStyle),
                                TextSpan(
                                    text: 'click ',
                                    style:
                                        emailStyle.copyWith(color: Colors.red)),
                                TextSpan(text: 'to select', style: emailStyle)
                              ])),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            Visibility(
              visible: _errorMessage != null && _errorMessage != '',
              child: Text(
                _errorMessage ?? '',
                style: contentTableStyle.copyWith(color: Colors.red),
              ),
            ),
            // List files at here
            Container(
              constraints: BoxConstraints(maxHeight: 200, minHeight: 0),
              child: Scrollbar(
                showTrackOnHover: true,
                isAlwaysShown: true,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _files.length,
                    itemBuilder: (context, index) {
                      final item = _files[index];
                      return Row(
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
                          Expanded(
                            child: Container(
                              child: Text('${item.name}',
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  style: fileNmDialogStyle),
                            ),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.delete_outline,
                                size: 16,
                                color: Color(0xff909090),
                              ),
                              onPressed: () {
                                setState(() {
                                  _files.removeAt(index);
                                });
                              }),
                          SizedBox(
                            width: 16.0,
                          )
                        ],
                      );
                    }),
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
                    if (_files.isNotEmpty) {
                      widget.onUploadConfirmed(_files, _selectedDocumentType);
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffA82E25)
                            .withOpacity(_files.isNotEmpty ? 1 : 0.3),
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    padding: EdgeInsets.only(
                        left: 15.0, right: 15, top: 13, bottom: 9),
                    child: Text('UPLOAD', style: buttonDialogStyle),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildZone1(BuildContext context) => Builder(
        builder: (context) => DropzoneView(
          operation: DragOperation.copy,
          cursor: CursorType.grab,
          onCreated: (ctrl) {
            _controller1 = ctrl;
          },
          onLoaded: () => print('Zone loaded'),
          onError: (ev) => print('Zone error: $ev'),
          onHover: () {
            setState(() => _highlighted1 = true);
            print('Zone hovered');
          },
          onLeave: () {
            setState(() => _highlighted1 = false);
            print('Zone left');
          },
          onDrop: (ev) {
            print('Zone drop: ${ev.name}');
            setState(() {
              _errorMessage = '';
              final file = ev;
              final reader = new html.FileReader();
              reader.readAsDataUrl(ev);
              reader.onLoadEnd.listen((e) {
                if (ev.type == 'application/pdf' && ev.size <= 20971520) {
                  _handleResult(reader.result, ev.name);
                } else {
                  setState(() {
                    _errorMessage = ev.size > 20971520
                        ? 'The file size exceeds the maximum file size limit of 20MB and cannot be uploaded'
                        : 'Allow only pdf file';
                  });
                }
              });
              print('${file.name}');
              _message1 = '${ev.name} dropped';
            });
          },
        ),
      );

  startWebFilePicker() async {
    html.InputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.accept = '.pdf';
    uploadInput.click();
    uploadInput.onChange.listen((e) {
      final _files = uploadInput.files;
      _errorMessage = '';
      _files.forEach((ev) {
        if (ev.type == 'application/pdf' && ev.size <= 20971520) {
          final reader = new html.FileReader();
          reader.readAsDataUrl(ev);
          reader.onLoadEnd.listen((e) {
            print(ev.size);
            _handleResult(reader.result, ev.name);
          });
          print('${ev.name}');
        } else {
          setState(() {
            _errorMessage = ev.size > 20971520
                ? 'The file size exceeds the maximum file size limit of 20MB and cannot be uploaded'
                : 'Allow only pdf file';
          });
          return;
        }
      });
    });
  }

  void _handleResult(Object result, String fileName) {
    setState(() {
      _bytesData = Base64Decoder().convert(result.toString().split(",").last);
      _selectedFile = _bytesData;
      _files.add(FileDocumentModel(name: fileName, bytes: _selectedFile));
    });
  }

  Widget _documentTypeDropDown() {
    final widgets = documentTypes
        .map((x) => DropdownMenuItem(
              child: Text(x, style: textInputStyle),
              value: x,
            ))
        .toList();
    return Container(
      height: 40.0,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Color(0xffE3E3E3),
          )),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            value: _selectedDocumentType,
            iconEnabledColor: arrowColor,
            items: widgets,
            onChanged: (value) {
              _selectedDocumentType = value;
            }),
      ),
    );
  }
}
