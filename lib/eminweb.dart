import 'package:business/constants/api_constant.dart';
import 'package:business/utils/share_pref_service.dart';
import 'package:common/constants/initializer_constants.dart';
import 'package:common/localization/appLocalizations.dart';
import 'package:common/routing/router_delegate.dart';
import 'package:eminweb/blocs/language/language_bloc.dart';
import 'package:eminweb/blocs/main_bloc/main_bloc.dart';
import 'package:eminweb/routing/back_dispatcher.dart';
import 'package:eminweb/routing/route_parser.dart';
import 'package:eminweb/routing/router_delegate.dart';
import 'package:eminweb/routing/routes.dart';
import 'package:eminweb/ui/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'utility/configure_nonweb.dart'
    if (dart.library.html) 'utility/configure_web.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.instance;

  var url = const String.fromEnvironment("BASE_URL");
  baseUrl = url;

  EasyLoading.instance
    ..indicatorColor = Colors.blueGrey
    ..backgroundColor = Colors.transparent
    ..userInteractions = false
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorWidget = CircularProgressIndicator(
      backgroundColor: Colors.white,
      valueColor: new AlwaysStoppedAnimation(Colors.blueGrey),
    )
    ..textColor = Colors.white
    ..maskType = EasyLoadingMaskType.custom
    ..maskColor = Colors.transparent
    ..dismissOnTap = false;

  configureApp();
  _initialiseUI();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>(
          create: (context) => LanguageBloc(
            LanguageState(locale: Locale('en', 'EN'), localeLanguageJson: null),
          ),
        ),
      ],
      child: EminWebApp(),
    ),
  );
}

