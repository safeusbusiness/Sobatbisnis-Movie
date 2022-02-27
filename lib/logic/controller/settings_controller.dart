import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:elemovie/config/app_data.dart';
import 'package:elemovie/logic/controller/init_controller.dart';
import 'package:elemovie/logic/model/user_model.dart';
import 'package:elemovie/logic/service/local_storage_service.dart';
import 'package:elemovie/ui/helper/dialog_utils.dart';
import 'package:elemovie/ui/screen/login_screen.dart';
import 'package:get/get.dart';

class SettingsController {
  var userModel = (AppData.currentUserModel ?? UserModel()).obs;

  void resetScreen() {
    try {
      var initController = Get.find<InitController>();
      initController.tabController.value.jumpToTab(0);
    } catch (e) {}
  }

  void onSignOut() {
    DialogUtils.showPopUpDialog(
        dialogType: DialogType.WARNING,
        title: 'sign_out'.tr,
        desc: 'sign_out_desc'.tr,
        btnOkOnPress: () {
          AppData.movieFavoriteList = [];
          AppData.currentUserModel = null;
          resetScreen();
          Get.offAll(LoginScreen());
        },
        btnCancelOnPress: () {});
  }
}
