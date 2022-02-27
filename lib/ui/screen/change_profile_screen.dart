import 'package:elemovie/config/app_theme.dart';
import 'package:elemovie/logic/controller/change_profile_controller.dart';
import 'package:elemovie/logic/helper/regex_rule.dart';
import 'package:elemovie/logic/model/custom_appbar_model.dart';
import 'package:elemovie/ui/widget/main_button_widget.dart';
import 'package:elemovie/ui/widget/main_custom_avatar_widget.dart';
import 'package:elemovie/ui/widget/main_scaffold_widget.dart';
import 'package:elemovie/ui/widget/main_textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeProfileScreen extends StatefulWidget {
  const ChangeProfileScreen({Key? key}) : super(key: key);

  @override
  _ChangeProfileScreenState createState() => _ChangeProfileScreenState();
}

class _ChangeProfileScreenState extends State<ChangeProfileScreen> {
  var controller = Get.put(ChangeProfileController());

  @override
  void initState() {
    controller.initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget changePasswordWidget() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MainTextFieldWidget(
            errorText: controller.oldPasswordError,
            controller: controller.oldPasswordController.value,
            hint: 'input_old_password'.tr,
            title: 'old_password'.tr,
            textColor: Colors.white,
            obscureText: true,
            icon: Icons.lock_rounded,
          ),
          SizedBox(
            height: 10,
          ),
          MainTextFieldWidget(
            errorText: controller.newPasswordError,
            controller: controller.newPasswordController.value,
            hint: 'input_new_password'.tr,
            title: 'new_password'.tr,
            textColor: Colors.white,
            obscureText: true,
            icon: Icons.lock_rounded,
          ),
          SizedBox(
            height: 10,
          ),
          MainTextFieldWidget(  
            errorText: controller.reNewPasswordError,
            controller: controller.reNewPasswordController.value,
            hint: 'input_renew_password'.tr,
            title: 'renew_password'.tr,
            textColor: Colors.white,
            obscureText: true,
            icon: Icons.lock_rounded,
          ),
          SizedBox(
            height: 120,
          )
        ],
      );
    }

    Widget changeProfileWidget() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Obx(
                  () => MainCustomAvatarWidget(
                      urlImage: controller.fileImage.value.path.isNotEmpty
                          ? controller.fileImage.value.path
                          : controller.userModel.value.user_image ?? '',
                      outSideImageSize: Size(120, 120),
                      inSideImageSize: Size(115, 115)),
                ),
                Container(
                  alignment: Alignment.center,
                  transform: Matrix4.translationValues(40.0, -40.0, 0.0),
                  child: ElevatedButton(
                    onPressed: () => controller.onChangeProfilePicture(),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 23,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(15),
                      elevation: 0,
                      primary: AppTheme.theme.primaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          MainTextFieldWidget(
            errorText: controller.fullNameError,
            controller: controller.fullNameController.value,
            hint: 'input_fullname'.tr,
            title: 'full_name'.tr,
            textColor: Colors.white,
            icon: Icons.person_rounded,
          ),
          SizedBox(
            height: 10,
          ),
          MainTextFieldWidget(
            errorText: controller.phoneNumberError,
            controller: controller.phoneNumberController.value,
            hint: 'input_phonenumber'.tr,
            title: 'phone_number'.tr,
            keyboardType: TextInputType.phone,
            validation: [RegexRule.phoneNumberValidationRule],
            textColor: Colors.white,
            icon: Icons.phone_rounded,
          ),
          SizedBox(
            height: 120,
          )
        ],
      );
    }

    return Obx(() => MainScaffoldWidget(
        onBackPressed: () => controller.onBackPressed(),
        appBar: CustomAppBarModel(
            titleTextAppBar: controller.isChangeProfile
                ? 'change_profile'.tr
                : 'change_password'.tr),
        bottomSheet: MainButtonWidget(
          text: 'save'.tr,
          onPressed: () => controller.onSaveData(),
          isLoading: controller.loadingStatus.value,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: controller.isChangeProfile
                ? changeProfileWidget()
                : changePasswordWidget(),
          ),
        )));
  }
}
