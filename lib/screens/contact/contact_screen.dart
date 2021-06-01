import 'package:business/bloc/connections/connections_bloc.dart';
import 'package:business/bloc/connections/connections_event.dart';
import 'package:business/bloc/connections/connections_state.dart';
import 'package:business/constants/api_constant.dart';
import 'package:business/model/connections/connection_model.dart';
import 'package:business/utils/share_pref_service.dart';
import 'package:common/constants/constant.dart';
import 'package:common/constants/initializer_constants.dart';
import 'package:common/ui/common_ui.dart';
import 'package:common/ui/components/alert_dialog_single.dart';
import 'package:common/ui/components/paginate_data_table.dart';
import 'package:common/ui/components/progressbar_dialog.dart';
import 'package:eminweb/screens/contact/contact_datatable_source.dart';
import 'package:eminweb/screens/contact/dialog/add_contact_dialog.dart';
import 'package:eminweb/ui/header_page.dart';
import 'package:eminweb/ui/headline_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<ConnectionModel> filteredConnections;
  bool _sortAsc = true;
  int _sortColumnIndex;

  @override
  void initState() {
    fetchConnections();
    super.initState();
  }

  fetchConnections() async {
    BlocProvider.of<ConnectionsBloc>(context).add(GetConnectionsEvent(
        isRefresh: false,
        accessToken: SharedPreferencesService.getAccessToken.toString(),
        origin: Origin));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectionsBloc, ConnectionsState>(
      builder: (context, state) {
        return _buildUI(context);
      },
      listener: (context, state) {
        if (state is ConnectionLoading) {
          showProgressBar(context, true);
        } else if (state is ConnectionDeleteSuccess) {
          showProgressBar(context, false);
          filteredConnections = state.connections;
          var message =
              'Contact %s deleted'.replaceAll('%s', state.connectionName);
          displaySnackBarMessage(context, message, 'ic_menu_delete');
        } else if (state is ConnectionAddSuccess) {
          showProgressBar(context, false);
          fetchConnections();
          showAlertDialog(
              context,
              'Add Contact',
              state.isExistingUser
                  ? 'Contact added successfully'
                  : 'Invitation has been sent', () {
            Navigator.pop(context);
          });
        } else if (state is ConnectionsLoadSuccess) {
          showProgressBar(context, false);
          filteredConnections = state.connections;
        } else if (state is ConnectionsError) {
          showProgressBar(context, false);
          showAlertDialog(
              context, 'Error', state.message, () => Navigator.pop(context));
        }
      },
      buildWhen: (previousState, currentState) {
        return currentState is ConnectionDeleteSuccess ||
            currentState is ConnectionAddSuccess ||
            currentState is ConnectionsLoadSuccess;
      },
    );
  }

  Widget _buildUI(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * mainSizeBarRatio),
      child: Column(
        children: <Widget>[
          HeaderPage(
            hint: 'Search Contacts',
            onSearch: _handleSearch,
          ),
          HeadlineMenu(
            listMenu: [
              HeadlineMenuModel(
                  menuTitle: 'New contact',
                  isVisible: true,
                  icon: SvgPicture.asset(
                    'assets/icons/ic_contact_web.svg',
                    width: 16,
                    height: 16,
                    color: Color(0xff646464),
                  ))
            ],
            onClickMenu: (val) async {
              await showDialog(
                  barrierColor: Color(0x00ffffff),
                  context: context,
                  builder: (BuildContext context) {
                    return AddContactDialog(
                      contactList: filteredConnections,
                      onCallBack: (email, isExistingUser) {
                        _addContact(email, isExistingUser);
                      },
                    );
                  });
            },
          ),
          if (filteredConnections != null && filteredConnections.isNotEmpty)
            Expanded(
              child: TrustCorePaginatedDataTable(
                source: ContactDataTableSource(
                    context: context, contacts: filteredConnections),
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
                        filteredConnections.sort((a, b) {
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
                          filteredConnections =
                              filteredConnections.reversed.toList();
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
                        filteredConnections.sort((a, b) {
                          int result;
                          if (a.email == null) {
                            result = 1;
                          } else if (b.email == null) {
                            result = -1;
                          } else {
                            // Ascending Order
                            result = a.email.compareTo(b.email);
                          }
                          return result;
                        });
                        if (!sortAscending) {
                          filteredConnections =
                              filteredConnections.reversed.toList();
                        }
                      });
                    },
                    label: Text(
                      'Email',
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
                        filteredConnections.sort((a, b) {
                          int result;
                          if (a.phoneNumber == null) {
                            result = 1;
                          } else if (b.phoneNumber == null) {
                            result = -1;
                          } else {
                            // Ascending Order
                            result = a.phoneNumber.compareTo(b.phoneNumber);
                          }
                          return result;
                        });
                        if (!sortAscending) {
                          filteredConnections =
                              filteredConnections.reversed.toList();
                        }
                      });
                    },
                    label: Text(
                      'Phone Number',
                      style: headerTableStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Actions',
                      style: headerTableStyle,
                    ),
                  ),
                ],
              ),
            )
          else if (filteredConnections != null && filteredConnections.isEmpty)
            Expanded(
              child: Center(
                child: Text("No contacts available"),
              ),
            )
          else
            Container(),
        ],
      ),
    );
  }

  _handleSearch(String value) {
    BlocProvider.of<ConnectionsBloc>(context)
        .add(FilterConnectionsEvent(searchText: value));
  }

  _addContact(String email, bool isExistingUser) async {
    SharedPreferencesService pref = await SharedPreferencesService.instance;
    BlocProvider.of<ConnectionsBloc>(context).add(AddConnectionEvent(
        accessToken: SharedPreferencesService.getAccessToken.toString(),
        origin: Origin,
        spaceId: pref.getSpaceId,
        emailAddress: email,
        isExistingUser: isExistingUser));
  }
}
