import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_webview_app/config/config.dart';
import 'package:flutter_webview_app/locale/i18n.dart';
import 'package:flutter_webview_app/locale/locale_util.dart';
import 'package:flutter_webview_app/ui/app_theme.dart';
import 'package:flutter_webview_app/ui/page/webview.dart';

class App extends StatefulWidget {
  _AppState createState() => new _AppState();
}

class _AppState extends State<App> {
  _AppState() {}

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: Config.app,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppTheme.primary,
        splashColor: AppTheme.splash,
      ),
      localizationsDelegates: const [
        I18nDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: localeUtil.supportedLocales(),
      home: WebViewPage(),
    );
  }
}
