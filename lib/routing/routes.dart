import 'package:common/routing/page_configuration.dart';
import 'package:common/routing/pages_dart.dart';
import 'package:common/routing/routes.dart';

const PageConfiguration LoginPageConfig =
    PageConfiguration(key: 'Login', path: Routes.authPath, uiPage: Pages.Login);

const PageConfiguration DashboardPageConfig = PageConfiguration(
    key: 'Dashboard', path: Routes.dashboardPath, uiPage: Pages.Dashboard);

const PageConfiguration ContactPageConfig = PageConfiguration(
    key: 'Contact', path: Routes.contactsPath, uiPage: Pages.Contact);

const PageConfiguration DocumentPageConfig = PageConfiguration(
    key: 'Document', path: Routes.documentPath, uiPage: Pages.Document);

PageConfiguration userDocumentPageConfig(String userId) {
  return PageConfiguration(
      key: 'UserDocument',
      path: Routes.userDocumentPath + "/" + userId,
      uiPage: Pages.UserDocument);
}

const PageConfiguration ArchivePageConfig = PageConfiguration(
    key: 'Archive', path: Routes.archivePath, uiPage: Pages.Archive);

const PageConfiguration ShareWithMePageConfig = PageConfiguration(
    key: 'ShareWithMe', path: Routes.sharePath, uiPage: Pages.ShareWithMe);

const PageConfiguration ActionRequestPageConfig = PageConfiguration(
    key: 'ActionRequest',
    path: Routes.actionRequestPath,
    uiPage: Pages.ActionRequest);

const PageConfiguration NotFoundConfig = PageConfiguration(
    key: 'NotFound', path: Routes.notFoundPath, uiPage: Pages.NotFound);
