import 'dart:io';

import 'package:elemovie/config/app_theme.dart';
import 'package:elemovie/logic/model/custom_appbar_model.dart';
import 'package:elemovie/ui/widget/main_scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewScreen extends StatelessWidget {
  final String urlPhoto;
  const PhotoViewScreen({Key? key, required this.urlPhoto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget imageProvider(ImageProvider image) => PhotoView(
          imageProvider: image,
          loadingBuilder: (context, loadingProgress) {
            return Center(
              child: SizedBox(
                  width: 45,
                  height: 45,
                  child: CircularProgressIndicator(
                    backgroundColor: AppTheme.theme.primaryColor,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.white),
                    value: (loadingProgress?.expectedTotalBytes ?? 0) != 0
                        ? ((loadingProgress?.cumulativeBytesLoaded ?? 0) /
                            int.parse((loadingProgress?.expectedTotalBytes ?? 0)
                                .toString()))
                        : 0,
                  )),
            );
          },
        );

    return MainScaffoldWidget(
        onBackPressed: () => Get.back(),
        appBar: CustomAppBarModel(titleTextAppBar: 'see_photo'.tr),
        body: Uri.parse(urlPhoto).isAbsolute
            ? imageProvider(NetworkImage(urlPhoto))
            : imageProvider(FileImage(File(urlPhoto))));
  }
}
