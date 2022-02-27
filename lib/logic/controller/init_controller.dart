import 'package:elemovie/logic/controller/home_controller.dart';
import 'package:elemovie/logic/helper/utility.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:get/get.dart';

class InitController {
  var tabController = PersistentTabController().obs;
  DateTime? currentBackPressTime;

  Future<bool> onWillPop() {
    var homeController = Get.find<HomeController>();
    if (homeController.isSearch.value) {
      homeController.isSearch.value = false;
      return Future.value(false);
    } else {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime ?? DateTime.now()) >
              Duration(seconds: 2)) {
        currentBackPressTime = now;
        Utility.showToast('press_once_out_app'.tr);
        return Future.value(false);
      }
      return Future.value(true);
    }
  }
}
