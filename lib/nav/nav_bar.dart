import 'package:common/constants/constant.dart';
import 'package:eminweb/nav/nav_menu.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  final String currentPath;

  NavBar({this.currentPath});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      if (constraint.maxWidth > 1200) {
        return Container(
          color: Color(0xff333434),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * mainSizeBarRatio,
          child: NavMenu(
            isNarrow: false,
            currentPath: widget.currentPath,
          ),
        );
      } else {
        return Container(
          color: Color(0xff333434),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.15,
          child: NavMenu(
            isNarrow: true,
            currentPath: widget.currentPath,
          ),
        );
      }
    });
  }
}
