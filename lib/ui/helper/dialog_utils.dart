import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:elemovie/config/app_theme.dart';
import 'package:elemovie/ui/widget/main_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogUtils {
  static void showPopUpDialog(
      {required DialogType dialogType,
      AnimType animType = AnimType.BOTTOMSLIDE,
      required String title,
      required String desc,
      Function()? btnCancelOnPress,
      required Function() btnOkOnPress,
      String? btnOkText,
      String? btnCancelText,
      Function(dynamic)? onDissmissCallback,
      Duration? autoHide}) {
    AwesomeDialog(
      context: Get.context!,
      padding: const EdgeInsets.all(16),
      dialogType: dialogType,
      autoHide: autoHide,
      onDissmissCallback:
          onDissmissCallback != null ? (s) => onDissmissCallback(s) : null,
      animType: animType,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      title: title,
      desc: desc,
      btnCancel: btnCancelOnPress != null
          ? SizedBox(
              height: 45,
              child: MainButtonWidget(
                text: btnCancelText ?? 'cancel'.tr,
                radius: 120,
                color: Colors.white,
                textColor: Colors.black,
                onPressed: () {
                  Get.back();
                  btnCancelOnPress();
                },
              ),
            )
          : null,
      btnOk: btnOkOnPress != null
          ? SizedBox(
              height: 45,
              child: MainButtonWidget(
                text: btnOkText ?? 'confirm'.tr,
                radius: 120,
                color: AppTheme.theme.primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  Get.back();
                  btnOkOnPress();
                },
              ),
            )
          : null,
    ).show();
  }

  static Future<dynamic> showGeneralDrawer({
    bool isDismissable = true,
    double radius = 0,
    bool withStrip = false,
    Color? color,
    Widget? content,
    EdgeInsets padding =
        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  }) async {
    await showModalBottomSheet(
      context: Get.context!,
      isDismissible: isDismissable,
      enableDrag: isDismissable,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: color != null ? color : AppTheme.theme.backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                topRight: Radius.circular(radius),
              ),
            ),
            padding: padding,
            child: Column(
              children: [
                Container(
                  width: 65,
                  height: 5,
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(2.5)),
                      color: withStrip
                          ? AppTheme.theme.unselectedWidgetColor
                          : Colors.transparent),
                ),
                const SizedBox(
                  height: 24,
                ),
                content != null ? content : const SizedBox(),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: MediaQuery.of(context).viewInsets,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<dynamic> showMainDrawer({
    bool isDismissable = true,
    double radius = 0,
    bool withStrip = false,
    Color? color,
    AssetImage? image,
    String? title,
    String? description,
    Widget? content,
  }) async {
    await showGeneralDrawer(
      isDismissable: isDismissable,
      radius: radius,
      withStrip: withStrip,
      color: color ?? Colors.white,
      content: WillPopScope(
        onWillPop: () {
          if (isDismissable) Get.back();
          return Future.value(false);
        },
        child: Column(
          children: [
            image != null
                ? Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Image(image: image))
                : const SizedBox(),
            title != null
                ? Text(
                    title,
                    style: AppTheme.theme.textTheme.headline6,
                    textAlign: TextAlign.center,
                  )
                : const SizedBox(),
            const SizedBox(
              height: 12,
            ),
            Text(
              description ?? '',
              style: AppTheme.theme.textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
            content != null ? content : const SizedBox(),
          ],
        ),
      ),
    );
  }

  static Future<dynamic> showGeneralPopup(
      {double radius = 0,
      Color? color,
      Widget? content,
      bool barrierDismissible = true,
      bool usePadding = false}) async {
    await showDialog(
      context: Get.context!,
      barrierDismissible: barrierDismissible,
      builder: (context) => WillPopScope(
        onWillPop: () => Future.value(barrierDismissible),
        child: Center(
          child: SingleChildScrollView(
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.all(20),
                padding:
                    usePadding ? const EdgeInsets.all(17) : EdgeInsets.zero,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: color != null ? color : AppTheme.theme.backgroundColor,
                  borderRadius: BorderRadius.circular(radius),
                ),
                child: content != null ? content : const SizedBox(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
