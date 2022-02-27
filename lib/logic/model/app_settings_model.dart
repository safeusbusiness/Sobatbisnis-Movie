import 'dart:convert';

class AppSettingsModel {
  String? translate_language;

  AppSettingsModel({
    this.translate_language,
  });

  Map<String, dynamic> toMap() {
    return {
      'translate_language': translate_language,
    };
  }

  factory AppSettingsModel.fromMap(Map<String, dynamic> map) {
    return AppSettingsModel(
      translate_language: map['translate_language'],
    );
  }

  String toJson() => json.encode(toMap());
}
