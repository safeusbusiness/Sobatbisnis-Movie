import 'package:elemovie/config/app_theme.dart';
import 'package:elemovie/logic/service/localization_service.dart';
import 'package:elemovie/ui/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Elemovie',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      home: SplashScreen(),
    );
  }
}
