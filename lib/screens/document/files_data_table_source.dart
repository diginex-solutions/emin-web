import 'package:business/bloc/document/document_bloc.dart';
import 'package:business/bloc/document/document_event.dart';
import 'package:business/constants/api_constant.dart';
import 'package:business/constants/constants.dart';
import 'package:business/model/documents/document_contact_model.dart';
import 'package:business/model/documents/file_model.dart';
import 'package:business/utils/share_pref_service.dart';
import 'package:common/constants/initializer_constants.dart';
import 'package:common/utils/helper.dart';
import 'package:eminweb/screens/document/dialogs/delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dialogs/share_file_dialog.dart';

class FilesDataTableSource implements DataTableSource {
  final List<WebFileModel> files;
  DocumentContactModel contact;

  Function onSharedFile;
  Function onShowHistory;
  Function(int index, bool change) onSelected;
  BuildContext context;

  FilesDataTableSource(
      {this.context,
      this.files,
      this.contact,
      this.onSharedFile,
      this.onSelected,
      this.onShowHistory});

  @override
  DataRow getRow(int index) {
    if (files == null) return DataRow(cells: <DataCell>[]);
    var item = files[index];
    return DataRow(
      selected: item.isChecked,
      onSelectChanged: (change) {
        item.isChecked = change;
        onSelected(index, change);
      },
      cells: <DataCell>[
        DataCell(
          Container(
            width: 60,
            child: Text(
              '${index + 1}',
              style: contentTableStyle,
            ),
          ),
        ),
        DataCell(
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/ic_file.svg',
                width: 16,
                height: 16,
                color: Color(0xff646464),
              ),
              SizedBox(
                width: 12.0,
              ),
              Container(
                width: 180,
                child: Text(
                  '${item.name}',
                  maxLines: 2,
                  style: contentTableStyle,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Text(
            item.documentType ?? 'Work Contract',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: contentTableStyle,
          ),
        ),
        DataCell(
          Text(
            '${convertDateHour(item.uploadedAt) ?? 'Unknown'}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: contentTableStyle,
          ),
        ),
        DataCell(
          Text(
            '${convertDateHour(item.updatedAt) ?? 'Unknown'}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: contentTableStyle,
          ),
        ),
        DataCell(
          Text(
            '${item.status}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: contentTableStyle,
          ),
        ),
        DataCell(Text(
          '${_thirdPartyValue(item)}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: contentTableStyle,
        )),
        if (SharedPreferencesService.getUserRole == supplier)
          DataCell(
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Visibility(
                  visible: contact.name != null,
                  child: IconButton(
                      tooltip: 'Share',
                      splashRadius: 16,
                      icon: Icon(
                        Icons.share,
                        size: 20,
                        color: Color(0xff909090),
                      ),
                      onPressed: () async {
                        await showDialog(
                            barrierColor: Color(0x00ffffff),
                            context: context,
                            builder: (BuildContext context) {
                              return ShareFileDialog(
                                files: item,
                                contact: contact,
                                onShareConfirmed: (docId, message, fileName) =>
                                    _shareFile(
                                        docId, message, context, fileName),
                              );
                            });
                      }),
                ),
                // GestureDetector(
                //     child: Container(
                //       child: Tooltip(
                //         message: "Archive",
                //         child: Icon(
                //           Icons.inbox,
                //           size: 20,
                //           color: Color(0xff909090),
                //         ),
                //       ),
                //     ),
                //     onTap: () async {
                //       await showDialog(
                //           barrierColor: Color(0x00ffffff),
                //           context: context,
                //           builder: (BuildContext context) {
                //             return DocumentArchiveDialog(
                //               files: item,
                //             );
                //           });
                //     }),

                IconButton(
                    tooltip: "History",
                    splashRadius: 16,
                    icon: Icon(
                      Icons.history,
                      size: 20,
                      color: Color(0xff909090),
                    ),
                    onPressed: () => onShowHistory(item.sId)),

                IconButton(
                    tooltip: "Delete",
                    splashRadius: 16,
                    icon: Icon(
                      Icons.delete,
                      size: 20,
                      color: Color(0xff909090),
                    ),
                    onPressed: () async {
                      await showDialog(
                          barrierColor: Color(0x00ffffff),
                          context: context,
                          builder: (BuildContext context) {
                            return DeleteFileDialog(
                              files: item,
                              onDeleteConfirmed: _deleteFile,
                            );
                          });
                    }),
              ],
            ),
          ),
      ],
    );
  }

  String _thirdPartyValue(WebFileModel item) {
    if (item.thirdPartyConsent == null) return 'Unknown';
    return item.thirdPartyConsent ? 'Yes' : 'No';
  }

  bool get isRowCountApproximate => false;

  @override
  void notifyListeners() {}

  @override
  void removeListener(listener) {}

  @override
  int get rowCount => files == null ? 0 : files.length;

  @override
  int get selectedRowCount => 0;

  // Handle when tap on delete file
  _deleteFile(String docId) {
    BlocProvider.of<DocumentBloc>(context).add(DeleteFilesEvent(
        accessToken: SharedPreferencesService.getAccessToken,
        origin: Origin,
        docId: docId ?? ""));
  }

  // Handle when tap on share file
  _shareFile(
      String docId, String message, BuildContext context, String fileName) {
    if (contact.isValid == null || contact.isValid) {
      Navigator.pop(context);
      BlocProvider.of<DocumentBloc>(context).add(ShareFilesEvent(
          accessToken: SharedPreferencesService.getAccessToken,
          origin: Origin,
          shareTo: contact.userId ?? "",
          map: {'docId': docId ?? "", 'message': message ?? ""}));
      this.onSharedFile(fileName);
    }
    print('SHARE: $docId');
  }

  @override
  void addListener(listener) {}

  @override
  void dispose() {}

  @override
  bool get hasListeners => true;
}
