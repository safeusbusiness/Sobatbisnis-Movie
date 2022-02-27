import 'dart:io';
import 'package:elemovie/config/app_theme.dart';
import 'package:elemovie/ui/helper/dialog_utils.dart';
import 'package:elemovie/ui/screen/photo_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MainFileUpload {
  final Function(File)? onChanged;
  final String? photoUrl;
  final String? photoAsset;
  final int maxSize;

  // pickImageCode 1 = Camera
  // pickImageCode 2 = Galery
  // pickImageCode 3 = Both
  MainFileUpload(
      {this.onChanged, this.photoUrl, this.photoAsset, this.maxSize = 250});

  Future<File?> getImage({ImageSource source = ImageSource.gallery}) async {
    var pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  Future showBottomDialog() async {
    Get.focusScope?.requestFocus(FocusNode());
    DialogUtils.showGeneralDrawer(
        radius: 16,
        withStrip: true,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Visibility(
              visible: photoUrl != null ? true : false,
              child: ListTile(
                  leading: new Icon(Icons.photo),
                  title: new Text('see_picture'.tr,
                      style: AppTheme.theme.textTheme.bodyText1),
                  onTap: () {
                    Get.back();
                    Get.to(PhotoViewScreen(urlPhoto: photoUrl ?? ''));
                  }),
            ),
            ListTile(
              leading: new Icon(Icons.photo),
              title: new Text('${_alreadyPickFile()} ${'from_gallery'.tr}',
                  style: AppTheme.theme.textTheme.bodyText1),
              onTap: () async {
                Get.back();
                var result = await getImage();
                if (onChanged != null && result != null) onChanged!(result);
              },
            ),
          ],
        ));
  }

  String _alreadyPickFile() => photoUrl != null ? "change".tr : "upload".tr;
}
