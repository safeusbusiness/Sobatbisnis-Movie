import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:elemovie/config/app_theme.dart';
import 'package:elemovie/ui/screen/photo_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotoWidget extends StatelessWidget {
  static const String blurryImage =
      'https://ak.picdn.net/shutterstock/videos/26823310/thumb/1.jpg';

  final String? photoURL;
  final AssetImage? emptyImage;
  final BoxFit boxFit;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final bool isIgnoreOnClick;

  PhotoWidget(
      {this.photoURL = blurryImage,
      this.boxFit = BoxFit.cover,
      this.width,
      this.height,
      this.borderRadius,
      this.emptyImage,
      this.isIgnoreOnClick = false});

  Widget build(BuildContext context) {
    bool isPhotoUrlNotEmpty() => photoURL?.isNotEmpty ?? false;

    Widget itemWidget() {
      return ClipRRect(
        borderRadius:
            borderRadius ?? const BorderRadius.all(Radius.circular(120)),
        child: Uri.parse(photoURL ?? blurryImage).isAbsolute || photoURL == ''
            ? CachedNetworkImage(
                imageUrl: isPhotoUrlNotEmpty() ? photoURL! : blurryImage,
                fit: boxFit,
                width: width,
                height: height,
                errorWidget: (context, url, error) => PhotoWidget(
                    photoURL: blurryImage, borderRadius: borderRadius),
                progressIndicatorBuilder: (context, url, loadingProgress) {
                  if (loadingProgress == null)
                    return PhotoWidget(
                      photoURL: blurryImage,
                      borderRadius: borderRadius,
                    );
                  return SizedBox(
                    width: width,
                    height: height,
                    child: Center(
                      child: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            backgroundColor: AppTheme.theme.primaryColor,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.white),
                            value: loadingProgress.progress ?? 0.0,
                          )),
                    ),
                  );
                })
            : Image(
                image: FileImage(File(photoURL ?? '')),
                width: width,
                height: height,
                fit: boxFit,
              ),
      );
    }

    return !isIgnoreOnClick
        ? InkWell(
            onTap: () => isPhotoUrlNotEmpty()
                ? Get.to(PhotoViewScreen(urlPhoto: photoURL!))
                : null,
            borderRadius:
                borderRadius ?? const BorderRadius.all(Radius.circular(120)),
            child: itemWidget(),
          )
        : itemWidget();
  }
}
