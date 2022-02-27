import 'package:elemovie/config/app_data.dart';
import 'package:elemovie/logic/service/localization_service.dart';
import 'package:elemovie/ui/screen/home_screen.dart';
import 'package:elemovie/ui/screen/init_screen.dart';
import 'package:elemovie/ui/screen/login_screen.dart';
import 'package:get/get.dart';

class SplashController {
  void initializeData() async {
    var userData = AppData.currentUserModel;
    await Future.delayed(Duration(seconds: 2));
    LocalizationService().changeLocale(
        AppData.appSettingsModel?.translate_language ?? 'English');
    if (userData != null) {
      Get.offAll(InitScreen());
    } else {
      Get.offAll(LoginScreen());
    }
  }
}
