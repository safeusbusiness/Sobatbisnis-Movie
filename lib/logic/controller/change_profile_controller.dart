import 'dart:io';

import 'package:elemovie/config/app_data.dart';
import 'package:elemovie/logic/controller/base_controller.dart';
import 'package:elemovie/logic/controller/settings_controller.dart';
import 'package:elemovie/logic/helper/utility.dart';
import 'package:elemovie/logic/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elemovie/ui/widget/main_file_upload.dart';

class ChangeProfileController extends BaseController {
  bool isChangeProfile = Get.arguments['isChangeProfile'];

  var fileImage = File('').obs;
  var userModel = (AppData.currentUserModel ?? UserModel()).obs;

  var fullNameController = TextEditingController().obs;
  var phoneNumberController = TextEditingController().obs;
  var fullNameError = ''.obs;
  var phoneNumberError = ''.obs;

  var oldPasswordController = TextEditingController().obs;
  var newPasswordController = TextEditingController().obs;
  var reNewPasswordController = TextEditingController().obs;
  var oldPasswordError = ''.obs;
  var newPasswordError = ''.obs;
  var reNewPasswordError = ''.obs;

  void onChangeProfilePicture() {
    MainFileUpload(
      onChanged: (file) {
        fileImage.value = file;
      },
      photoUrl: (userModel.value.user_image?.isEmpty ?? false)
          ? null
          : userModel.value.user_image ?? '',
    ).showBottomDialog();
  }

  void onSetUserList() {
    var userModelList = AppData.userModelList;
    if (userModelList?.isNotEmpty ?? false) {
      for (int i = 0; i < userModelList!.length; i++) {
        if (userModelList[i].user_name == userModel.value.user_name) {
          userModelList[i] = userModel.value;
        }
      }
    }
    AppData.userModelList = userModelList;
  }

  void onResetData() {
    fullNameError.value = '';
    phoneNumberError.value = '';
    oldPasswordError.value = '';
    newPasswordError.value = '';
    reNewPasswordError.value = '';
  }

  void onSaveData() async {
    if (loadingStatus.value) {
      return;
    }
    String fullNameString = fullNameController.value.text;
    String phoneNumberString = phoneNumberController.value.text;
    String oldPasswordString = oldPasswordController.value.text;
    String newPasswordString = newPasswordController.value.text;
    String reNewPasswordString = reNewPasswordController.value.text;
    bool isAllPass = true;
    onResetData();

    if (isChangeProfile) {
      if (fullNameError.value.isNotEmpty) isAllPass = false;
      if (fullNameString.isEmpty) {
        fullNameError.value = 'required'.tr;
        isAllPass = false;
      }

      if (phoneNumberError.value.isNotEmpty) isAllPass = false;
      if (phoneNumberString.isEmpty) {
        phoneNumberError.value = 'required'.tr;
        isAllPass = false;
      }
    } else {
      if (oldPasswordError.value.isNotEmpty) isAllPass = false;
      if (oldPasswordString.isEmpty) {
        oldPasswordError.value = 'required'.tr;
        isAllPass = false;
      } else {
        if (oldPasswordString != userModel.value.user_password) {
          oldPasswordError.value = 'wrong_password'.tr;
          isAllPass = false;
        }
      }

      if (newPasswordError.value.isNotEmpty) isAllPass = false;
      if (newPasswordString.isEmpty) {
        newPasswordError.value = 'required'.tr;
        isAllPass = false;
      }

      if (reNewPasswordError.value.isNotEmpty) isAllPass = false;
      if (reNewPasswordString.isEmpty) {
        reNewPasswordError.value = 'required'.tr;
        isAllPass = false;
      }
    }

    if (isAllPass) {
      if (isChangeProfile) {
        setBusy();
        userModel.value.user_fullname = fullNameString;
        userModel.value.user_phone = phoneNumberString;
        if (fileImage.value.path.isNotEmpty) {
          userModel.value.user_image = fileImage.value.path;
        }
      } else {
        if (newPasswordString != reNewPasswordString) {
          reNewPasswordError.value = 'password_not_match'.tr;
          return;
        }
        if (oldPasswordString != userModel.value.user_password) {
          oldPasswordError.value = 'wrong_password'.tr;
          return;
        }
        setBusy();
        userModel.value.user_password = newPasswordString;
      }
      onSetUserList();
      AppData.currentUserModel = userModel.value;
      await Future.delayed(Duration(seconds: 2));
      Utility.showToast('success_save_information'.tr);
      setIdle();
      onBackPressed();
    }
  }

  void initializeData() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      fullNameController.value.text = userModel.value.user_fullname ?? '';
      phoneNumberController.value.text = userModel.value.user_phone ?? '';
    });
  }

  void onRefreshPrevData() {
    try {
      var prevController = Get.find<SettingsController>();
      prevController.userModel.value = userModel.value;
    } catch (e) {}
  }

  void onBackPressed() {
    onRefreshPrevData();
    Get.back();
  }
}