_initialiseUI() {
  print("UI initialised");
  px_46 = 46.0;
  kZero = 0.0;
  kElevationSize = 10.0;
  buttonCornerRadius = 4.0;
  textFieldCornerRadius = 4.0;

  borderRadius2 = BorderRadius.circular(2.0);

  dialogBackgroundColor = Color(0xff10369B);
  dialogBackgroundOpacity = 0.6;
  progressBarColor = Color(0xff10369B);

  borderColor = Color(0xffC0CCEC);
  dividerColor = Color(0xffEEF3FF);
  primaryIconColor = Color(0xff0D7EE6);
  secondaryIconColor = Color(0xff10369B);
  tertiaryIconColor = Color(0xff6AC1E7);

  primaryButtonBackground = Color(0xffEEF3FF);
  secondaryButtonBackground = Color(0xff0D7EE6);

  primaryButtonTextStyle = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w600, color: Color(0xff10369B));
  secondaryButtonTextStyle = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.white);

  profileStrengthBackground = Color(0xffEBF1F3);
  lowStrengthColor = Color(0xffEF5350);
  mediumStrengthColor = Color(0xffFFA800);
  highStrengthColor = Color(0xff0D7EE6);
  primarySnackBarColor = Color(0xff10369B);
  maleIconColor = Color(0xff10369B);
  femaleIconColor = Color(0xffEF5350);

  sectionTagColor = Color(0xffEEF3FF);
  textTagColor = Color(0xff6279B6);
  iconTagColor = Color(0xff0D7EE6);

  chipColor = Color(0xffEEF3FF);
  chipTextStyle = TextStyle(
      fontSize: 10.0, fontWeight: FontWeight.w600, color: Color(0xff6279B6));

  dropdownIconColor = Color(0xff10369B);
  otherButtonColor1 = Color(0xffEEF3FF);
  otherIconColor1 = Color(0xff10369B);

  backgroundProgressBar = Color(0xffD1DFFF);

  connectionMenuColor = Color(0xff000000);

  selectedRowColor = Color(0xffEAFFE2);

  bodyText2 = TextStyle(
      fontSize: 13.0, fontWeight: FontWeight.w400, color: Color(0xff00216F));

  defaultBorderField = OutlineInputBorder(
      borderRadius: BorderRadius.circular(textFieldCornerRadius),
      borderSide: BorderSide(color: Color(0xffC0CCEC)));
  focusedBorderField = OutlineInputBorder(
      borderRadius: BorderRadius.circular(textFieldCornerRadius),
      borderSide: BorderSide(color: Color(0xff0D7EE6)));

  hintStyle = TextStyle(
      color: Color(0xffC0CCEC), fontSize: 12.0, fontWeight: FontWeight.w500);

  textFieldTextStyle = TextStyle(
      fontSize: 12.0, fontWeight: FontWeight.w500, color: Color(0xff3259B7));

  headline2 = TextStyle(
      fontSize: 10.0, fontWeight: FontWeight.w600, color: Color(0xff6279B6));

  headline3 = TextStyle(
      fontSize: 10.0, fontWeight: FontWeight.w600, color: Color(0xff6279B6));

  headline4 = TextStyle(
      fontSize: 12.0, fontWeight: FontWeight.w700, color: Color(0xff10369B));

  bodyText1 = TextStyle(
      fontSize: 13.0, fontWeight: FontWeight.w700, color: Color(0xff000000));

  hintTextStyle = TextStyle(
      fontSize: 13.0, fontWeight: FontWeight.w700, color: Color(0xff3A4561));

  bodyText3 = TextStyle(
      fontSize: 12.0, fontWeight: FontWeight.w500, color: Color(0xff6279B6));

  bodyText4 = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w600, color: Color(0xff10369B));

  bodyText5 = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w700, color: Color(0xff10369B));

  tagTextStyle = TextStyle(
      fontSize: 10.0, fontWeight: FontWeight.w700, color: textTagColor);

  bodyText6 = TextStyle(
      fontSize: 13.0, fontWeight: FontWeight.w400, color: Color(0xff000000));

  bodyText7 = TextStyle(
      fontSize: 10.0, fontWeight: FontWeight.w700, color: Color(0xff10369B));

  bodyText8 = TextStyle(
      fontSize: 10.0, fontWeight: FontWeight.w400, color: Color(0xff6279B6));

  hintBasicStyle = TextStyle(
      fontSize: 10.0, fontWeight: FontWeight.w700, color: Color(0xff000000));

  alertMessageTextStyle = TextStyle(
      fontSize: 10.0, fontWeight: FontWeight.w700, color: Color(0xff000000));

  textInputStyle = TextStyle(
      fontSize: 12.0, fontWeight: FontWeight.w700, color: Color(0xff000000));

  textInputStyle2 = TextStyle(
      fontSize: 13.0, fontWeight: FontWeight.w400, color: Color(0xff10369B));

  hintStyle2 = TextStyle(
      fontSize: 10.0, fontWeight: FontWeight.w700, color: Color(0xff9BAED9));

  otherButtonStyle1 = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w600, color: Color(0xff10369B));

  socialMentionStyle = TextStyle(
      fontSize: 13.0, fontWeight: FontWeight.bold, color: Color(0xff0D7EE6));

  socialNormalStyle = TextStyle(
      fontSize: 13.0, fontWeight: FontWeight.w400, color: Color(0xff000000));

  socialBoldStyle = TextStyle(
      fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.black);

  textFieldFilledColor = Color(0xffffffff);

  unselectedVideoTabLabelColor = Color(0xff3A4561);
  selectedVideoTabLabelColor = Color(0xff3259B7);
  videoTabTextStyle = TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
  );
  videoTabStartGradientColor = Color(0xffCCDBFF);
  videoTabSliderColor = Color(0xff10369B);
  videoDetailTextStyle = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w700,
    color: Color(0xff3A4561),
  );
  watchedTextStyle = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w700,
    color: Color(0xff10369B),
  );
  watchedBackgroundColor = Color(0xffEEF3FF);
  watchedIconColor = Color(0xff10369B);

  videoTitleTextStyle = TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    color: Color(0xff000000),
  );

  videoDescriptionTextStyle = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w400,
    color: Color(0xff3A4561),
  );

  videoDividerColor = Color(0xff9BAED9);

  notificationTimeStyle = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w700,
    color: Color(0xff3A4561),
  );

  notificationTitleStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: Color(0xff000000),
  );

  fileNameStyle = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w700,
    color: Color(0xff3A4561),
  );

  notificationApprovedStyle = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w700,
    color: Color(0xff0D7EE6),
  );

  notificationRejectedStyle = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w700,
    color: Color(0xffEF5350),
  );

  notificationWaitingStyle = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w700,
    color: Color(0xff3A4561),
  );

  notificationWaitingIconColor = Color(0xff9BAED9);
  notificationRejectedIconColor = Color(0xffEF5350);
  notificationApprovedIconColor = Color(0xff6AC1E7);

  acceptRejectApprovedColor = Color(0xff0081B9);
  acceptRejectApprovedStyle = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w700,
    color: Color(0xff0081B9),
  );

  socialFeedHeaderStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: Color(0xff3A4561),
  );

  connectionNameStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: Color(0xff000000),
  );
  textFieldIconColor = Color(0xffACACAC);
  connectionEmailStyle = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w500,
    color: Color(0xff646464),
  );
  notificationFileNameBackground = Color(0xffEEF3FF);

  surveyHeader = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.w600,
    color: Color(0xff000000),
  );

  surveySubHeader = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    color: Color(0xff000000),
  );

  surveySmallHeader = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: Color(0xff000000),
  );

  surveyText = TextStyle(
      fontSize: 13.0, fontWeight: FontWeight.w400, color: Color(0xff000000));
  enabledBorderColor = Border.all(color: Color(0xffC0CCEC));
  disabledBorderColor = Border.all(color: Color(0xffe0e0e0));
  disabledColor = Color(0xffe0e0e0);

  profileExperienceLocationText = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    color: Color(0xff6279B6),
  );
  pageTitleStyle = TextStyle(
      fontSize: 32.0, fontWeight: FontWeight.w900, color: Color(0xff000000));

  signOutButtonTextStyle = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w600, color: Color(0xffEF5350));
  signOutButtonBackground = Color(0xffFEEBEE);
  redIconColor = Color(0xffEF5350);
  navigationMenuColor = Color(0xff000000);
  activeSwitchTrackColor = Color(0xff0D7EE6);
  inactiveSwitchTrackColor = Color(0xffC0CCEC);
  activeSwitchThumbColor = Color(0xffFFFFFF);
  inactiveSwitchThumbColor = Color(0xffFFFFFF);

  labelInputStyle = TextStyle(
      fontSize: 12.0, fontWeight: FontWeight.w400, color: Color(0xff000000));

  inputTextStyle = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w500, color: Color(0xff000000));

  sectionTitle = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w600, color: Color(0xff10369B));

  headerSurveyTextStyle = TextStyle(
      fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xff6279B6));

  buttonTextStyle = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.white);

  headerBackgroundColor = Color(0xffD3D3D3);

  hintGreyStyle = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w500, color: Color(0xffB8B8B8));

  menuHorizontalStyle = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w500, color: Color(0xff646464));

  leadingPathStyle = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w600, color: Color(0xffB8B8B8));

  textPathStyle = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w600, color: Color(0xffCC2531));

  headerTableStyle = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w700, color: Color(0xff333333));

  contentTableStyle = TextStyle(
      fontSize: 13.0, fontWeight: FontWeight.w400, color: Color(0xff333434));

  buttonDialogStyle = TextStyle(
      fontSize: 12.0, fontWeight: FontWeight.w600, color: Colors.white);

  titleDialogStyle = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w600, color: Color(0xff333434));

  fileNmDialogStyle = TextStyle(
      fontSize: 12.0, fontWeight: FontWeight.w500, color: Color(0xff3A4561));

  nameStyle = TextStyle(
      fontSize: 12.0, fontWeight: FontWeight.w500, color: Color(0xff3A4561));

  emailStyle = TextStyle(
      fontSize: 10.0, fontWeight: FontWeight.w600, color: Color(0xffB8B8B8));

  subTitleStyle = TextStyle(
      fontSize: 12.0, fontWeight: FontWeight.w400, color: Color(0xff646464));

  inputLblStyle = TextStyle(
      fontSize: 12.0, fontWeight: FontWeight.w500, color: Color(0xff646464));

  inputContentStyle = TextStyle(
      fontSize: 12.0, fontWeight: FontWeight.w500, color: Color(0xff000000));

  recipientStyle = TextStyle(
      fontSize: 12.0, fontWeight: FontWeight.w500, color: Color(0xffB8B8B8));

