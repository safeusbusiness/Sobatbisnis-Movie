import 'package:elemovie/config/app_theme.dart';
import 'package:elemovie/logic/helper/regex_rule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MainTextFieldWidget extends StatefulWidget {
  final String? title;
  final String? hint;
  final Widget? statusWidget;
  final Widget? suffix;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final bool readOnly;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final bool obscureText;
  final int? maxLength;
  final String? initialValue;
  final List<RegexValidation>? validation;
  final IconData? icon;
  final Function()? onTap;
  final RxString? errorText;
  final bool enableStrip;
  final List<TextInputFormatter>? listInputFormatters;
  final TextAlign textAlign;
  final Color? textColor;

  const MainTextFieldWidget(
      {Key? key,
      this.title,
      this.hint,
      this.statusWidget,
      this.suffix,
      this.controller,
      this.onChange,
      this.readOnly = false,
      this.keyboardType,
      this.textCapitalization,
      this.obscureText = false,
      this.maxLength,
      this.initialValue,
      this.validation,
      this.icon,
      this.onTap,
      this.enableStrip = true,
      required this.errorText,
      this.listInputFormatters,
      this.textAlign = TextAlign.start,
      this.textColor = Colors.black})
      : super(key: key);

  @override
  _MainTextFieldWidgetState createState() => _MainTextFieldWidgetState();
}

class _MainTextFieldWidgetState extends State<MainTextFieldWidget> {
  TextEditingController? _controller;
  var isShowPassword = true.obs;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    if (widget.initialValue != null) {
      _controller ??= TextEditingController();
      _controller?.text = widget.initialValue!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: () {
            if (widget.onTap != null) widget.onTap!();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null)
                Icon(
                  widget.icon,
                  color: Colors.white.withOpacity(0.65),
                ),
              if (widget.icon != null)
                SizedBox(
                  width: 16,
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (widget.title != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.title ?? '',
                            style: AppTheme.theme.textTheme.bodyText1!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          widget.statusWidget ?? SizedBox()
                        ],
                      ),
                    if (!widget.obscureText)
                      SizedBox(
                        height: 8,
                      ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            readOnly: widget.readOnly,
                            controller: _controller,
                            textCapitalization: widget.textCapitalization ??
                                TextCapitalization.none,
                            onChanged: (val) {
                              widget.errorText!.value = '';
                              bool isPassRegex = true;
                              widget.validation?.forEach((element) {
                                RegExp regExp = RegExp(element.regex);
                                if (!regExp.hasMatch(val)) {
                                  isPassRegex = false;
                                  widget.errorText!.value =
                                      element.errorMesssage!;
                                }
                              });
                              if (widget.onChange != null)
                                widget.onChange!(val);
                            },
                            keyboardType: widget.keyboardType,
                            obscureText: widget.obscureText
                                ? isShowPassword.value
                                : false,
                            maxLines:
                                widget.keyboardType == TextInputType.multiline
                                    ? 5
                                    : 1,
                            textAlign: widget.textAlign,
                            inputFormatters: [
                              if (widget.listInputFormatters != null)
                                ...widget.listInputFormatters ?? [],
                              LengthLimitingTextInputFormatter(
                                  widget.maxLength),
                            ],
                            decoration: InputDecoration(
                              hintText: widget.hint,
                              hintStyle: AppTheme.theme.textTheme.bodyText1
                                  ?.copyWith(color: AppTheme.theme.hintColor),
                              contentPadding: EdgeInsets.all(0),
                              isDense: true,
                              suffix: widget.obscureText
                                  ? GestureDetector(
                                      onTap: () => isShowPassword.value =
                                          !isShowPassword.value,
                                      child: Icon(
                                        isShowPassword.value
                                            ? Icons.visibility_off_rounded
                                            : Icons.visibility_rounded,
                                        color: Colors.black.withOpacity(0.65),
                                      ),
                                    )
                                  : widget.suffix,
                              border: InputBorder.none,
                            ),
                            style: AppTheme.theme.textTheme.bodyText1!.copyWith(
                                color: widget.readOnly
                                    ? Colors.grey.shade400
                                    : widget.textColor),
                          ),
                        ),
                      ],
                    ),
                    if (widget.enableStrip)
                      SizedBox(
                        height: 5,
                      ),
                    if (widget.enableStrip)
                      Divider(
                        color: AppTheme.theme.hintColor,
                      ),
                    widget.errorText!.value.length > 0
                        ? Text(
                            widget.errorText!.value,
                            style: AppTheme.theme.textTheme.bodyText2
                                ?.copyWith(color: Colors.red),
                          )
                        : SizedBox()
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
