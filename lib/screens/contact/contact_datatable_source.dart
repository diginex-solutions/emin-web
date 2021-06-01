import 'package:business/bloc/connections/connections_bloc.dart';
import 'package:business/bloc/connections/connections_event.dart';
import 'package:business/constants/api_constant.dart';
import 'package:business/model/connections/connection_model.dart';
import 'package:business/utils/share_pref_service.dart';
import 'package:common/constants/initializer_constants.dart';
import 'package:eminweb/screens/contact/dialog/delete_contact_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactDataTableSource implements DataTableSource {
  final List<ConnectionModel> contacts;
  BuildContext context;

  ContactDataTableSource({this.context, this.contacts});

  @override
  DataRow getRow(int index) {
    if (contacts == null) return DataRow(cells: <DataCell>[]);
    var item = contacts[index];
    return DataRow(
      cells: <DataCell>[
        DataCell(
          Text(
            '${index + 1}',
            style: contentTableStyle,
          ),
        ),
        DataCell(
          Text(
            '${item.name ?? 'Pending Registration'} ${item.surname ?? ''}',
            overflow: TextOverflow.ellipsis,
            style: contentTableStyle,
          ),
        ),
        DataCell(
          Text(
            '${item.email}',
            overflow: TextOverflow.ellipsis,
            style: contentTableStyle,
          ),
        ),
        DataCell(
          Text(
            '${item.phoneNumber ?? ''}',
            overflow: TextOverflow.ellipsis,
            style: contentTableStyle,
          ),
        ),
        DataCell(
          IconButton(
              icon: Icon(Icons.delete),
              tooltip: "Delete Contact",
              onPressed: () async {
                await showDialog(
                    barrierColor: Color(0x00ffffff),
                    context: context,
                    builder: (BuildContext context) {
                      return DeleteContactDialog(
                        contact: item,
                        onDeleteConfirmed: (id) {
                          _deleteContact(context, id);
                        },
                      );
                    });
              }),
        )
      ],
    );
  }

  _deleteContact(BuildContext context, String id) async {
    final sharedPrefService = await SharedPreferencesService.instance;
    if (SharedPreferencesService.getAccessToken.isNotEmpty) {
      BlocProvider.of<ConnectionsBloc>(context).add(DeleteConnectionEvent(
          accessToken: SharedPreferencesService.getAccessToken.toString(),
          connectionId: id,
          spaceId: sharedPrefService.getSpaceId,
          origin: Origin));
      Navigator.pop(context);
    }
  }

  bool get isRowCountApproximate => false;

  @override
  void notifyListeners() {}

  @override
  void removeListener(listener) {}

  @override
  int get rowCount => contacts == null ? 0 : contacts.length;

  @override
  int get selectedRowCount => 0;

  @override
  void addListener(listener) {}

  @override
  void dispose() {}

  @override
  bool get hasListeners => false;
}
