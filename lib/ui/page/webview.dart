import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webview_app/util/log_util.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class WebViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  String homeUrl = 'https://www.baidu.com';
  bool loaded = false;
  bool canGoback = false;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(_backInterceptor);
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(_backInterceptor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: Text(I18n.of(context).text('app_name'))),
        body: SafeArea(child: buildWebView()));
  }

  buildWebView() {
    var web = WebView(
      initialUrl: homeUrl,
      javascriptMode: JavascriptMode.unrestricted,
      gestureNavigationEnabled: true,
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },
      onPageStarted: (String url) {
        logUtil.d('Page started loading: $url');
      },
      onPageFinished: (String url) async {
        logUtil.i2('Page finished loading: $url');
        //if (url == homeUrl) {
        if (!loaded) {
          setState(() {
            loaded = true;
          });
        }
        //}
        WebViewController controller = await _controller.future;
        var _canGoback = await controller.canGoBack();
        setState(() {
          canGoback = _canGoback;
        });
      },
    );
    const loading = SpinKitThreeBounce(
      color: Colors.blueAccent,
      size: 60.0,
    );
    return Stack(
        fit: StackFit.expand,
        alignment: AlignmentDirectional.center,
        children: loaded ? [web] : [web, loading]);
  }

  _onBack() async {
    if (canGoback) {
      WebViewController controller = await _controller.future;
      controller.goBack();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _backInterceptor(
      bool stopDefaultButtonEvent, RouteInfo info) async {
    return await _onBack();
  }
}
