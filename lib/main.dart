import 'package:elemovie/config/app.dart';
import 'package:elemovie/config/app_config.dart';
import 'package:elemovie/config/app_data.dart';
import 'package:elemovie/logic/model/app_settings_model.dart';
import 'package:elemovie/logic/service/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorageService.prefs = await SharedPreferences.getInstance();
  AppConfig.fillAppDataSettings();
  AppConfig.firstInitalizeStatusBar();
  runApp(const App());
}
