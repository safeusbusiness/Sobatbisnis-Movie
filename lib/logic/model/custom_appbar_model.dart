import 'package:flutter/material.dart';

class CustomAppBarModel {
  
  bool isShowBackIcon;
  String? titleTextAppBar;
  List<Widget>? actionsAppBar;
  Widget? titleWidgetAppBar;
  PreferredSizeWidget? bottomAppBar;
  double elevationAppBar = 0;

  CustomAppBarModel({this.titleTextAppBar, this.actionsAppBar, this.titleWidgetAppBar, this.bottomAppBar, this.elevationAppBar = 0, this.isShowBackIcon = true});

}