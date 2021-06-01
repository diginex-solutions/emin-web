import 'dart:ui';

import 'package:business/bloc/connections/connections_bloc.dart';
import 'package:business/bloc/connections/connections_event.dart';
import 'package:business/bloc/connections/connections_state.dart';
import 'package:business/constants/api_constant.dart';
import 'package:business/model/connections/connection_model.dart';
import 'package:business/utils/share_pref_service.dart';
import 'package:common/constants/initializer_constants.dart';
import 'package:common/ui/validators/validation.dart';
import 'package:eminweb/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddContactDialog extends StatefulWidget {
  final bool isEditMode;
  final Contact contact;
  final List<ConnectionModel> contactList;
  final Function(String email, bool isExistingUser) onCallBack;

  AddContactDialog(
      {this.isEditMode = false,
      this.contactList,
      this.contact,
      this.onCallBack(email, isExistingUser)});

  @override
  _AddContactDialogState createState() => _AddContactDialogState();
}

class _AddContactDialogState extends State<AddContactDialog> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _firstNmController = TextEditingController();
  TextEditingController _lastNmController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';

  @override
  void initState() {
    _getUserEmail();
    if (widget.contact != null) {
      _emailController.text = widget.contact.email;
      _firstNmController.text = widget.contact.firstName;
      _lastNmController.text = widget.contact.lastName;
      _phoneController.text = widget.contact.phoneNumber;
      _countryController.text = widget.contact.country;
    }

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNmController.dispose();
    _lastNmController.dispose();
    _phoneController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  _fetchUserByEmail(String email) async {
    BlocProvider.of<ConnectionsBloc>(context).add(GetContactByEmailEvent(
        accessToken: SharedPreferencesService.getAccessToken.toString(),
        origin: Origin,
        email: email));
  }

  _getUserEmail() async {
    final sharedPrefService = await SharedPreferencesService.instance;
    setState(() {
      _userEmail = sharedPrefService.getUserEmail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectionsBloc, ConnectionsState>(
      listener: (context, state) {
        if (state is ContactLoaded) {
          _firstNmController.text = state.connections.name;
          _lastNmController.text = state.connections.surname;
          _phoneController.text = state.connections.phoneNumber;
        } else if (state is ContactError) {
          _firstNmController.text = "";
          _lastNmController.text = "";
          _phoneController.text = "";
        }
      },
      builder: (context, state) {
        return _buildUI(context);
      },
    );
  }

  Widget _buildUI(BuildContext context) {
    return new BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.25),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        backgroundColor: Color(0xff000000).withOpacity(0.3),
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    widget.isEditMode ? 'Editing contact' : 'Add new contact',
                    style: titleDialogStyle,
                  ),
                  Spacer(),
                  IconButton(
                      icon:
                          Icon(Icons.close, size: 16, color: Color(0xff111111)),
                      onPressed: () => Navigator.pop(context))
                ],
              ),
              TextFormField(
                validator: (value) => _checkValidateAllFields(value),
                controller: _emailController,
                onChanged: (val) {
                  var isValid = _formKey.currentState.validate();
                  if (isValid) _fetchUserByEmail(val);
                },
                style: inputContentStyle,
                decoration: InputDecoration(
                    labelText: 'Email', labelStyle: inputLblStyle),
              ),
              Opacity(
                opacity: 0.4,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          enabled: false,
                          controller: _firstNmController,
                          style: inputContentStyle,
                          decoration: InputDecoration(
                              labelText: 'First name',
                              labelStyle: inputLblStyle),
                        ),
                      ),
                      SizedBox(
                        width: 21,
                      ),
                      Expanded(
                        child: TextFormField(
                          enabled: false,
                          controller: _lastNmController,
                          style: inputContentStyle,
                          decoration: InputDecoration(
                              labelText: 'Last name',
                              labelStyle: inputLblStyle),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Opacity(
                opacity: 0.4,
                child: TextFormField(
                  enabled: false,
                  controller: _phoneController,
                  style: inputContentStyle,
                  decoration: InputDecoration(
                      labelText: 'Phone number', labelStyle: inputLblStyle),
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
                    onTap: () async {
                      _clearFocusAndElevation();
                      if (_formKey.currentState.validate()) {
                        widget.onCallBack(_emailController.text,
                            _firstNmController.text != null);
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xffA82E25),
                          borderRadius: BorderRadius.all(Radius.circular(4.0))),
                      padding: EdgeInsets.only(
                          left: 15.0, right: 15, top: 13, bottom: 9),
                      child: Text('SAVE', style: buttonDialogStyle),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  bool checkExistingConnection() {
    if (widget.contactList == null) return false;
    var existingConnection = widget.contactList.firstWhere(
        (element) => element.email == _emailController.text,
        orElse: () => null);
    return existingConnection != null;
  }

  /// Check validate email & password
  String _checkValidateAllFields(String email) {
    if (checkExistingConnection()) {
      return 'User with this email already exists';
    } else if (_userEmail != null && _userEmail != '' && email == _userEmail) {
      return 'You can not add yourself. Please try different email';
    } else {
      return Validation().checkValidEmailField(context, email);
    }
  }

  /// Clear focus all fields and elevations
  void _clearFocusAndElevation() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
}