// Survey Design
  surveyTitleColor = Color(0xff6279B6);
  surveyCheckIconColor = Color(0xff0D7EE6);
  itemBorderColor = Color(0xff0D7EE6);
  itemInvertedBorderColor = Color(0xffEEF3FF);
  surveyItemShadowColor = Color(0xff10369B);
  surveyIconColor = Color(0xff0D7EE6);

// Survey List  Design
  surveyListItemBackgroundColor = Color(0xffEEF3FF);
  surveyListCompletedItemBackgroundColor = Color(0xffFFFFFF);

  surveyListItemTextStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: Color(0xff6279B6),
  );
  surveyListCompletedItemTextStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: Color(0xff10369B),
  );

// Survey Form Design
  surveyNameTextStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: Color(0xff10369B),
  );

  formNameTextStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: Color(0xff10369B),
  );

  controlTitleTextStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: Color(0xff10369B),
  );

  formNameBackgroundColor = Color(0xffEEF3FF);

  paginationTextStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: Color(0xff6279B6),
  );

  progressBarBackground = Color(0xffEEF3FF);
  progressBarFilledColor = Color(0xffFFA800);

  surveyDividerColor = Color(0xffEEF3FF);
  surveyQuestionLabelBackground = Color(0xffE3444E);
  surveyQuestionLabelTextStyle = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w700,
    color: Color(0xffffffff),
  );

  surveyQuestionTextStyle = TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.w600,
    color: Color(0xff000000),
  );

  surveyOptionSelectedBackgroundColor = Color(0xffFFFFFF);
  surveyOptionBackgroundColor = Color(0xffEEF3FF);

  controlBackgroundColor = Color(0xffEEF3FF);
  controlInvertedBackgroundColor = Color(0xffffffff);

  surveyOptionTextStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: Color(0xff6279B6),
  );

  surveyLabelTextStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: Color(0xff10369B),
  );

  surveyFormLabelTextStyle = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: Color(0xff10369B),
  );

  surveyOptionSelectedTextStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: Color(0xff10369B),
  );

  surveyHintTextStyle = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: Color(0xff6279B6),
  );

  surveyTextFieldStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: Color(0xff10369B),
  );

  nextButtonBackground = Color(0xff0D7EE6);
  nextButtonTextStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: Color(0xffffffff),
  );

  previousButtonBackground = Color(0xffEEF3FF);
  previousButtonTextStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: Color(0xff10369B),
  );
  dropdownTextStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: Color(0xff10369B),
  );

  surveySuccessMessageStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: Color(0xff6279B6),
  );

  surveyFooterStyle = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: Color(0xff646464),
  );

