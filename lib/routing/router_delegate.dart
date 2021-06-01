import 'package:common/routing/page_configuration.dart';
import 'package:common/routing/pages_dart.dart';
import 'package:common/routing/router_delegate.dart';
import 'package:eminweb/routing/routes.dart';
import 'package:eminweb/screens/download_app/download_app_screen.dart';
import 'package:eminweb/screens/home_screen.dart';
import 'package:eminweb/screens/login/authen_page.dart';
import 'package:eminweb/screens/reset_password/reset_password_screen.dart';
import 'package:eminweb/ui/error_screen.dart';
import 'package:surveybuilder/survey_builder_screen.dart';

class EminRouterDelegate extends ApplicationRouterDelegate {
  @override
  void addPage(PageConfiguration pageConfig) {
    print("added new page " + pageConfig.path);
    super.addPage(pageConfig);

    final shouldAddPage = pages.isEmpty ||
        (pages.last.arguments as PageConfiguration).uiPage != pageConfig.uiPage;
    if (shouldAddPage) {
      switch (pageConfig.uiPage) {
        case Pages.Login:
          addPageData(AuthPage(), LoginPageConfig);
          break;

        case Pages.Dashboard:
          addPageData(
              HomeScreen(
                currentPath: pageConfig.path,
              ),
              DashboardPageConfig);
          break;
        case Pages.Contact:
          addPageData(
              HomeScreen(
                currentPath: pageConfig.path,
              ),
              ContactPageConfig);
          break;
        case Pages.ExistingSurveyPage:
          addPageData(
              HomeScreen(
                currentPath: pageConfig.path,
              ),
              pageConfig);
          break;
        case Pages.Archive:
          addPageData(
              HomeScreen(
                currentPath: pageConfig.path,
              ),
              ArchivePageConfig);
          break;
        case Pages.ActionRequest:
          addPageData(
              HomeScreen(
                currentPath: pageConfig.path,
              ),
              ActionRequestPageConfig);
          break;
        case Pages.ShareWithMe:
          addPageData(
              HomeScreen(
                currentPath: pageConfig.path,
              ),
              ShareWithMePageConfig);
          break;
        case Pages.DownloadApp:
          addPageData(DownloadAppScreen(), DownloadAppConfig);
          break;
        case Pages.Document:
          addPageData(
              HomeScreen(
                currentPath: pageConfig.path,
              ),
              DocumentPageConfig);
          break;
        case Pages.UserDocument:
          final uri = Uri.parse(pageConfig.path);
          if (uri.pathSegments != null && uri.pathSegments.length == 2) {
            var path = uri.pathSegments[0];
            var params = uri.pathSegments[1];
            addPageData(
                HomeScreen(
                  currentPath: "/" + path,
                  params: params,
                ),
                pageConfig);
          } else {
            addPageData(NotFoundScreen(), NotFoundConfig);
          }

          break;

        case Pages.ResetPassword:
          final uri = Uri.parse(pageConfig.path);
          if (uri.pathSegments != null && uri.pathSegments.length == 2) {
            var params = uri.pathSegments[1];
            addPageData(ResetPasswordScreen(token: params), pageConfig);
          } else {
            addPageData(NotFoundScreen(), NotFoundConfig);
          }

          break;

        case Pages.SurveyBuilder:
          final uri = Uri.parse(pageConfig.path);
          if (uri.pathSegments != null && uri.pathSegments.length == 2) {
            var params = uri.pathSegments[1];
            addPageData(SurveyBuilderScreen(surveyId: params), pageConfig);
          } else {
            addPageData(NotFoundScreen(), NotFoundConfig);
          }
          break;
        case Pages.NotFound:
          addPageData(NotFoundScreen(), NotFoundConfig);
          break;
        default:
          break;
      }
      notifyListeners();
    }
  }
}
