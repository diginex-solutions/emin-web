import 'package:common/constants/constant.dart';
import 'package:common/constants/initializer_constants.dart';
import 'package:eminweb/model/archive/archive_model.dart';
import 'package:eminweb/screens/archive/dialog/view_archive_dialog.dart';
import 'package:eminweb/ui/data_form_title.dart';
import 'package:eminweb/ui/header_page.dart';
import 'package:eminweb/ui/headline_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArchiveScreen extends StatefulWidget {
  @override
  _ArchiveScreenState createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  List<Archive> archives = [];

  @override
  void initState() {
    archives.addAll([
      Archive(
          name: '0001 Isabel Johnson contract.zip',
          uploadTime: '02 Feb 2021  8.00 AM',
          updateTime: '02 Feb 2021  8.00 AM',
          thirdPartyConsent: 'Yes'),
      Archive(
          name: '0002 Isabel Johnson contract.zip',
          uploadTime: '02 Feb 2021  8.00 AM',
          updateTime: '02 Feb 2021  8.00 AM',
          thirdPartyConsent: 'Unknown'),
      Archive(
          name: '0003 Isabel Johnson contract.zip',
          uploadTime: '02 Feb 2021  8.00 AM',
          updateTime: '02 Feb 2021  8.00 AM',
          thirdPartyConsent: 'No'),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * mainSizeBarRatio),
      child: Column(
        children: <Widget>[
          HeaderPage(
            hint: 'Search archive',
          ),
          HeadlineMenu(
            onClickMenu: (val) {
              print('$val');
            },
            listMenu: [
              HeadlineMenuModel(
                  icon: SvgPicture.asset(
                    'assets/icons/ic_download_web.svg',
                    width: 16,
                    height: 16,
                    color: Color(0xff646464),
                  ),
                  isVisible: true,
                  menuTitle: 'Download'),
              HeadlineMenuModel(
                  icon: SvgPicture.asset(
                    'assets/icons/ic_print.svg',
                    width: 16,
                    height: 16,
                    color: Color(0xff646464),
                  ),
                  isVisible: true,
                  menuTitle: 'Print'),
            ],
          ),
          _buildTableTitle(context),
          _buildListData(context),
        ],
      ),
    );
  }

  Widget _buildListData(BuildContext context) => ListView.builder(
      shrinkWrap: true,
      itemCount: archives.length,
      itemBuilder: (context, index) {
        final item = archives[index];
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: <Widget>[
              Divider(
                height: 1.0,
                color: Color(0xffE3E3E3),
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                      value: item.isChecked,
                      onChanged: (val) {
                        setState(() {
                          item.isChecked = val;
                        });
                      }),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/ic_archive.svg',
                            width: 16,
                            height: 16,
                            color: Color(0xff646464),
                          ),
                          SizedBox(
                            width: 12.0,
                          ),
                          Flexible(
                            child: Text(
                              '${item.name}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: contentTableStyle,
                            ),
                          ),
                        ],
                      )),
                  Expanded(
                      flex: 2,
                      child: Text(
                        '${item.uploadTime}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: contentTableStyle,
                      )),
                  Expanded(
                      flex: 2,
                      child: Text(
                        '${item.updateTime}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: contentTableStyle,
                      )),
                  Expanded(
                      flex: 2,
                      child: Text(
                        '${item.thirdPartyConsent}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: contentTableStyle,
                      )),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.remove_red_eye_outlined,
                            size: 16,
                            color: Color(0xff909090),
                          ),
                        ),
                        onTap: () async {
                          await showDialog(
                              barrierColor: Color(0x00ffffff),
                              context: context,
                              builder: (BuildContext context) {
                                return ViewArchiveDialog(
                                  archiveFile: item.name,
                                );
                              });
                        }),
                  ),
                ],
              ),
            ],
          ),
        );
      });

  Widget _buildTableTitle(BuildContext context) => DataFormTitle(
        onSelectedAll: (val) {
          print('$val');
          setState(() {
            archives.forEach((element) {
              element.isChecked = val;
            });
          });
        },
        titles: [
          DataFormTitleModel(
              title: 'Name',
              icon: Icon(
                Icons.swap_vert,
                size: 16.0,
                color: Color(0xff909090),
              ),
              screenPercent: 3),
          DataFormTitleModel(
              title: 'Upload Time',
              icon: Icon(
                Icons.swap_vert,
                size: 16.0,
                color: Color(0xff909090),
              ),
              screenPercent: 2),
          DataFormTitleModel(
              title: 'Update Time',
              icon: Icon(
                Icons.swap_vert,
                size: 16.0,
                color: Color(0xff909090),
              ),
              screenPercent: 2),
          DataFormTitleModel(title: '3rd Party Consent', screenPercent: 2),
          DataFormTitleModel(
              title: 'Actions',
              screenPercent: 1,
              alignment: MainAxisAlignment.center),
        ],
      );
}
