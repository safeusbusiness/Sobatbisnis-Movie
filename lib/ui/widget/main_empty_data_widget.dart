import 'dart:math';

import 'package:elemovie/config/app_theme.dart';
import 'package:elemovie/ui/helper/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:lottie/lottie.dart';

class MainEmptyDataWidget extends StatelessWidget {
  String title;
  bool isShow;
  MainEmptyDataWidget({required this.title, this.isShow = true});

  @override
  Widget build(BuildContext context) {
    Widget _titleWidget() => Text(
          title,
          style: AppTheme.theme.textTheme.bodyText2,
          textAlign: TextAlign.center,
        );

    Widget _itemWidget() => Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            SizedBox(
                width: 300, child: Lottie.asset(Assets.jsonLottieAstronaut)),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: _titleWidget(),
            )
          ],
        ));

    return AnimatedOpacity(
      opacity: isShow ? 1.0 : 0.0,
      duration: Duration(milliseconds: 550),
      child: Visibility(visible: isShow, child: _itemWidget()),
    );
  }
}
