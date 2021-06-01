import 'package:business/bloc/document/document_bloc.dart';
import 'package:business/bloc/document/document_event.dart';
import 'package:business/bloc/document/document_history_cubit.dart';
import 'package:business/bloc/document/document_state.dart';
import 'package:business/constants/api_constant.dart';
import 'package:business/constants/constants.dart';
import 'package:business/model/documents/document_contact_model.dart';
import 'package:business/model/documents/file_model.dart';
import 'package:business/model/documents/file_upload_model.dart';
import 'package:business/utils/share_pref_service.dart';
import 'package:common/constants/constant.dart';
import 'package:common/constants/initializer_constants.dart';
import 'package:common/ui/components/alert_dialog_single.dart';
import 'package:common/ui/components/history_page.dart';
import 'package:common/ui/components/paginate_data_table.dart';
import 'package:common/ui/components/progressbar_dialog.dart';
import 'package:eminweb/screens/document/dialogs/success_sent_dialog.dart';
import 'package:eminweb/screens/document/dialogs/upload_file_native.dart'
    if (dart.library.html) 'package:eminweb/screens/document/dialogs/upload_file_web.dart';
import 'package:eminweb/screens/document/files_data_table_source.dart';
import 'package:eminweb/ui/header_page.dart';
import 'package:eminweb/ui/headline_menu.dart';
import 'package:eminweb/utility/download_nonweb.dart'
    if (dart.library.html) 'package:eminweb/utility/download_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FileListScreen extends StatefulWidget {
  final String userId;
  final Function onBackPressed;

  FileListScreen({this.userId, this.onBackPressed});

  @override
  _FileListScreenState createState() => _FileListScreenState();
}

class _FileListScreenState extends State<FileListScreen> {
  DocumentContactModel documentContactModel;
  List<WebFileModel> files = [];
  List<WebFileModel> filteredFiles;
  bool _sortAsc = true;
  int _sortColumnIndex;
  String _fileNmAfterShared = "";

  @override
  void initState() {
    _fetchFiles();
    super.initState();
  }

