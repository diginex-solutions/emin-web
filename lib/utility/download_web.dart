// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:business/service/api_call.dart';

void downloadFile(String actualUrl, String filename) async {
  var response = await ApiClient.instance.downloadWebFile(actualUrl, filename);

  print(response);
  if (response == null) {
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = actualUrl
      ..download = filename;
    html.document.body.children.add(anchor);

    anchor.click();

    html.document.body.children.remove(anchor);
    html.Url.revokeObjectUrl(actualUrl);
    return;
  } else if (response.statusCode == 200) {
    final blob = html.Blob([response.bodyBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..download = filename;
    html.document.body.children.add(anchor);

    anchor.click();

    html.document.body.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }
}
