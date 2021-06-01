import 'package:common/constants/constant.dart';
import 'package:common/routing/router_delegate.dart';
import 'package:eminweb/routing/routes.dart';
import 'package:eminweb/screens/document/file_list_screen.dart';
import 'package:eminweb/screens/document/folder_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DocumentScreen extends StatefulWidget {
  final int currentPage;
  final String userId;

  DocumentScreen({this.currentPage, this.userId, Key key}) : super(key: key);

  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * mainSizeBarRatio),
        child: _buildPageView());
  }

// Build page view
  Widget _buildPageView() {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (index == 0)
          return FolderListScreen(
            onFolderSelected: (args) {
              final delegate = Get.find<ApplicationRouterDelegate>();
              delegate.replace(userDocumentPageConfig(args));
            },
          );
        else
          return FileListScreen(
              userId: widget.userId,
              onBackPressed: () {
                final delegate = Get.find<ApplicationRouterDelegate>();
                delegate.replace(DocumentPageConfig);
              });
      },
      itemCount: 2,
    );
  }
}
