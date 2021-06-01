import 'package:business/bloc/auth/reset_password/reset_psw_bloc.dart';
import 'package:business/bloc/auth/reset_password/reset_psw_event.dart';
import 'package:business/bloc/auth/reset_password/reset_psw_state.dart';
import 'package:common/localization/appLocalizations.dart';
import 'package:common/ui/common_ui.dart';
import 'package:common/ui/components/alert_dialog_single.dart';
import 'package:common/ui/components/progressbar_dialog.dart';
import 'package:common/ui/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String token;

  const ResetPasswordScreen({this.token});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _pswController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _pswController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print('Token: ${widget.token}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<ResetBloc, ResetState>(
          builder: (context, state) {
            return _buildUI(context);
          },
          listener: (context, state) {
            if (state is ResetLoading) {
              showProgressBar(context, true);
            } else if (state is ResetLoaded) {
              showProgressBar(context, false);
              showAlertDialog(
                  context,
                  'Success',
                  'Reset password success! Please re-login',
                  () => Navigator.pop(context));
            } else if (state is ResetError) {
              showProgressBar(context, false);
              showAlertDialog(context, 'error', state.message,
                  () => Navigator.pop(context));
            }
          },
        ));
  }

  Widget _buildUI(BuildContext context) {
    bool isScreenWide =
        MediaQuery.of(context).size.width >= MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            color: Colors.transparent,
            child: Padding(
              padding: isScreenWide
                  ? const EdgeInsets.symmetric(horizontal: 80.0)
                  : const EdgeInsets.symmetric(
                      horizontal: 4.0,
                    ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 6),
                    child: SvgPicture.asset(
                      'images/ic_logo.svg',
                      height: 32,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context).translate('app_name'),
                            style: Theme.of(context).textTheme.headline1),
                        Text(
                          AppLocalizations.of(context)
                              .translate('app_subtitle'),
                          style: Theme.of(context).textTheme.headline6,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: isScreenWide
                ? const EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0)
                : const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Material(
              elevation: 10.0,
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              child: Container(
                padding: EdgeInsets.all(isScreenWide ? 48 : 24),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                child: isScreenWide ? _getHorizontalUI() : _getVerticalUI(),
              ),
            ),
          )
        ],
      ),
    );
  }

  _getHorizontalUI() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Please update your new password',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 16.0),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFieldCommon(
                controller: _pswController,
                label: 'New Password',
                obscureText: true,
                validator: (value) =>
                    Validation().checkValidPassword(context, value),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFieldCommon(
                controller: _confirmController,
                label: 'Confirm New Password',
                obscureText: true,
                validator: (value) => Validation().checkValidConfirmPassword(
                    context, _pswController.text, value),
              ),
              SizedBox(
                height: 16.0,
              ),
              _buildButton(context)
            ],
          ),
        ),
      ),
    );
  }

  _getVerticalUI() {
    return Center(
      child: Container(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Please update your new password',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 16.0),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFieldCommon(
                controller: _pswController,
                label: 'New Password',
                obscureText: true,
                validator: (value) =>
                    Validation().checkValidPassword(context, value),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFieldCommon(
                controller: _confirmController,
                label: 'Confirm New Password',
                obscureText: true,
                validator: (value) => Validation().checkValidConfirmPassword(
                    context, _pswController.text, value),
              ),
              SizedBox(
                height: 16.0,
              ),
              _buildButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return FlatButton(
      padding: const EdgeInsets.symmetric(vertical: 13.5, horizontal: 10),
      color: Color(0xff2F61DB),
      height: 60.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      onPressed: () => _resetPswEvent(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text('Reset Password',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16.0)),
          ),
        ],
      ),
    );
  }

  void _resetPswEvent(BuildContext context) {
    // Clear focus all fields
    FocusScope.of(context).requestFocus(new FocusNode());
    // Preferrence
    if (_formKey.currentState.validate()) {
      // displaySnackBarMessage(context, widget.token);

      if (widget.token == null || widget.token.isEmpty) {
        showAlertDialog(
            context,
            'Error',
            'Can not reset password right now. Please try again later.',
            () => Navigator.pop(context));
        return;
      }
      BlocProvider.of<ResetBloc>(context).add(ResetPasswordEvent(
          token: widget.token, map: {'password': _pswController.text}));
    }
  }
}
