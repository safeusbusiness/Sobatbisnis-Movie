import 'package:elemovie/config/app_theme.dart';
import 'package:elemovie/logic/controller/settings_controller.dart';
import 'package:elemovie/ui/helper/assets.dart';
import 'package:elemovie/ui/screen/about_us_screen.dart';
import 'package:elemovie/ui/screen/change_profile_screen.dart';
import 'package:elemovie/ui/widget/main_choose_country_widget.dart';
import 'package:elemovie/ui/widget/main_click_custom_widget.dart';
import 'package:elemovie/ui/widget/main_custom_avatar_widget.dart';
import 'package:elemovie/ui/widget/main_scaffold_widget.dart';
import 'package:elemovie/ui/widget/photo_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  var controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    Widget menuItemWidget(
        {required String text,
        required IconData icon,
        required Function() onTap,
        Color? backgroundIconColor}) {
      return MainClickCustomWidget(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              children: [
                CircleAvatar(
                    backgroundColor: backgroundIconColor ?? Colors.orange,
                    radius: 18,
                    child: Icon(
                      icon,
                      size: 20,
                      color: Colors.white,
                    )),
                Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Text(text,
                      style: AppTheme.lightTheme.textTheme.bodyText1!.copyWith(
                          color: Colors.white70, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left),
                )
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.chevron_right_rounded,
                color: Colors.white70,
                size: 30,
              ),
            )
          ],
        ),
      );
    }

    return Obx(() => MainScaffoldWidget(
            body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'settings'.tr,
                  style: AppTheme.theme.textTheme.headline2!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                MainClickCustomWidget(
                  onTap: () => Get.to(ChangeProfileScreen(),
                      arguments: {'isChangeProfile': true}),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MainCustomAvatarWidget(
                          urlImage: controller.userModel.value.user_image ?? '',
                          outSideImageSize: Size(55, 55),
                          inSideImageSize: Size(50, 50)),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            (controller.userModel.value.user_fullname?.isEmpty ??
                                    false)
                                ? controller.userModel.value.user_name
                                        ?.capitalize ??
                                    ''
                                : controller.userModel.value.user_fullname ??
                                    '',
                            style: AppTheme.theme.textTheme.bodyText1!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white70),
                          ),
                          Text(
                            'edit_personal_detail'.tr,
                            style: AppTheme.theme.textTheme.bodyText2!
                                .copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'profile'.tr,
                  style: AppTheme.theme.textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.greyTextColor),
                ),
                SizedBox(
                  height: 10,
                ),
                menuItemWidget(
                  text: 'change_password'.tr,
                  icon: Icons.lock_rounded,
                  onTap: () => Get.to(ChangeProfileScreen(),
                      arguments: {'isChangeProfile': false}),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'App',
                  style: AppTheme.theme.textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.greyTextColor),
                ),
                SizedBox(
                  height: 10,
                ),
                menuItemWidget(
                    text: 'language'.tr,
                    icon: Icons.language_rounded,
                    onTap: () => MainChooseCountryWidget().onClick(),
                    backgroundIconColor: Colors.purple),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'other'.tr,
                  style: AppTheme.theme.textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.greyTextColor),
                ),
                SizedBox(
                  height: 10,
                ),
                menuItemWidget(
                    text: 'about_us'.tr,
                    icon: Icons.info_rounded,
                    onTap: () => Get.to(AboutUsScreen()),
                    backgroundIconColor: Colors.purple),
                SizedBox(
                  height: 10,
                ),
                menuItemWidget(
                    text: 'logout'.tr,
                    icon: Icons.logout,
                    onTap: () => controller.onSignOut()),
              ],
            ),
          ),
        )));
  }
}
