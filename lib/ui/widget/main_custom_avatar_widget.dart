import 'package:flutter/material.dart';

import 'package:elemovie/config/app_theme.dart';
import 'package:elemovie/ui/helper/assets.dart';
import 'package:elemovie/ui/widget/photo_widget.dart';

class MainCustomAvatarWidget extends StatelessWidget {
  String urlImage;
  Size outSideImageSize;
  Size inSideImageSize;

  MainCustomAvatarWidget({
    Key? key,
    required this.urlImage,
    required this.outSideImageSize,
    required this.inSideImageSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(60.0),
          child: Container(
            width: outSideImageSize.width,
            height: outSideImageSize.height,
            color: AppTheme.lightTheme.primaryColor,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(60.0),
          child: PhotoWidget(
              photoURL: urlImage,
              boxFit: BoxFit.cover,
              width: inSideImageSize.width,
              height: inSideImageSize.height,
              emptyImage: Assets.icUser),
        ),
      ],
      alignment: Alignment.center,
    );
  }
}
