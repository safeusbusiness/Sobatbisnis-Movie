import 'dart:convert';

import 'package:elemovie/logic/model/app_settings_model.dart';
import 'package:elemovie/logic/model/movie_tv_model.dart';
import 'package:elemovie/logic/model/user_model.dart';
import 'package:elemovie/logic/service/local_storage_service.dart';

class AppData {
  static AppSettingsModel? get appSettingsModel {
    if (LocalStorageService.getFromDisk('appSettingsData') != null) {
      return AppSettingsModel.fromMap(
          jsonDecode(LocalStorageService.getFromDisk('appSettingsData')));
    }
    return null;
  }

  static set appSettingsModel(AppSettingsModel? value) =>
      LocalStorageService.saveToDisk('appSettingsData', value?.toJson());

  static List<MovieTvModel>? get movieFavoriteList {
    if (LocalStorageService.getFromDisk('movieFavoriteListData') != null) {
      List<String> listData =
          LocalStorageService.getFromDisk('movieFavoriteListData');
      return listData.map((e) => MovieTvModel.fromMap(jsonDecode(e))).toList();
    }
    return null;
  }

  static set movieFavoriteList(List<MovieTvModel>? value) {
    if (value != null) {
      List<String> listString = value.map((e) => e.toJson()).toList();
      LocalStorageService.saveToDisk('movieFavoriteListData', listString);
    } else {
      LocalStorageService.saveToDisk('movieFavoriteListData', null);
    }
  }

  static List<MovieTvModel>? get tvListSave {
    if (LocalStorageService.getFromDisk('tvListSave') != null) {
      List<String> listData = LocalStorageService.getFromDisk('tvListSave');
      return listData.map((e) => MovieTvModel.fromMap(jsonDecode(e))).toList();
    }
    return null;
  }

  static set tvListSave(List<MovieTvModel>? value) {
    if (value != null) {
      List<String> listString = value.map((e) => e.toJson()).toList();
      LocalStorageService.saveToDisk('tvListSave', listString);
    } else {
      LocalStorageService.saveToDisk('tvListSave', null);
    }
  }

  static List<MovieTvModel>? get movieListSave {
    if (LocalStorageService.getFromDisk('movieListSave') != null) {
      List<String> listData = LocalStorageService.getFromDisk('movieListSave');
      return listData.map((e) => MovieTvModel.fromMap(jsonDecode(e))).toList();
    }
    return null;
  }

  static set movieListSave(List<MovieTvModel>? value) {
    if (value != null) {
      List<String> listString = value.map((e) => e.toJson()).toList();
      LocalStorageService.saveToDisk('movieListSave', listString);
    } else {
      LocalStorageService.saveToDisk('movieListSave', null);
    }
  }

  static List<UserModel>? get userModelList {
    if (LocalStorageService.getFromDisk('userDataList') != null) {
      List<String> listData = LocalStorageService.getFromDisk('userDataList');
      return listData.map((e) => UserModel.fromMap(jsonDecode(e))).toList();
    }
    return null;
  }

  static set userModelList(List<UserModel>? value) {
    if (value != null) {
      List<String> listString = value.map((e) => e.toJson()).toList();
      LocalStorageService.saveToDisk('userDataList', listString);
    } else {
      LocalStorageService.saveToDisk('userDataList', null);
    }
  }

  static UserModel? get currentUserModel {
    if (LocalStorageService.getFromDisk('userData') != null) {
      return UserModel.fromMap(jsonDecode(
        LocalStorageService.getFromDisk('userData'),
      ));
    }
    return null;
  }

  static set currentUserModel(UserModel? value) =>
      LocalStorageService.saveToDisk('userData', value?.toJson());
}
