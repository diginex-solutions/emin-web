import 'package:business/bloc/document/document_bloc.dart';
import 'package:business/bloc/document/document_event.dart';
import 'package:business/bloc/document/document_state.dart';
import 'package:business/constants/api_constant.dart';
import 'package:business/model/documents/document_contact_model.dart';
import 'package:business/utils/share_pref_service.dart';
import 'package:common/constants/initializer_constants.dart';
import 'package:common/ui/components/paginate_data_table.dart';
import 'package:common/ui/components/progressbar_dialog.dart';
import 'package:eminweb/screens/document/folder_data_table_source.dart';
import 'package:eminweb/ui/header_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FolderListScreen extends StatefulWidget {
  final Function onFolderSelected;

  FolderListScreen({this.onFolderSelected});

  @override
  _FolderListScreenState createState() => _FolderListScreenState();
}

class _FolderListScreenState extends State<FolderListScreen>
    with AutomaticKeepAliveClientMixin {
  List<DocumentContactModel> documents = [];
  String _folderNm;
  List<DocumentContactModel> filteredDocuments;
  bool _sortAsc = true;
  int _sortColumnIndex;

  @override
  void initState() {
    _fetchDocumentContacts();
    super.initState();
  }

  _fetchDocumentContacts() async {
    BlocProvider.of<DocumentBloc>(context).add(GetDocumentContactsEvent(
        accessToken: SharedPreferencesService.getAccessToken.toString(),
        origin: Origin));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<DocumentBloc, DocumentState>(
      listener: (context, state) {
        if (state is DocumentLoaded) {
          showProgressBar(context, false);
          documents = state.documentContacts;
          filteredDocuments = <DocumentContactModel>[];
          filteredDocuments.addAll(documents);
        } else if (state is DocumentLoading) {
          showProgressBar(context, true);
        } else if (state is DocumentError) {}
      },
      builder: (context, state) {
        return _buildUI(context);
      },
    );
  }

  Widget _buildUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        HeaderPage(
          hint: 'Search Documents',
          onSearch: _handleSearch,
        ),
        _buildPath(context),
        if (filteredDocuments != null && filteredDocuments.isNotEmpty)
          Expanded(
            child: TrustCorePaginatedDataTable(
              source: FolderDataTableSource(
                  context: context,
                  documents: filteredDocuments,
                  rowClicked: (args) {
                    widget.onFolderSelected(args);
                  }),
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAsc,
              columns: <DataColumn>[
                DataColumn(
                  label: Container(
                    width: 60,
                    child: Text(
                      'S. No.',
                      style: headerTableStyle,
                    ),
                  ),
                ),
                DataColumn(
                  onSort: (columnIndex, sortAscending) {
                    setState(() {
                      if (columnIndex == _sortColumnIndex) {
                        _sortAsc = sortAscending;
                      } else {
                        _sortColumnIndex = columnIndex;
                        _sortAsc = sortAscending;
                      }
                      filteredDocuments.sort((a, b) {
                        int result;
                        if (a.name == null && b.name == null) {
                          result = a.email.compareTo(b.email);
                        } else if (a.name == null) {
                          result = a.email.compareTo(b.name);
                        } else if (b.name == null) {
                          result = a.name.compareTo(b.email);
                        } else {
                          // Ascending Order
                          result = a.name.compareTo(b.name);
                        }
                        return result;
                      });
                      if (!sortAscending) {
                        filteredDocuments = filteredDocuments.reversed.toList();
                      }
                    });
                  },
                  label: Text(
                    'Name',
                    style: headerTableStyle,
                  ),
                ),
                DataColumn(
                  onSort: (columnIndex, sortAscending) {
                    setState(() {
                      if (columnIndex == _sortColumnIndex) {
                        _sortAsc = sortAscending;
                      } else {
                        _sortColumnIndex = columnIndex;
                        _sortAsc = sortAscending;
                      }
                      filteredDocuments.sort((a, b) {
                        int result;
                        if (a.lastUploadedTime == null) {
                          result = 1;
                        } else if (b.lastUploadedTime == null) {
                          result = -1;
                        } else {
                          // Ascending Order
                          result =
                              a.lastUploadedTime.compareTo(b.lastUploadedTime);
                        }
                        return result;
                      });
                      if (!sortAscending) {
                        filteredDocuments = filteredDocuments.reversed.toList();
                      }
                    });
                  },
                  label: Text(
                    'Upload Time',
                    style: headerTableStyle,
                  ),
                ),
                DataColumn(
                  onSort: (columnIndex, sortAscending) {
                    setState(() {
                      if (columnIndex == _sortColumnIndex) {
                        _sortAsc = sortAscending;
                      } else {
                        _sortColumnIndex = columnIndex;
                        _sortAsc = sortAscending;
                      }
                      filteredDocuments.sort((a, b) {
                        int result;
                        if (a.lastUpdatedTime == null) {
                          result = 1;
                        } else if (b.lastUpdatedTime == null) {
                          result = -1;
                        } else {
                          // Ascending Order
                          result =
                              a.lastUpdatedTime.compareTo(b.lastUpdatedTime);
                        }
                        return result;
                      });
                      if (!sortAscending) {
                        filteredDocuments = filteredDocuments.reversed.toList();
                      }
                    });
                  },
                  label: Text(
                    'Update Time',
                    style: headerTableStyle,
                  ),
                ),
              ],
            ),
          )
        else if (filteredDocuments != null && filteredDocuments.isEmpty)
          Expanded(
            child: Center(
              child: Text("No documents available"),
            ),
          )
        else
          Container(),
      ],
    );
  }

  _handleSearch(String val) {
    var searchQuery = val.trim();

    setState(() {
      filteredDocuments = documents
          .where((element) =>
              (element.name ?? "Pending Registration")
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) ||
              element.email.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    });
  }

  Widget _buildPath(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Text(
            'Document',
            style: leadingPathStyle,
          ),
          Visibility(
              visible: _folderNm != null,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Color(0xffB8B8B8),
                ),
              )),
          Visibility(
            visible: _folderNm != null,
            child: Text(
              '$_folderNm',
              style: textPathStyle,
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class DocumentFolderModel {
  String name;
  String uploadTime;
  String updateTime;
  String status;
  bool isFile;
  String thirdPartyConsent;
  bool isChecked;
  List<DocumentFolderModel> files;

  DocumentFolderModel(
      {this.name,
      this.uploadTime,
      this.updateTime,
      this.status,
      this.isFile = false,
      this.thirdPartyConsent,
      this.isChecked,
      this.files});
}
