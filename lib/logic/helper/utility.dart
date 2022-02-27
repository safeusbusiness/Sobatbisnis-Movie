import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:elemovie/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Utility {
  static void showSnackBar(
      {String? title, String? message, Color backgroudColor = Colors.grey}) {
    Get.showSnackbar(GetSnackBar(
      title: title,
      borderRadius: 8,
      margin: EdgeInsets.all(16),
      backgroundColor: backgroudColor,
      messageText: Text(
        message ?? '',
        style:
            AppTheme.theme.textTheme.bodyText1!.copyWith(color: Colors.white),
      ),
      duration: new Duration(seconds: 2),
    ));
  }

  static Future<bool> isConnectedInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print('Connection: No Connection');
      return false;
    } else {
      print('Connection: Connected');
      return true;
    }
  }

  static String getDateFromMillsec(int timestamp, String dateFormat) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var formattedDate = DateFormat(dateFormat).format(date);
    return formattedDate.toString();
  }

  static String listGenreToString({required List<String> value}) {
    return value
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .capitalize
        .toString();
  }

  static int getDeviceTimeStamp() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  static String limitationText(String text, {int maxLength = 20}) {
    return text.length > maxLength
        ? text.substring(0, maxLength) + '...'
        : text;
  }

  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
