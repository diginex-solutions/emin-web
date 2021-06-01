import 'package:business/constants/constants.dart';
import 'package:business/utils/share_pref_service.dart';
import 'package:common/constants/initializer_constants.dart';
import 'package:common/routing/router_delegate.dart';
import 'package:common/routing/routes.dart';
import 'package:eminweb/nav/navigation_item.dart';
import 'package:eminweb/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavMenu extends StatefulWidget {
  final bool isNarrow;
  final String currentPath;

  NavMenu({this.isNarrow, this.currentPath});

  @override
  _NavMenuState createState() => _NavMenuState();
}

class _NavMenuState extends State<NavMenu> {
  var currentPath = Routes.dashboardPath;

  @override
  void initState() {
    super.initState();
    currentPath = widget.currentPath ?? Routes.dashboardPath;
  }

  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI() {
    var isSupplier = (SharedPreferencesService.getUserRole == supplier);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(vertical: 23.0, horizontal: 27.0),
              child: Image.asset('assets/images/img_emin_web_logo.png')),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                NavItems(
                  isNarrow: widget.isNarrow,
                  title: 'Dashboard',
                  iconData: Icons.dashboard,
                  isActive: currentPath == Routes.dashboardPath,
                  touched: () {
                    final delegate = Get.find<ApplicationRouterDelegate>();
                    delegate.replace(DashboardPageConfig);
                    setState(() {
                      currentPath = Routes.dashboardPath;
                    });
                  },
                ),
                NavItems(
                  isNarrow: widget.isNarrow,
                  title: isSupplier ? 'Document' : 'Archive',
                  iconData: isSupplier ? Icons.file_copy : Icons.compare_arrows,
                  isActive: currentPath == Routes.documentPath ||
                      currentPath == Routes.userDocumentPath,
                  touched: () {
                    final delegate = Get.find<ApplicationRouterDelegate>();
                    delegate.replace(DocumentPageConfig);
                    setState(() {
                      currentPath = Routes.documentPath;
                    });
                  },
                ),
                // NavItems(
                //   isNarrow: widget.isNarrow,
                //   title: 'Action request',
                //   iconData: Icons.compare_arrows,
                //   isActive: currentPath == Routes.actionRequestPath,
                //   touched: () {
                //     final delegate = Get.find<EminRouterDelegate>();
                //     delegate.replace(ActionRequestPageConfig);
                //     setState(() {
                //       currentPath = Routes.actionRequestPath;
                //     });
                //   },
                // ),
                // NavItems(
                //   isNarrow: widget.isNarrow,
                //   title: 'Share with me',
                //   iconData: Icons.folder_shared,
                //   isActive: currentPath == Routes.sharePath,
                //   touched: () {
                //     final delegate = Get.find<EminRouterDelegate>();
                //     delegate.replace(ShareWithMePageConfig);
                //     setState(() {
                //       currentPath = Routes.sharePath;
                //     });
                //   },
                // ),
                // NavItems(
                //   isNarrow: widget.isNarrow,
                //   title: 'Archive',
                //   iconData: Icons.folder,
                //   isActive: currentPath == Routes.archivePath,
                //   touched: () {
                //     final delegate = Get.find<EminRouterDelegate>();
                //     delegate.replace(ArchivePageConfig);
                //     setState(() {
                //       currentPath = Routes.archivePath;
                //     });
                //   },
                // ),
                if (SharedPreferencesService.getUserRole == supplier)
                  NavItems(
                    isNarrow: widget.isNarrow,
                    title: 'Contacts',
                    iconData: Icons.quick_contacts_mail,
                    isActive: currentPath == Routes.contactsPath,
                    touched: () {
                      final delegate = Get.find<ApplicationRouterDelegate>();
                      delegate.replace(ContactPageConfig);
                      print("Called Contact Page Config");
                      setState(() {
                        currentPath = Routes.contactsPath;
                      });
                    },
                  ),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
            child: Text(
              SharedPreferencesService.getFirstName +
                  " " +
                  SharedPreferencesService.getLastName,
              style: surveyLabelTextStyle.copyWith(color: Colors.white),
            ),
          ),
          Divider(
            height: 1,
          ),
          NavItems(
            isNarrow: widget.isNarrow,
            title: 'Logout',
            iconData: Icons.logout,
            isActive: false,
            touched: () async {
              /// Sign out event and remove token
              // Preference
              final delegate = Get.find<ApplicationRouterDelegate>();
              final sharedPrefService = await SharedPreferencesService.instance;
              sharedPrefService.removeAccessToken();
              sharedPrefService.removeReadTutorial();
              sharedPrefService.removeSocialLogin();
              delegate.replaceAll(LoginPageConfig);
            },
          ),
        ],
      ),
    );
  }
}
