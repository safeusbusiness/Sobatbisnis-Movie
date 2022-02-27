import 'package:elemovie/config/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainCardTopMenuWidget extends StatelessWidget {
  bool isChecked;
  String categoryName;

  MainCardTopMenuWidget({required this.isChecked, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: isChecked ? AppTheme.theme.primaryColor : Color(0xff1b1b1f),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 14, right: 14),
        child: Center(
          child: Text(
            categoryName,
            style: AppTheme.theme.textTheme.bodyText1!.copyWith(
                color: isChecked ? Colors.white : Colors.white60,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
