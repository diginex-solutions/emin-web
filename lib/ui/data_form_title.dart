import 'package:common/constants/initializer_constants.dart';
import 'package:flutter/material.dart';

class DataFormTitle extends StatefulWidget {
  final List<DataFormTitleModel> titles;
  final Function(bool isAll) onSelectedAll;
  final bool isDisplaySelect;

  DataFormTitle(
      {this.titles, this.onSelectedAll(bool), this.isDisplaySelect = false});

  @override
  _DataFormTitleState createState() => _DataFormTitleState();
}

class _DataFormTitleState extends State<DataFormTitle> {
  bool isCheckAll = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 32, right: 32, top: 23.0),
      child: Row(
        children: [
          Visibility(
            visible: widget.isDisplaySelect,
            child: Container(
              margin: EdgeInsets.only(right: 20),
              child: Checkbox(
                  value: isCheckAll,
                  onChanged: (val) {
                    setState(() => isCheckAll = val);
                    widget.onSelectedAll(val);
                  }),
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                children: widget.titles
                    .map((formTitle) => Expanded(
                        flex: formTitle.screenPercent,
                        child: GestureDetector(
                          onTap: () => formTitle.callback(formTitle.title),
                          child: Row(
                            mainAxisAlignment:
                                formTitle.alignment ?? MainAxisAlignment.start,
                            children: [
                              Text('${formTitle.title}',
                                  style: headerTableStyle),
                              SizedBox(width: formTitle.drawablePadding ?? 0.0),
                              formTitle.icon ??
                                  Container(
                                    width: 0,
                                    height: 0,
                                  ),
                            ],
                          ),
                        )))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

typedef void MyCallback(String sortName);

class DataFormTitleModel {
  MyCallback callback;
  String title;
  Widget icon;
  int screenPercent;
  double drawablePadding;
  MainAxisAlignment alignment;

  DataFormTitleModel(
      {this.title,
      this.callback,
      this.icon,
      this.screenPercent,
      this.drawablePadding,
      this.alignment});
}
