import 'package:common/constants/constant.dart';
import 'package:flutter/material.dart';

class NavItems extends StatefulWidget {
  final IconData iconData;
  final Function touched;
  final bool isActive;
  final String title;
  final bool isNarrow;

  NavItems(
      {this.iconData, this.touched, this.isActive, this.title, this.isNarrow});

  @override
  _NavItemsState createState() => _NavItemsState();
}

class _NavItemsState extends State<NavItems> {
  @override
  Widget build(BuildContext context) {
    return _buildUI(context);
  }

  Widget _buildUI(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          print(widget.iconData);
          widget.touched();
        },
        child: Container(
          color: widget.isActive ? Colors.black : Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            children: [
              Container(
                height: 56.0,
                width: MediaQuery.of(context).size.width * mainSizeBarRatio,
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 475),
                      height: 35.0,
                      width: 5.0,
                      decoration: BoxDecoration(
                        color:
                            widget.isActive ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Icon(
                        widget.iconData,
                        color: widget.isActive ? Colors.white : Colors.white54,
                        size: 16.0,
                      ),
                    ),
                    !widget.isNarrow
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              widget.title ?? '',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: widget.isActive
                                    ? Colors.white
                                    : Colors.white54,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        : Container(
                            width: 0,
                            height: 0,
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
