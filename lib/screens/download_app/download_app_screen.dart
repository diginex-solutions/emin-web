import 'package:common/constants/constant.dart';
import 'package:common/constants/initializer_constants.dart';
import 'package:common/localization/appLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadAppScreen extends StatefulWidget {
  @override
  _DownloadAppScreenState createState() => _DownloadAppScreenState();
}

class _DownloadAppScreenState extends State<DownloadAppScreen> {
  @override
  Widget build(BuildContext context) {
    bool isScreenWide =
        MediaQuery.of(context).size.width >= MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            color: Colors.transparent,
            child: Padding(
              padding: isScreenWide
                  ? const EdgeInsets.symmetric(horizontal: 80.0)
                  : const EdgeInsets.symmetric(
                      horizontal: 4.0,
                    ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 6),
                    child: SvgPicture.asset(
                      'images/ic_logo.svg',
                      height: 32,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context).translate('app_name'),
                            style: pageTitleStyle),
                        Text(
                          AppLocalizations.of(context)
                              .translate('app_subtitle'),
                          style: Theme.of(context).textTheme.headline6,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: isScreenWide
                  ? const EdgeInsets.symmetric(
                      horizontal: 100.0, vertical: 20.0)
                  : const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 20.0),
              child: Material(
                elevation: 10.0,
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                child: Container(
                  padding: EdgeInsets.all(isScreenWide ? 48 : 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  child: isScreenWide ? _getHorizontalUI() : _getVerticalUI(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _getHorizontalUI() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Image.asset(
                'images/ic_home_screen.png',
                alignment: Alignment.topLeft,
                fit: BoxFit.contain,
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (await canLaunch(playStoreUrl)) {
                  await launch(playStoreUrl);
                } else {
                  throw 'Could not launch $playStoreUrl';
                }
              },
              child: SvgPicture.asset(
                'images/ic_play_store.svg',
                alignment: Alignment.topLeft,
              ),
            )
          ],
        ),
        SizedBox(
          width: 64,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Html(
              data: AppLocalizations.of(context).translate('app_description'),
              shrinkWrap: true,
            ),
          ),
        ),
      ],
    );
  }

  _getVerticalUI() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 24,
          ),
          MouseRegion(
            cursor: SystemMouseCursors.text,
            child: GestureDetector(
              onTap: () async {
                if (await canLaunch(playStoreUrl)) {
                  await launch(playStoreUrl);
                } else {
                  throw 'Could not launch $playStoreUrl';
                }
              },
              child: SvgPicture.asset(
                'images/ic_play_store.svg',
                alignment: Alignment.center,
              ),
            ),
          ),
          Image.asset(
            'images/ic_home_screen.png',
            alignment: Alignment.center,
            fit: BoxFit.contain,
          ),
          Container(
            child: Html(
              data: AppLocalizations.of(context).translate('app_description'),
              shrinkWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