// Survey Submit Design
  surveyMenuTextStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: Color(0xff10369B),
  );

  surveyPrimaryButtonBackground = Color(0xff333434);
  surveySecondaryButtonBackground = Colors.white;
  surveySecondaryButtonTextStyle = TextStyle(
      fontSize: 13.0, fontWeight: FontWeight.w600, color: Colors.white);

  surveyPrimaryButtonTextStyle = TextStyle(
      fontSize: 13.0, fontWeight: FontWeight.w600, color: Color(0xffffffff));

  surveyEditTextBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Color(0xffEBF1F3)));

  surveyBorderColor = Color(0xff646464);
  arrowColor = Color(0xff3A4561);
  chartLegendStyle = TextStyle(
      fontSize: 10.0, fontWeight: FontWeight.w500, color: Color(0xff333333));
  privacyDescriptionStyle = TextStyle(
      fontSize: 10.0, fontWeight: FontWeight.w700, color: Color(0xff3A4561));
  settingItemStyle = TextStyle(
      fontSize: 10.0, fontWeight: FontWeight.w700, color: Color(0xff000000));
  checkboxBorderColor = Color(0xff9BAED9);

  migrationPercentageStyle = TextStyle(
      fontSize: 32.0, fontWeight: FontWeight.w900, color: Color(0xff2F61DB));

  migrationCompletedStyle = TextStyle(
      fontSize: 15.0, fontWeight: FontWeight.w500, color: Color(0xff000000));

  averageUserSuppliedTextStyle = TextStyle(
      fontSize: 10.0, fontWeight: FontWeight.w700, color: Color(0xff000000));
  calculatorPriceTextStyle = TextStyle(
      fontSize: 10.0, fontWeight: FontWeight.w700, color: Color(0xff4B7482));
  calculatorDocumentDetailTextStyle = TextStyle(
      fontSize: 10.0, fontWeight: FontWeight.w700, color: Color(0xff3A4561));
  calculatorPriceBackground = Color(0xffEBF1F3);
  disabledMenuIconColor = Color(0xff739AAB);
  enabledMenuIconColor = Color(0xff62B445);
  menuBackgroundColor = Color(0xffDEFFD2);
  filePickerButtonColor = Color(0xff48484A);
  filePickerCancelButtonColor = Color(0xff48484A);
  textInputStyleNormal = TextStyle(
      fontSize: 13.0, fontWeight: FontWeight.w400, color: Color(0xff3A4561));
  enabledBorder = Border.all(color: Color(0xffC0CCEC));
  disabledBorder = Border.all(color: Color(0xffe0e0e0));
  dialogTextFieldFilledColor = Color(0xffFFFFFF);

  checklistPrimaryStatusStyle =
      TextStyle(fontSize: 8.0, fontWeight: FontWeight.w600);

  horizontalDivider = Color(0xffEBF1F3);
  subtitleTextGreen = TextStyle(
      fontSize: 12.0, fontWeight: FontWeight.w400, color: Color(0xff064802));

  headerTitle = TextStyle(
      fontSize: 28.0, fontWeight: FontWeight.w700, color: Color(0xff003C51));
  checklistPercentageStyle = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w600, color: Color(0xff2F61DB));
  cardColor = Color(0xffffffff);

  consentStyle = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w500, color: Color(0xff003C51));

  externalLinkStyle = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w700,
    color: Color(0xff10369B),
    decoration: TextDecoration.underline,
  );
  bottomNavigationBarBackground = Color(0xffffffff);
  tooltipTextStyle = TextStyle(
      fontSize: 13.0, fontWeight: FontWeight.w500, color: Color(0xffACACAC));

  settingBackgroundColor = Color(0xffffffff);
  menuBorderColor = Color(0xffD1DFFF);
  menuItemStyle = TextStyle(
      fontSize: 15.0, fontWeight: FontWeight.w500, color: Color(0xff000000));
  dropdownTextContent = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w500, color: Color(0xff003C51));
  printableAuditBackgroundColor = Color(0xffE8EFFF);
}

