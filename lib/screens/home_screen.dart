import 'package:common/routing/routes.dart';
import 'package:eminweb/nav/nav_bar.dart';
import 'package:eminweb/screens/action_request/action_request_screen.dart';
import 'package:eminweb/screens/archive/archive_screen.dart';
import 'package:eminweb/screens/contact/contact_screen.dart';
import 'package:eminweb/screens/document/document_screen.dart';
import 'package:eminweb/screens/share/share_screen.dart';
import 'package:flutter/material.dart';
import 'package:surveyreport/dashboard.dart';

class HomeScreen extends StatefulWidget {
  final String currentPath;
  final String params;

  HomeScreen({this.currentPath, this.params, Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    print("current path is " + widget.currentPath);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          print("On Pop Up Scope");
          return;
        },
        child: _buildUI());
  }

  Widget _buildUI() {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            NavBar(
              currentPath: widget.currentPath,
            ),
            _getTargetWidget(widget.currentPath, widget.params)
          ],
        ),
      ),
    );
  }

  Widget _getTargetWidget(String path, dynamic params) {
    Widget _widgetTarget = DashBoardScreen();
    switch (path) {
      // Document screen
      case Routes.documentPath:
        _widgetTarget = DocumentScreen(
          currentPage: 0,
        );
        break;
      case Routes.userDocumentPath:
        _widgetTarget = DocumentScreen(
          currentPage: 1,
          userId: params,
        );
        break;
      // Action request screen
      case Routes.actionRequestPath:
        _widgetTarget = ActionRequestScreen();
        break;
      // Share screen
      case Routes.sharePath:
        _widgetTarget = ShareScreen();
        break;
      // Archive screen
      case Routes.archivePath:
        _widgetTarget = ArchiveScreen();
        break;
      // Contacts
      case Routes.contactsPath:
        _widgetTarget = ContactScreen();
        break;
      // Dashboard
      case Routes.dashboardPath:
        _widgetTarget = DashBoardScreen();
        break;
    }
    return _widgetTarget;
  }
}
