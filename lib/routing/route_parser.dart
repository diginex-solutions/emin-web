import 'package:business/constants/constants.dart';
import 'package:business/utils/share_pref_service.dart';
import 'package:common/routing/page_configuration.dart';
import 'package:common/routing/pages_dart.dart';
import 'package:common/routing/routes.dart';
import 'package:eminweb/routing/routes.dart';
import 'package:flutter/material.dart';

class EminRouteParser extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    print("parse route info called");

    final uri = Uri.parse(routeInformation.location);
    var path = uri.pathSegments[0];

    if (!path.contains('/')) path = "/" + path;

    var userRole = SharedPreferencesService.getUserRole;
    if ((userRole == null || userRole.isEmpty) &&
        (path != Routes.authPath &&
            path != Routes.downloadAppPath &&
            path != Routes.resetPasswordPath)) return NotFoundConfig;

    if (SharedPreferencesService.getAccessToken.isEmpty &&
        (path != Routes.downloadAppPath && path != Routes.resetPasswordPath)) {
      return LoginPageConfig;
    } else if (SharedPreferencesService.getAccessToken.isNotEmpty &&
        routeInformation.location == Routes.authPath) {
      if (userRole == brand)
        return DashboardPageConfig;
      else if (userRole == supplier) return DocumentPageConfig;
    }

    if (uri.pathSegments.isEmpty) {
      if (SharedPreferencesService.getAccessToken.isEmpty)
        return LoginPageConfig;
      else {
        if (userRole == brand)
          return DashboardPageConfig;
        else if (userRole == supplier) return DocumentPageConfig;
      }
    }

    switch (path) {
      case Routes.authPath:
        return LoginPageConfig;
        break;
      case Routes.downloadAppPath:
        return DownloadAppConfig;
        break;

      case Routes.dashboardPath:
        return DashboardPageConfig;
        break;
      case Routes.contactsPath:
        if (userRole == supplier)
          return ContactPageConfig;
        else
          return NotFoundConfig;
        break;
      case Routes.archivePath:
        return ArchivePageConfig;
      case Routes.sharePath:
        return ShareWithMePageConfig;
      case Routes.actionRequestPath:
        return ActionRequestPageConfig;
      case Routes.documentPath:
        return DocumentPageConfig;
      case Routes.userDocumentPath:
        if (uri.pathSegments == null ||
            uri.pathSegments.isEmpty ||
            uri.pathSegments.length == 1) return NotFoundConfig;
        return userDocumentPageConfig(uri.pathSegments[1]);
        break;

      case Routes.resetPasswordPath:
        if (uri.pathSegments == null ||
            uri.pathSegments.isEmpty ||
            uri.pathSegments.length == 1) return NotFoundConfig;
        return resetPasswordPageConfig(uri.pathSegments[1]);
        break;

      case Routes.surveyBuilderPath:
        if (userRole == supplier) {
          if (uri.pathSegments == null ||
              uri.pathSegments.isEmpty ||
              uri.pathSegments.length == 1) return NotFoundConfig;
          return surveyBuilderPageConfig(uri.pathSegments[1]);
        } else
          return NotFoundConfig;
        break;
      case Routes.notFoundPath:
        return DashboardPageConfig;
        break;
      default:
        return NotFoundConfig;
    }
  }

  @override
  RouteInformation restoreRouteInformation(PageConfiguration configuration) {
    print("restore route info called");
    var userRole = SharedPreferencesService.getUserRole;

    if (configuration.uiPage == Pages.Login &&
        SharedPreferencesService.getAccessToken.isNotEmpty) {
      if (userRole == brand)
        return const RouteInformation(location: Routes.dashboardPath);
      else if (userRole == supplier)
        return const RouteInformation(location: Routes.documentPath);
    } else if (SharedPreferencesService.getAccessToken.isEmpty &&
        configuration.uiPage == Pages.NotFound &&
        configuration.uiPage != Pages.Login) {
      return const RouteInformation(location: Routes.notFoundPath);
    } else if (SharedPreferencesService.getAccessToken.isEmpty &&
        (configuration.path != Routes.authPath &&
            configuration.path != Routes.downloadAppPath &&
            configuration.path != Routes.resetPasswordPath)) {
      return const RouteInformation(location: Routes.authPath);
    }

    print("Exact path is " + configuration.path);
    switch (configuration.uiPage) {
      case Pages.Login:
        return const RouteInformation(location: Routes.authPath);
        break;
      case Pages.Document:
        return const RouteInformation(location: Routes.documentPath);
        break;
      case Pages.Archive:
        return const RouteInformation(location: Routes.archivePath);
        break;
      case Pages.ShareWithMe:
        return const RouteInformation(location: Routes.sharePath);
        break;
      case Pages.ActionRequest:
        return const RouteInformation(location: Routes.actionRequestPath);
        break;
      case Pages.Contact:
        if (userRole == supplier)
          return const RouteInformation(location: Routes.contactsPath);
        else
          return const RouteInformation(location: Routes.notFoundPath);
        break;
      case Pages.Dashboard:
        return const RouteInformation(location: Routes.dashboardPath);
        break;
      case Pages.UserDocument:
        return RouteInformation(location: configuration.path);
        break;
      case Pages.DownloadApp:
        return RouteInformation(location: Routes.downloadAppPath);
        break;
      case Pages.ResetPassword:
        return RouteInformation(location: configuration.path);
        break;
      case Pages.SurveyBuilder:
        if (userRole == supplier)
          return RouteInformation(location: configuration.path);
        else
          return RouteInformation(location: configuration.path);
        break;

      case Pages.SurveyBuilder:
        return RouteInformation(location: configuration.path);
        break;
      default:
        return const RouteInformation(location: Routes.notFoundPath);
    }
  }
}
