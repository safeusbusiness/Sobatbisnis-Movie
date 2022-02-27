import 'dart:math';
import 'package:elemovie/config/app_data.dart';
import 'package:elemovie/logic/controller/base_controller.dart';
import 'package:elemovie/logic/model/movie_filter_model.dart';
import 'package:elemovie/logic/model/movie_tv_model.dart';
import 'package:elemovie/logic/repo/movie_tv_repo.dart';
import 'package:elemovie/ui/helper/dialog_utils.dart';
import 'package:elemovie/ui/screen/movie/detail_movie_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends BaseController {
  MovieTvRepo movieTvRepo = MovieTvRepo();

  var refreshController = RefreshController().obs;
  var movieList = <MovieTvModel>[].obs;
  var movieListSearch = <MovieTvModel>[].obs;
  var moviePopular = MovieTvModel().obs;
  var pickedCategoryModel = MovieFilterModel().obs;
  var pickedUpperModel = MovieFilterModel().obs;

  var upperLoading = false.obs;
  var isSearch = false.obs;
  var isMovie = true.obs;

  var moviePage = 1.obs;
  var moviePageSearch = 1.obs;

  var searchText = ''.obs;

  final _debouncer = Debouncer(delay: Duration(milliseconds: 550));

  var upperListModel = [
    MovieFilterModel(id: 1, categoryName: 'Movie', isChecked: true),
    MovieFilterModel(id: 2, categoryName: 'Tv', isChecked: false),
  ].obs;

  double getRandomRate() {
    var rate = Random().nextInt(6).toDouble();
    if (rate == 0) {
      return getRandomRate();
    } else {
      return rate;
    }
  }

  var filterListModel = [
    MovieFilterModel(
        id: 1,
        categoryName: 'Top Rated',
        isChecked: false,
        tvSection: TvSection.TOP_RATED,
        movieSection: MovieSection.TOP_RATED),
    MovieFilterModel(
        id: 2,
        categoryName: 'Upcoming',
        isChecked: false,
        tvSection: TvSection.ON_THE_AIR,
        movieSection: MovieSection.UPCOMING),
    MovieFilterModel(
        id: 3,
        categoryName: 'Now Playing',
        isChecked: true,
        tvSection: TvSection.AIRING_TODAY,
        movieSection: MovieSection.NOW_PLAYING),
    MovieFilterModel(
        id: 4,
        categoryName: 'Popular',
        isChecked: false,
        tvSection: TvSection.POPULAR,
        movieSection: MovieSection.POPULAR),
  ].obs;

  void onRefreshList() {
    movieListSearch.refresh();
    movieList.refresh();
  }

  void onClickMovie(MovieTvModel model, {int? index}) async {
    if (loadingStatus.value || model == null) {
      return;
    }
    if (model.genres == null) {
      if (index != null) {
        getItemModel(index)?.isLoading.value = true;
        onRefreshList();
      }
      var value = await movieTvRepo.onGetDetailMovieTv(
          movieId: model.id ?? 0, isMovie: isMovie.value);
      if (value != null) {
        model = value;
      }
      if (index != null) {
        getItemModel(index)?.isLoading.value = false;
        onRefreshList();
      }
    }
    Get.to(DetailMovieScreen(), arguments: {'model': model});
  }

  void onResetAllData() {
    movieList.clear();
    movieListSearch.clear();
    moviePage.value = 1;
    moviePageSearch.value = 1;
  }

  void onStartSearch(text) {
    searchText.value = text;
    movieListSearch.clear();
    setBusy();
    _debouncer.call(() {
      getSearchList(query: text);
    });
  }

  void onSearchButtonClicked() {
    isSearch.value = !isSearch.value;
    searchText.value = '';
  }

  void onCheckedCategory(int index, {bool isUpper = false}) {
    if (isUpper) {
      if (upperListModel[index].id == pickedUpperModel.value.id) {
        return;
      }
      isMovie.value = !isMovie.value;
      upperListModel.map((e) => e.isChecked = false).toList();
      upperListModel[index].isChecked = true;
      upperListModel.refresh();
      pickedUpperModel.value = upperListModel[index];
      initializeData();
    } else {
      if (filterListModel[index].id == pickedCategoryModel.value.id) {
        return;
      }
      filterListModel.map((e) => e.isChecked = false).toList();
      filterListModel[index].isChecked = true;
      filterListModel.refresh();
      pickedCategoryModel.value = filterListModel[index];
      setBusy();
      onResetAllData();
      getAllList(
          movieSection: isMovie.value
              ? pickedCategoryModel.value.movieSection ??
                  MovieSection.NOW_PLAYING
              : null,
          tvSection: !isMovie.value
              ? pickedCategoryModel.value.tvSection ?? TvSection.AIRING_TODAY
              : null);
    }
  }

  void initializeData() {
    filterListModel.sort((a, b) => a.categoryName!.compareTo(b.categoryName!));
    filterListModel.map((element) => element.isChecked = false).toList();
    filterListModel.first.isChecked = true;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setBusy();
      onResetAllData();
      upperLoading.value = true;
      getPopularItem();
      getAllList(
          movieSection: isMovie.value ? MovieSection.NOW_PLAYING : null,
          tvSection: !isMovie.value ? TvSection.AIRING_TODAY : null);
    });
  }

  void onRefreshingLoadingList({required isRefresing}) {
    if (!isSearch.value) {
      moviePage.value = isRefresing ? 1 : moviePage.value + 1;
    } else {
      moviePageSearch.value = isRefresing ? 1 : moviePageSearch.value + 1;
    }
    if (isRefresing) {
      onResetAllData();
    }
    if (isSearch.value) {
      getSearchList(query: searchText.value);
    } else {
      getAllList(
          movieSection: isMovie.value
              ? pickedCategoryModel.value.movieSection ??
                  MovieSection.NOW_PLAYING
              : null,
          tvSection: !isMovie.value
              ? pickedCategoryModel.value.tvSection ?? TvSection.AIRING_TODAY
              : null);
    }
  }

  int errorCount = 0;
  void getPopularItem() async {
    if (errorCount >= 3) {
      moviePopular.value = movieList[Random().nextInt(movieList.length)];
      upperLoading.value = false;
      return;
    }
    var value = await movieTvRepo.onGetMovieTv(
        movieDBSection: isMovie.value ? MovieSection.POPULAR : null,
        tvSection: !isMovie.value ? TvSection.POPULAR : null);
    if (value != null) {
      moviePopular.value = value[Random().nextInt(value.length)];
      upperLoading.value = false;
    } else {
      getPopularItem();
      errorCount++;
    }
  }

  MovieTvModel? getItemModel(int index) => loadingStatus.value
      ? null
      : isSearch.value && searchText.value.isNotEmpty
          ? movieListSearch[index]
          : movieList[index];

  int getItemCount() => loadingStatus.value
      ? 10
      : isSearch.value && searchText.value.isNotEmpty
          ? movieListSearch.length
          : movieList.length;

  void getAllList({MovieSection? movieSection, TvSection? tvSection}) async {
    var value = await movieTvRepo.onGetMovieTv(
        page: !isSearch.value ? moviePage.value : moviePageSearch.value,
        movieDBSection: movieSection,
        tvSection: tvSection);
    if (value != null) {
      if (movieList.isNotEmpty) {
        value.map((e) => movieList.add(e)).toList();
      } else {
        movieList.value = value;
      }
      var list =
          movieSection != null ? AppData.movieListSave : AppData.tvListSave;
      list?.addAll(movieList);
      if (movieSection != null) {
        AppData.movieListSave = list?.toSet().toList();
      } else {
        AppData.tvListSave = list?.toSet().toList();
      }
    }
    onloadCompleted();
  }

  void onRemoveDuplicate() {}

  void getSearchList({required String query}) async {
    var value =
        await movieTvRepo.onSearchMovieTv(query: query, isMovie: isMovie.value);
    if (value != null) {
      if (movieListSearch.isNotEmpty) {
        value.map((e) => movieListSearch.add(e)).toList();
      } else {
        movieListSearch.value = value;
      }
    }
    onloadCompleted();
  }

  void onloadCompleted() {
    if (refreshController.value.isRefresh) {
      refreshController.value.refreshCompleted();
    }
    if (refreshController.value.isLoading) {
      refreshController.value.loadComplete();
    }
    setIdle();
  }
}
