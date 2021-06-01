import 'dart:async';

import 'package:business/bloc/auth/auth_bloc.dart';
import 'package:business/bloc/auth/auth_event.dart';
import 'package:common/constants/initializer_constants.dart';
import 'package:common/localization/appLocalizations.dart';
import 'package:common/routing/routes.dart';
import 'package:common/ui/common_ui.dart';
import 'package:common/ui/validators/validation.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isError = false;
  bool _isPswError = false;
  String _errorText = '';
  String _errorTextPsw = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _accountController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(left: 28.0, right: 28.0, bottom: 56.0),
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: _buildAccountField(),
            ),
            SizedBox(
              height: 18.0,
            ),
            _buildPasswordField(),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
                text: AppLocalizations.of(context).translate('sign_in'),
                icon: 'ic_login.svg',
                cornerRadius: 4,
                height: 46,
                iconStyle: Color(0xffFFFFFF),
                drawablePadding: 6.0,
                fillColor: Color(0xFF0D7EE6),
                textStyle: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffFFFFFF)),
                func: _handleLoginButton),
            SizedBox(
              height: 48,
            ),
            Flexible(
              child: Container(child: _buildForgotPassword()),
              fit: FlexFit.loose,
            ),
          ],
        ),
      ),
    );
  }

  /// Account field input
  Widget _buildAccountField() {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Focus(
            onFocusChange: (isFocus) {
              setState(() {
                if (isFocus) _isError = false;
              });
            },
            child: TextFormField(
              controller: _accountController,
              style: textInputStyle,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12.0),
                  labelText: AppLocalizations.of(context)
                      .translate('login_username_pn_email'),
                  labelStyle: hintStyle,
                  alignLabelWithHint: true,
                  focusedBorder: focusedBorderField,
                  enabledBorder: defaultBorderField),
            ),
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
    );
  }

  /// Password field input
  Widget _buildPasswordField() {
    return Stack(clipBehavior: Clip.none, children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Focus(
          onFocusChange: (isFocus) {
            setState(() {
              if (isFocus) _isPswError = false;
            });
          },
          child: TextFormField(
            controller: _passwordController,
            style: textInputStyle,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12.0),
                labelText: AppLocalizations.of(context).translate('password'),
                labelStyle: hintStyle,
                focusedBorder: defaultBorderField,
                enabledBorder: defaultBorderField),
            obscureText: true,
          ),
        ),
      ),
      Positioned(
          bottom: -12.0,
          left: kElevationSize * 2,
          child: ValidText(
            isVisible: _isPswError,
            validContent: _errorTextPsw,
          )),
    ]);
  }

  /// Forgot password link
  Widget _buildForgotPassword() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pushNamed(context, Routes.forgotPasswordPath);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            AppLocalizations.of(context).translate('forgot_password'),
            style: TextStyle(
                color: Color(0xff646464),
                fontSize: 14.0,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 5.0,
          ),
          SvgPicture.asset(
            'assets/icons/ic_question_mark.svg',
            color: Color(0xff646464),
          )
        ],
      ),
    );
  }

  /// Handle onClick login button
  void _handleLoginButton() {
    setState(() {
      _clearFocusAndElevation();
      _checkValidateAllFields();
    });
    _checkConnection(context);
  }

  Future<void> _checkConnection(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      displaySnackBarMessage(
          context,
          AppLocalizations.of(context).translate('no_connectivity'),
          "ic_offline");
    } else {
      if (!_isError && !_isPswError) {
        BlocProvider.of<AuthBloc>(context).add(GetAuthen(
            userNm: _accountController.text,
            password: _passwordController.text));
      }
    }
  }

  /// Check validate email & password
  void _checkValidateAllFields() {
    _errorText =
        Validation().checkValidEmailField(context, _accountController.text);
    _isError = _errorText != null ? true : false;
    _errorTextPsw =
        Validation().checkValidPasswordLogin(context, _passwordController.text);
    _isPswError = _errorTextPsw != null ? true : false;
  }

  /// Clear focus all fields and elevations
  void _clearFocusAndElevation() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
}
