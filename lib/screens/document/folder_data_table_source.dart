import 'package:business/model/documents/document_contact_model.dart';
import 'package:common/constants/initializer_constants.dart';
import 'package:common/utils/helper.dart';
import 'package:flutter/material.dart';

class FolderDataTableSource implements DataTableSource {
  final List<DocumentContactModel> documents;
  BuildContext context;
  final Function rowClicked;

  FolderDataTableSource({this.context, this.documents, this.rowClicked});

  @override
  DataRow getRow(int index) {
    if (documents == null) return DataRow(cells: <DataCell>[]);
    var item = documents[index];
    return DataRow(
      cells: <DataCell>[
        DataCell(
            Text(
              '${index + 1}',
              style: contentTableStyle,
            ), onTap: () {
          _goToDocumentListScreen(item);
        }),
        DataCell(
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 12),
                  child: Icon(
                    Icons.folder,
                    color: Color(0xffFFC107),
                  ),
                ),
                Text(
                  _handleFolderName(item),
                  overflow: TextOverflow.ellipsis,
                  style: contentTableStyle,
                ),
              ],
            ), onTap: () {
          _goToDocumentListScreen(item);
        }),
        DataCell(
            Text(
              '${item.lastUploadedTime != null ? convertDateHour(item.lastUploadedTime) : ""}',
              overflow: TextOverflow.ellipsis,
              style: contentTableStyle,
            ), onTap: () {
          _goToDocumentListScreen(item);
        }),
        DataCell(
            Text(
              '${item.lastUpdatedTime != null ? convertDateHour(item.lastUpdatedTime) : ""}',
              overflow: TextOverflow.ellipsis,
              style: contentTableStyle,
            ), onTap: () {
          _goToDocumentListScreen(item);
        }),
      ],
    );
  }

  String _handleFolderName(DocumentContactModel item) {
    if (item.name == null) return 'Pending Registration (${item.email})';
    return item.name ?? '' + ' ' + item.surname ?? '';
  }

  _goToDocumentListScreen(DocumentContactModel item) {
    rowClicked(item.userId);
  }

  bool get isRowCountApproximate => false;

  @override
  void notifyListeners() {}

  @override
  void removeListener(listener) {}

  @override
  int get rowCount => documents == null ? 0 : documents.length;

  @override
  int get selectedRowCount => 0;

  @override
  void addListener(listener) {}

  @override
  void dispose() {}

  @override
  bool get hasListeners => false;
}
