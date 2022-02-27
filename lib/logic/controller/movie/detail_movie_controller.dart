import 'package:elemovie/config/app_data.dart';
import 'package:elemovie/logic/controller/movie/favorite_movie_controller.dart';
import 'package:elemovie/logic/helper/utility.dart';
import 'package:elemovie/logic/model/movie_review_model.dart';
import 'package:elemovie/logic/model/movie_tv_model.dart';
import 'package:elemovie/logic/service/movie_database_service.dart';
import 'package:elemovie/ui/helper/dialog_utils.dart';
import 'package:elemovie/ui/widget/main_button_widget.dart';
import 'package:elemovie/ui/widget/main_rating_widget.dart';
import 'package:elemovie/ui/widget/main_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailMovieController {
  final database = MovieDatabaseService.instance;
  MovieTvModel movieModel = Get.arguments['model'];
  var userModel = AppData.currentUserModel;
  var currentFavoriteList = AppData.movieFavoriteList ?? [];
  var isUserAlreadyRate = false.obs;
  var isFavorite = false.obs;
  var userListReview = <MovieReviewModel>[].obs;

  void refreshPrevController() {
    try {
      var prevController = Get.find<FavoriteMovieController>();
      prevController.movieFavoriteList.value = currentFavoriteList;
      prevController.movieFavoriteList.refresh();
    } catch (e) {}
  }

  void onFavoriteMovie() {
    if (checkIsAvailableFavorite()) {
      currentFavoriteList.removeWhere((element) => element.id == movieModel.id);
    } else {
      currentFavoriteList.add(movieModel);
    }
    isFavorite.value = !isFavorite.value;
    AppData.movieFavoriteList = currentFavoriteList;
    refreshPrevController();
  }

  bool checkIsAvailableFavorite() =>
      currentFavoriteList
          .firstWhereOrNull((element) => element.id == movieModel.id) !=
      null;

  void onCheckMovieIsFavorite() {
    isFavorite.value = checkIsAvailableFavorite();
  }

  void initializeData() {
    onCheckMovieIsFavorite();
    onCheckUserIsAlreadyRate();
  }

  void onCheckUserIsAlreadyRate() async {
    var listDb = await database.getList();
    if (listDb.isNotEmpty) {
      String idMovie = (movieModel.id ?? 0).toString();
      var listToModel = listDb.map((e) => MovieReviewModel.fromMap(e)).toList();
      isUserAlreadyRate.value = listToModel.firstWhereOrNull((element) =>
              element.id_movie == idMovie &&
              element.userid_movie == (userModel?.user_name ?? '')) !=
          null;
      userListReview.value =
          listToModel.where((element) => element.id_movie == idMovie).toList();
    }
  }

  void onRateMovie() {
    var opinionController = TextEditingController().obs;
    var opinionError = ''.obs;
    double rateDouble = 0;

    void onStartRate() async {
      bool isAllPass = true;
      String opinion = opinionController.value.text;

      if (opinionError.value.isNotEmpty) isAllPass = false;
      if (opinion.isEmpty) {
        opinionError.value = 'required'.tr;
        isAllPass = false;
      }

      if (isAllPass) {
        var val = MovieReviewModel(
            id_movie: movieModel.id?.toString(),
            username_movie: userModel?.user_fullname ?? '',
            userid_movie: userModel?.user_name ?? '',
            userimage_movie: userModel?.user_image ?? '',
            rate_movie: rateDouble,
            review_movie: opinion);
        var valdb = await database.create(value: val.toMap());
        Utility.showToast('success_save_information'.tr);
        onCheckUserIsAlreadyRate();
        Get.back();
      }
    }

    DialogUtils.showGeneralDrawer(
        radius: 30,
        padding: EdgeInsets.all(16),
        withStrip: true,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MainRatingWidget(
              initialRating: 0,
              itemSize: 45,
              onResultRating: (d) => rateDouble = d,
            ),
            SizedBox(
              height: 16,
            ),
            Obx(
              () => MainTextFieldWidget(
                  errorText: opinionError,
                  hint: 'write_opinion'.tr,
                  controller: opinionController.value),
            ),
            SizedBox(
              height: 30,
            ),
            MainButtonWidget(text: 'save'.tr, onPressed: () => onStartRate()),
          ],
        ));
  }
}
