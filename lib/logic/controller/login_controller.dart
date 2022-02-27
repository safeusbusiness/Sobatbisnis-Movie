import 'dart:async';
import 'package:elemovie/config/app_data.dart';
import 'package:elemovie/logic/controller/base_controller.dart';
import 'package:elemovie/logic/controller/settings_controller.dart';
import 'package:elemovie/logic/helper/utility.dart';
import 'package:elemovie/logic/model/user_model.dart';
import 'package:elemovie/logic/service/location_service.dart';
import 'package:elemovie/ui/screen/init_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/weather.dart';

class LoginController extends BaseController {
  var timeNow = "06:20 PM".obs;
  var dateNow = "Nov, 10 2020 | Wednesday".obs;
  var tempNow = "34° C".obs;

  var usernameController = TextEditingController().obs;
  var usernameFocus = FocusNode().obs;
  var validateUsername = false.obs;

  var kataSandiController = TextEditingController().obs;
  var kataSandiFocus = FocusNode().obs;
  var validateKataSandi = false.obs;

  var phoneNumberController = TextEditingController().obs;
  var phoneNumberFocus = FocusNode().obs;
  var validatePhoneNumber = false.obs;

  var errorText = "required".tr.obs;

  var isLoadingWeather = true.obs;
  var isRegister = false.obs;

  void resetData() {
    usernameController.value.clear();
    kataSandiController.value.clear();
    phoneNumberController.value.clear();
  }

  void onRefreshPersonalDetail() {
    try {
      var prevController = Get.find<SettingsController>();
      prevController.userModel.value = AppData.currentUserModel ?? UserModel();
    } catch (e) {}
  }

  void loginButton() async {
    setBusy();
    String userNameString = usernameController.value.text.toLowerCase();
    String passwordString = kataSandiController.value.text;
    String phoneNumberString = phoneNumberController.value.text;
    bool isAllPass = true;

    if (userNameString.isEmpty) {
      validateUsername.value = true;
      usernameFocus.value.requestFocus();
      isAllPass = false;
    }
    if (passwordString.isEmpty) {
      validateKataSandi.value = true;
      kataSandiFocus.value.requestFocus();
      isAllPass = false;
    }
    if (isRegister.value && phoneNumberString.isEmpty) {
      validatePhoneNumber.value = true;
      phoneNumberFocus.value.requestFocus();
      isAllPass = false;
    }

    if (isAllPass) {
      setBusy();
      await Future.delayed(Duration(seconds: 1));
      var listAccount = AppData.userModelList!;
      if (isRegister.value) {
        var isPhoneNumberAlreadyUse = listAccount.firstWhereOrNull(
            (element) => element.user_phone == phoneNumberString);
        if (isPhoneNumberAlreadyUse != null) {
          Utility.showToast('registration_failed_phone'.tr);
        } else {
          var isUsernameAlreadyUsed = listAccount.firstWhereOrNull(
              (element) => element.user_fullname == userNameString);
          if (isUsernameAlreadyUsed != null) {
            Utility.showToast('registration_failed_username'.tr);
          } else {
            listAccount.add(UserModel(
                user_name: userNameString,
                user_fullname: '',
                user_password: passwordString,
                user_image: '',
                user_phone: phoneNumberString));
            AppData.userModelList = listAccount;
            Utility.showToast('registration_success'.tr);
            resetData();
            isRegister.value = false;
          }
        }
      } else {
        var isAvailableAccount = listAccount.firstWhereOrNull((element) =>
            element.user_name == userNameString &&
            element.user_password == passwordString);
        if (isAvailableAccount != null) {
          AppData.currentUserModel = isAvailableAccount;
          Utility.showToast('login_success'.tr);
          onRefreshPersonalDetail();
          Get.offAll(InitScreen());
        } else {
          Utility.showToast('login_failed'.tr);
        }
      }
    }
    setIdle();
  }

  void initializeData() async {
    timeNow.value =
        Utility.getDateFromMillsec(Utility.getDeviceTimeStamp(), 'hh:mm a');
    dateNow.value = Utility.getDateFromMillsec(
        Utility.getDeviceTimeStamp(), 'MMM, dd yyyy | EEEEE');

    WeatherFactory ws = new WeatherFactory('e2fdd980bf2914f1b8ee0d174cbd01de');
    var position = await LocationService.getPosition();
    Weather weather = await ws.currentWeatherByLocation(
        position?.latitude ?? 0.0, position?.longitude ?? 0.0);

    if (weather != null) {
      String removeCelcius = (weather.temperature?.celsius
                  .toString()
                  .replaceAll('Celsius', '')
                  .substring(0, 2) ??
              '0.0') +
          '° C';
      print('Celsius: ${removeCelcius}° C');
      tempNow.value = removeCelcius;
      isLoadingWeather.value = false;
    } else {
      tempNow.value = '34° C';
      isLoadingWeather.value = false;
    }
  }
}
