import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_app/app_sentry.dart';
import 'package:flutter_webview_app/ui/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]).then((_) => AppSentry.runWithCatchError(App()));
}
