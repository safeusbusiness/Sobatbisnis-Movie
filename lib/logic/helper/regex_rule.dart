import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegexRule {
  static RegexValidation emptyValidationRule =
      RegexValidation(regex: r'^(?!\s*$).+', errorMesssage: 'required'.tr);
  static RegexValidation phoneNumberValidationRule = RegexValidation(
      regex: r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$',
      errorMesssage: 'error_text_phone_number'.tr);
  static RegexValidation emailValidationRule = RegexValidation(
      regex:
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      errorMesssage: 'error_text_email'.tr);
}

class RegexValidation {
  final String regex;
  final String? errorMesssage;

  RegexValidation({required this.regex, this.errorMesssage});
}
