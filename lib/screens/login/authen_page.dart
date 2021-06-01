import 'package:business/bloc/auth/auth_bloc.dart';
import 'package:business/bloc/auth/auth_state.dart';
import 'package:business/constants/constants.dart';
import 'package:business/utils/share_pref_service.dart';
import 'package:common/localization/appLocalizations.dart';
import 'package:common/routing/router_delegate.dart';
import 'package:common/ui/components/alert_dialog_single.dart';
import 'package:common/ui/components/progressbar_dialog.dart';
import 'package:eminweb/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'login.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoginActive = false;
  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    _isLoginActive = true;
    super.initState();
    showProgressBar(context, false);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _setTabActivation(bool isActive) {
    setState(() {
      _isLoginActive = isActive;
    });
  }

  void _swipePage(int page) {
    setState(() {
      _pageController.animateToPage(page,
          duration: Duration(milliseconds: 400), curve: Curves.easeIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    final delegate = Get.find<ApplicationRouterDelegate>();
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthenState>(
          listener: (context, state) async {
            if (state is AuthLoaded) {
              showProgressBar(context, false);
              var role = SharedPreferencesService.getUserRole;
              if (role == brand)
                delegate.replaceAll(DashboardPageConfig);
              else if (role == supplier)
                delegate.replaceAll(DocumentPageConfig);
              else {
                final sharedPrefService =
                    await SharedPreferencesService.instance;
                sharedPrefService.removeAccessToken();
                showAlertDialog(context, 'Error', "Do not have access",
                    () => Navigator.pop(context));
              }
            } else if (state is AuthenLoading) {
              showProgressBar(context, true);
            } else if (state is AuthError) {
              showProgressBar(context, false);
              _handleErrorPopup(state.message, context);
            }
          },
          builder: (context, state) {
            return _buildAuthenPage();
          },
          buildWhen: (previousState, currentState) {
            return false;
          },
        ),
      ),
    );
  }

  _handleErrorPopup(String msg, BuildContext _context) {
    String _message;
    String _title;
    if (msg.contains('Incorrect')) {
      _title = AppLocalizations.of(context).translate('incorrect_password');
      _message =
          AppLocalizations.of(context).translate('wrong_account_password');
    } else {
      _message = msg;
    }
    showAlertDialog(
        _context,
        _title ?? AppLocalizations.of(context).translate('error'),
        _message,
        () => Navigator.pop(context));
  }

  Widget _buildAuthenPage() {
    return Container(
      alignment: Alignment.center,
      child: Card(
        elevation: 10,
        margin: const EdgeInsets.all(24.0),
        child: Container(
          width: 600,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 36.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0),
                child: SvgPicture.asset(
                  'assets/icons/ic_logo.svg',
                ),
              ),
              SizedBox(
                height: 28.0,
              ),
              _buildTabText(),
              Expanded(child: _buildPageView()),
            ],
          ),
        ),
      ),
    );
  }

  // Build page view
  Widget _buildPageView() {
    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: PageView(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        onPageChanged: (index) => {
          if (index == 0)
            {_setTabActivation(true)}
          else
            {_setTabActivation(false)}
        },
        children: <Widget>[LoginScreen()],
      ),
    );
  }

  /// Build header tab
  Widget _buildTabText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _setTabActivation(true);
              _swipePage(0);
            },
            child: Text(
              AppLocalizations.of(context).translate('log_in'),
              style: TextStyle(
                  fontSize: 36.0,
                  fontWeight:
                      _isLoginActive ? FontWeight.w500 : FontWeight.normal),
            )),
      ],
    );
  }
}
