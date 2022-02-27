import 'package:elemovie/config/app_data.dart';
import 'package:elemovie/config/app_theme.dart';
import 'package:elemovie/logic/model/app_settings_model.dart';
import 'package:elemovie/logic/service/localization_service.dart';
import 'package:elemovie/ui/helper/assets.dart';
import 'package:elemovie/ui/helper/dialog_utils.dart';
import 'package:elemovie/ui/widget/main_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainChooseCountryWidget extends StatelessWidget {
  const MainChooseCountryWidget({Key? key}) : super(key: key);

  void onClick() {
    var valueAppSettings = 0;

    switch ((AppData.appSettingsModel?.translate_language ?? 'English')
        .toLowerCase()) {
      case 'english':
        {
          valueAppSettings = 0;
          break;
        }
      default:
        {
          valueAppSettings = 1;
          break;
        }
    }

    var valueRadio = valueAppSettings.obs;

    void onSaveData() {
      var translateLanguage = 'English';
      switch (valueRadio.value) {
        case 0:
          {
            translateLanguage = 'English';
            break;
          }
        default:
          {
            translateLanguage = 'Indonesia';
            break;
          }
      }

      var appSettingsModel = AppData.appSettingsModel ??
          AppSettingsModel(translate_language: 'English');
      appSettingsModel.translate_language = translateLanguage;
      LocalizationService().changeLocale(translateLanguage);
      AppData.appSettingsModel = appSettingsModel;
      Get.back();
    }

    Widget rowCountryWidget(
        {required AssetImage? countryImage,
        required String? countryText,
        required int? radioCode}) {
      return InkWell(
        onTap: () => valueRadio.value = radioCode ?? 0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image(
                  image: countryImage ?? Assets.icUnitedStates,
                  width: 28,
                  height: 28,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(countryText ?? 'English',
                    style: AppTheme.theme.textTheme.bodyText1),
              ],
            ),
            Radio(
              value: radioCode ?? 0,
              groupValue: valueRadio.value,
              onChanged: (val) => valueRadio.value = val as int,
            ),
          ],
        ),
      );
    }

    DialogUtils.showGeneralDrawer(
        color: Colors.white,
        withStrip: true,
        radius: 16,
        content: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('change_language'.tr,
                    style: AppTheme.theme.textTheme.headline1),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'which_language_prefer'.tr,
                  style: AppTheme.theme.textTheme.bodyText1,
                ),
                SizedBox(
                  height: 10,
                ),
                rowCountryWidget(
                  radioCode: 0,
                  countryImage: Assets.icUnitedStates,
                  countryText: 'English',
                ),
                rowCountryWidget(
                  radioCode: 1,
                  countryImage: Assets.icIndonesia,
                  countryText: 'Indonesia',
                ),
                SizedBox(
                  height: 16,
                ),
                MainButtonWidget(
                    text: 'save'.tr, onPressed: () => onSaveData()),
                SizedBox(
                  height: 16,
                )
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    Widget countryWidget() {
      String country =
          AppData.appSettingsModel?.translate_language ?? 'English';
      AssetImage countryAsset = Assets.icUnitedStates;
      switch (country.toLowerCase()) {
        case 'indonesia':
          {
            countryAsset = Assets.icIndonesia;
            break;
          }
        default:
          {
            countryAsset = Assets.icUnitedStates;
            break;
          }
      }
      return GestureDetector(
        onTap: () => onClick(),
        child: Image(
          image: countryAsset,
          width: 33,
          height: 33,
        ),
      );
    }

    return countryWidget();
  }
}
