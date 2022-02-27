import 'package:elemovie/config/app.dart';
import 'package:elemovie/config/app_data.dart';
import 'package:elemovie/config/app_theme.dart';
import 'package:elemovie/logic/model/app_settings_model.dart';
import 'package:elemovie/logic/model/user_model.dart';
import 'package:elemovie/logic/service/movie_database_service.dart';
import 'package:elemovie/logic/service/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  static SystemUiOverlayStyle topAppBarStyle() => SystemUiOverlayStyle(
      statusBarColor: AppTheme.theme.primaryColorDark,
      statusBarIconBrightness: Brightness.light);

  static void firstInitalizeStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(topAppBarStyle());
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  static void fillAppDataSettings() {
    AppData.appSettingsModel ??=
        AppSettingsModel(translate_language: 'English');
    if (AppData.userModelList?.isEmpty ?? true) {
      AppData.userModelList = [
        UserModel(
            user_name: 'sobatbisnis',
            user_password: '12345',
            user_fullname: 'Sobatbisnis Developer',
            user_image:
                'https://live.staticflickr.com/5252/5403292396_0804de9bcf_b.jpg',
            user_phone: '+6285770338593')
      ];
    }
  }
}
