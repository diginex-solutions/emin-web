import 'package:common/constants/initializer_constants.dart';
import 'package:flutter/material.dart';

class HeadlineMenu extends StatefulWidget {
  final void Function(String item) onClickMenu;
  final List<HeadlineMenuModel> listMenu;

  HeadlineMenu(
      {@required this.onClickMenu(String menu), @required this.listMenu});

  @override
  _HeadlineMenuState createState() => _HeadlineMenuState();
}

class _HeadlineMenuState extends State<HeadlineMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      color: headerBackgroundColor,
      child: Row(
        children: widget.listMenu
            .map((e) => _mainMenu(context, e.menuTitle, e.icon, e.isVisible))
            .toList(),
      ),
    );
  }

  Widget _mainMenu(
      BuildContext context, String title, Widget icon, bool isVisible) {
    return Visibility(
      visible: isVisible,
      child: InkWell(
        onTap: () => widget.onClickMenu(title),
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 24),
          child: Row(
            children: <Widget>[
              icon,
              SizedBox(
                width: 16.0,
              ),
              Text(
                '$title',
                style: menuHorizontalStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HeadlineMenuModel {
  String menuTitle;
  Widget icon;
  bool isVisible = true;

  HeadlineMenuModel({this.menuTitle, this.icon, this.isVisible});
}
