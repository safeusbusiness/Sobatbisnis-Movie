import 'dart:convert';

import 'package:elemovie/logic/service/encrypt_decrypt_service.dart';

class UserModel {
  String? user_name;
  String? user_fullname;
  String? user_password;
  String? user_phone;
  String? user_image;

  UserModel({
    this.user_name,
    this.user_fullname,
    this.user_password,
    this.user_phone,
    this.user_image,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_name': EncryptDecryptService.encryptDecryptData(content: user_name),
      'user_fullname':
          EncryptDecryptService.encryptDecryptData(content: user_fullname),
      'user_password':
          EncryptDecryptService.encryptDecryptData(content: user_password),
      'user_phone':
          EncryptDecryptService.encryptDecryptData(content: user_phone),
      'user_image':
          EncryptDecryptService.encryptDecryptData(content: user_image),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      user_name: map['user_name'] != ''
          ? EncryptDecryptService.encryptDecryptData(
              content: map['user_name'], isEncrypt: false)
          : '',
      user_fullname: map['user_fullname'] != ''
          ? EncryptDecryptService.encryptDecryptData(
              content: map['user_fullname'], isEncrypt: false)
          : '',
      user_password: map['user_password'] != ''
          ? EncryptDecryptService.encryptDecryptData(
              content: map['user_password'], isEncrypt: false)
          : '',
      user_phone: map['user_phone'] != ''
          ? EncryptDecryptService.encryptDecryptData(
              content: map['user_phone'], isEncrypt: false)
          : '',
      user_image: map['user_image'] != ''
          ? EncryptDecryptService.encryptDecryptData(
              content: map['user_image'], isEncrypt: false)
          : '',
    );
  }

  String toJson() => json.encode(toMap());
}