  _fetchFiles() async {
    BlocProvider.of<DocumentBloc>(context).add(GetFilesByContactEvent(
        accessToken: SharedPreferencesService.getAccessToken,
        origin: Origin,
        userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      endDrawer: Container(
        width: MediaQuery.of(context).size.width * historyBarRation,
        child: Drawer(
          child: HistoryPage(),
        ),
      ),
      body: BlocConsumer<DocumentBloc, DocumentState>(
        listener: (context, state) {
          if (state is DocumentLoading) {
            showProgressBar(context, true);
          }
          if (state is FilesLoaded) {
            showProgressBar(context, false);
            documentContactModel = state.documentContactModel;
            files = state.files;
            filteredFiles = <WebFileModel>[];
            filteredFiles.addAll(files);
          } else if (state is FilesError) {
            showProgressBar(context, false);
          } else if (state is DeleteFilesError) {
            showProgressBar(context, false);
          } else if (state is DeleteFilesSuccess) {
            showProgressBar(context, false);
            showAlertDialog(context, 'Delete', 'File deleted successfully', () {
              Navigator.pop(context);
              _fetchFiles();
            });
          } else if (state is ShareFilesSuccess) {
            showProgressBar(context, false);
            _fetchFiles();
            _showShareSuccessDialog();
          } else if (state is ShareFilesError) {
          } else if (state is UploadFilesSuccess) {
            _fetchFiles();
          } else if (state is UploadFilesError) {
            print(state.message);
          }
        },
        builder: (context, state) {
          return _buildUI(context);
        },
      ),
    );
  }

  Widget _buildUI(BuildContext context) {
    if (documentContactModel == null) return Container();
    return Column(
      children: <Widget>[
        HeaderPage(
          hint: 'Search files',
          onSearch: _handleSearch,
        ),
        HeadlineMenu(
          onClickMenu: (val) {
            _handleOnClickMenu(val);
          },
          listMenu: [
            if (SharedPreferencesService.getUserRole == supplier)
              HeadlineMenuModel(
                  icon: SvgPicture.asset(
                    'assets/icons/ic_upload.svg',
                    width: 16,
                    height: 16,
                    color: Color(0xff646464),
                  ),
                  menuTitle: 'Upload',
                  isVisible: true),
            HeadlineMenuModel(
              icon: SvgPicture.asset(
                'assets/icons/ic_download_web.svg',
                width: 14,
                height: 14,
                color: Color(0xff646464),
              ),
              menuTitle: 'Download',
              isVisible: _isSelected(),
            ),
            // HeadlineMenuModel(
            //     icon: SvgPicture.asset(
            //       'assets/icons/ic_print.svg',
            //       width: 16,
            //       height: 16,
            //       color: Color(0xff646464),
            //     ),
            //     menuTitle: 'Print'),
          ],
        ),
        _buildPath(context),
        if (filteredFiles != null && filteredFiles.isNotEmpty)
          Expanded(
            child: TrustCorePaginatedDataTable(
              columnSpacing: 4,
              onSelectAll: (change) {
                filteredFiles.forEach((element) {
                  element.isChecked = change;
                });
                setState(() {});
              },
              source: FilesDataTableSource(
                context: context,
                files: filteredFiles,
                onSelected: (index, change) {
                  filteredFiles[index].isChecked = change;
                  setState(() {});
                },
                onSharedFile: (fileName) {
                  setState(() {
                    _fileNmAfterShared = fileName;
                  });
                },
                onShowHistory: (String documentId) {
                  BlocProvider.of<DocumentHistoryCubit>(context).showHistory(
                      SharedPreferencesService.getAccessToken,
                      Origin,
                      documentId);
                  Scaffold.of(context).openEndDrawer();
                },
                contact: documentContactModel,
              ),
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
                      filteredFiles.sort((a, b) {
                        int result;
                        if (a.name == null) {
                          result = 1;
                        } else if (b.name == null) {
                          result = -1;
                        } else {
                          // Ascending Order
                          result = a.name.compareTo(b.name);
                        }
                        return result;
                      });
                      if (!sortAscending) {
                        filteredFiles = filteredFiles.reversed.toList();
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
                      filteredFiles.sort((a, b) {
                        int result;
                        if (a.documentType == null) {
                          result = 1;
                        } else if (b.documentType == null) {
                          result = -1;
                        } else {
                          // Ascending Order
                          result = a.documentType.compareTo(b.documentType);
                        }
                        return result;
                      });
                      if (!sortAscending) {
                        filteredFiles = filteredFiles.reversed.toList();
                      }
                    });
                  },
                  label: Text(
                    'Document Type',
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
                      filteredFiles.sort((a, b) {
                        int result;
                        if (a.uploadedAt == null) {
                          result = 1;
                        } else if (b.uploadedAt == null) {
                          result = -1;
                        } else {
                          // Ascending Order
                          result = a.uploadedAt.compareTo(b.uploadedAt);
                        }
                        return result;
                      });
                      if (!sortAscending) {
                        filteredFiles = filteredFiles.reversed.toList();
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
                      filteredFiles.sort((a, b) {
                        int result;
                        if (a.updatedAt == null) {
                          result = 1;
                        } else if (b.updatedAt == null) {
                          result = -1;
                        } else {
                          // Ascending Order
                          result = a.updatedAt.compareTo(b.updatedAt);
                        }
                        return result;
                      });
                      if (!sortAscending) {
                        filteredFiles = filteredFiles.reversed.toList();
                      }
                    });
                  },
                  label: Text(
                    'Update Time',
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
                      filteredFiles.sort((a, b) {
                        int result;
                        if (a.status == null) {
                          result = 1;
                        } else if (b.status == null) {
                          result = -1;
                        } else {
                          // Ascending Order
                          result = a.status.compareTo(b.status);
                        }
                        return result;
                      });
                      if (!sortAscending) {
                        filteredFiles = filteredFiles.reversed.toList();
                      }
                    });
                  },
                  label: Text(
                    'Status',
                    style: headerTableStyle,
                  ),
                ),
                DataColumn(
                  label: Text(
                    '3rd Party Consent',
                    style: headerTableStyle,
                  ),
                ),
                if (SharedPreferencesService.getUserRole == supplier)
                  DataColumn(
                    label: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Actions',
                        style: headerTableStyle,
                      ),
                    ),
                  ),
              ],
            ),
          )
        else if (filteredFiles != null && filteredFiles.isEmpty)
          Expanded(
            child: Center(
              child: Text("No files available"),
            ),
          )
        else
          Container()
      ],
    );
  }

  // Handle onCliek header menu
  _handleOnClickMenu(String menu) {
    switch (menu) {
      case 'Upload':
        _showUploadDialog();
        break;
      case 'Download':
        _showDownloadDialog();
        break;
      default:
        break;
    }
  }

  _showDownloadDialog() {
    filteredFiles.forEach((element) {
      if (element.isChecked) {
        downloadFile(element.url, element.name);
      }
    });
  }

  bool _isSelected() {
    return filteredFiles != null &&
        filteredFiles.any((element) => element.isChecked);
  }

  _showUploadDialog() async {
    await showDialog(
        barrierColor: Color(0x00ffffff),
        context: context,
        builder: (BuildContext context) {
          return UploadFileDialog(
            onUploadConfirmed: (files, documentType) {
              _uploadFile(files, documentType);
            },
            key: widget.key,
          );
        });
  }

  _showShareSuccessDialog() async {
    await showDialog(
        barrierColor: Color(0x00ffffff),
        context: context,
        builder: (BuildContext context) {
          return SuccessSentDialog(
            contact: documentContactModel,
            fileNm: _fileNmAfterShared,
          );
        });
  }

  // Handle upload file
  _uploadFile(List<FileDocumentModel> files, String documentType) {
    BlocProvider.of<DocumentBloc>(context).add(UploadFilesEvent(
        accessToken: SharedPreferencesService.getAccessToken,
        files: files,
        documentType: documentType,
        shareTo: widget.userId));
  }

  Widget _buildPath(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              widget.onBackPressed();
            },
            child: Text(
              'Document',
              style: leadingPathStyle,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Color(0xffB8B8B8),
            ),
          ),
          Text(
            '${documentContactModel.name ?? documentContactModel.email}',
            style: textPathStyle,
          )
        ],
      ),
    );
  }

  // Handle search engine for files
  _handleSearch(String val) {
    setState(() {
      filteredFiles.clear();
      if (val.isEmpty) {
        filteredFiles.addAll(files);
      } else {
        files.forEach((element) {
          if ((element.name ?? 'Unknown').toLowerCase().contains(val.trim())) {
            filteredFiles.add(element);
          }
        });
      }
    });
  }
}
