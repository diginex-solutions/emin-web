import 'package:business/bloc/auth/reset_password/reset_psw_bloc.dart';
import 'package:business/bloc/auth/reset_password/reset_psw_event.dart';
import 'package:business/bloc/auth/reset_password/reset_psw_state.dart';
import 'package:common/constants/initializer_constants.dart';
import 'package:common/localization/appLocalizations.dart';
import 'package:common/ui/common_ui.dart';
import 'package:common/ui/components//progressbar_dialog.dart';
import 'package:common/ui/components/alert_dialog_single.dart';
import 'package:common/ui/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();
  bool _isError = false;
  bool _isPswError = false;
  String _errorText = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ResetBloc, ResetState>(
          builder: (context, state) {
            if (state is ResetLoading) {}
            return _buildForgotPasswordLayout();
          },
          listener: (context, state) {
            if (state is ResetLoaded) {
              Navigator.pop(context);
              _showAlertDialog(
                  context,
                  AppLocalizations.of(context)
                      .translate('reset_password_message'));
            } else if (state is ResetLoading) {
              _showProgressBar(context, true);
              // Center(child: CircularProgressIndicator(backgroundColor: Colors.red));
            } else if (state is ResetError) {
              _showProgressBar(context, false);
              _showAlertDialog(context, state.message);
            }
          },
          buildWhen: (previousState, currentState) {
            return true;
          },
        ),
      ),
    );
  }

  // show alert dialog
  void _showAlertDialog(BuildContext context, String msg) async {
    await showDialog(
        context: context,
        barrierColor: Color(0x00ffffff),
        builder: (BuildContext context) {
          return AlertDialogSingle(
              title: '',
              message: msg,
              func: () {
                Navigator.of(context).pop();
              });
        });
  }

  // show alert dialog
  void _showProgressBar(BuildContext context, bool isDisplay) async {
    await showDialog(
        context: context,
        barrierColor: Color(0x00ffffff),
        builder: (BuildContext context) {
          return CustomProgressBar();
        });
  }

  Widget _buildForgotPasswordLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 36.0),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(
              'assets/icons/ic_back.svg',
              color: navigationMenuColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 17.0, bottom: 37.0),
            child: Text(
              AppLocalizations.of(context).translate('reset_password'),
              style: pageTitleStyle,
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Focus(
                onFocusChange: (isFocus) {
                  setState(() {
                    if (isFocus) _isError = false;
                  });
                },
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      Validation().checkValidEmailField(context, value),
                  style: textInputStyle,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12.0),
                      labelText: AppLocalizations.of(context)
                          .translate('login_username_pn_email'),
                      labelStyle: hintStyle,
                      focusedBorder: focusedBorderField,
                      enabledBorder: defaultBorderField),
                ),
              ),
              Positioned(
                bottom: -12.0,
                left: kElevationSize * 2,
                child: ValidText(
                  isVisible: _isError,
                  validContent: _errorText,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          RoundedButton(
              text: AppLocalizations.of(context).translate('reset_password'),
              fillColor: primaryButtonBackground,
              textStyle: primaryButtonTextStyle,
              func: () => _handleResetPassword()),
        ],
      ),
    );
  }

  void _handleResetPassword() {
    setState(() {
      _clearFocusAndElevation();
      _checkValidateAllFields();
      if (!_isError && !_isPswError) {
        BlocProvider.of<ResetBloc>(context)
            .add(RequestResetPassword(map: {'email': _emailController.text}));
      }
    });
  }

  /// Check validate email & password
  void _checkValidateAllFields() {
    _errorText =
        Validation().checkValidEmailField(context, _emailController.text);
    _isError = _errorText != null ? true : false;
  }

  /// Clear focus all fields and elevations
  void _clearFocusAndElevation() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
}
