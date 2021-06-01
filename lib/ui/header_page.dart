import 'package:common/constants/initializer_constants.dart';
import 'package:flutter/material.dart';

class HeaderPage extends StatefulWidget {
  final String hint;
  final onSearch;

  HeaderPage({this.hint, this.onSearch}) : assert(hint != null);

  @override
  _HeaderPageState createState() => _HeaderPageState();
}

class _HeaderPageState extends State<HeaderPage> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: headerBackgroundColor),
        ),
      ),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.search,
            color: Colors.black,
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: (val) {
                widget.onSearch(val.toLowerCase());
              },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 16.0, right: 16.0, bottom: 14.0),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: widget.hint,
                  hintStyle: hintGreyStyle),
            ),
          ),
        ],
      ),
    );
  }
}
