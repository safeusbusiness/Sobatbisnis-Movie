import 'package:elemovie/config/app_theme.dart';
import 'package:elemovie/ui/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainButtonWidget extends StatelessWidget {
  String? text;
  Function onPressed;
  Color? color;
  Color? textColor;
  double? radius;
  bool isDisable;
  double? height;
  double? elevation;
  bool? isLoading = false;
  BorderSide? borderSide;
  Widget? customLeftText;

  MainButtonWidget(
      {Key? key,
      this.text,
      this.isDisable = false,
      required this.onPressed,
      this.color,
      this.textColor = Colors.white,
      this.radius = 8,
      this.elevation,
      this.isLoading,
      this.borderSide,
      this.customLeftText,
      this.height = 45})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        FocusScope.of(context).requestFocus(FocusNode());
        if (isDisable) return;
        onPressed();
      },
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      color: isDisable
          ? AppTheme.theme.hintColor
          : color ?? AppTheme.theme.primaryColor,
      elevation: elevation,
      height: height,
      padding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 16)),
          side: borderSide ?? BorderSide.none),
      child: Stack(
        children: [
          Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 550),
              opacity: isLoading ?? false ? 0.0 : 1.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customLeftText ?? SizedBox(),
                  SizedBox(
                    width: customLeftText != null ? 10 : 0,
                  ),
                  Text(
                    text ?? 'confirm'.tr,
                    style: AppTheme.theme.textTheme.button!
                        .copyWith(color: textColor),
                  )
                ],
              ),
            ),
          ),
          Center(
            child: AnimatedOpacity(
              duration: new Duration(milliseconds: 550),
              opacity: isLoading ?? false ? 1.0 : 0.0,
              child: Container(
                  width: 18,
                  height: 18,
                  child: LoadingWidget.customCircularProgressindicator()),
            ),
          ),
        ],
      ),
    );
  }
}
