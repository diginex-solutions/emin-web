import 'package:business/constants/constants.dart';
import 'package:business/utils/share_pref_service.dart';
import 'package:common/routing/router_delegate.dart';
import 'package:common/ui/components/progressbar_dialog.dart';
import 'package:eminweb/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotFoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    showProgressBar(context, false);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/not_found.png",
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.3,
            right: MediaQuery.of(context).size.width * 0.3,
            child: FlatButton(
              color: Color(0xFF6B92F2),
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              onPressed: () {
                final delegate = Get.find<ApplicationRouterDelegate>();
                if (SharedPreferencesService.getUserRole == brand)
                  delegate.replaceAll(DashboardPageConfig);
                else if (SharedPreferencesService.getUserRole == supplier)
                  delegate.replaceAll(DocumentPageConfig);
                else
                  delegate.replaceAll(LoginPageConfig);
              },
              child: Text(
                "Go Home".toUpperCase(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