class EminWebApp extends StatefulWidget {
  @override
  _EminWebAppState createState() => _EminWebAppState();
}

class _EminWebAppState extends State<EminWebApp> {
  ApplicationRouterDelegate _routerDelegate = EminRouterDelegate();
  EminRouteParser _routeParser = EminRouteParser();
  EminBackButtonDispatcher backButtonDispatcher;

  _EminWebAppState() {
    if (SharedPreferencesService.getAccessToken.isNotEmpty)
      _routerDelegate.setNewRoutePath(DashboardPageConfig);
    else
      _routerDelegate.setNewRoutePath(LoginPageConfig);
    backButtonDispatcher = EminBackButtonDispatcher(_routerDelegate);
    Get.put(_routerDelegate);
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LanguageBloc>(context).add(LanguageLoadStarted());
    return MultiBlocProvider(
      providers: MainBloc.allBlocs(),
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (languageContext, localeState) {
          return MaterialApp.router(
            theme: appThemeData(),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              AppLocalizations.delegate(
                  localeState.localeLanguageJson, ["en", "th", "lo", "km"]),
            ],
            debugShowCheckedModeBanner: false,
            routerDelegate: _routerDelegate,
            routeInformationParser: _routeParser,
            title: 'eMin',
            builder: EasyLoading.init(),
          );
        },
      ),
    );
  }
}
