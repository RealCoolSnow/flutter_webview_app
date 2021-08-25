import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webview_app/locale/i18n.dart';
import 'package:flutter_webview_app/util/log_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  String homeUrl = 'https://t.tiniao.com/exam/stu/exam';
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: Text(I18n.of(context).text('app_name'))),
        body: buildWebView());
  }

  buildTest() {
    return const Text("hello");
  }

  buildWebView() {
    return WebView(
      initialUrl: homeUrl,
      javascriptMode: JavascriptMode.unrestricted,
      onPageStarted: (String url) {
        logUtil.d('Page started loading: $url');
      },
      onPageFinished: (String url) {
        logUtil.i2('Page finished loading: $url');
      },
    );
  }
}
