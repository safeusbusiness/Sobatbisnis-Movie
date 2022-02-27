import 'dart:math';

import 'package:elemovie/config/app_theme.dart';
import 'package:elemovie/logic/controller/home_controller.dart';
import 'package:elemovie/logic/helper/utility.dart';
import 'package:elemovie/logic/model/movie_tv_model.dart';
import 'package:elemovie/ui/widget/loading_widget.dart';
import 'package:elemovie/ui/widget/main_card_top_menu_widget.dart';
import 'package:elemovie/ui/widget/main_click_custom_widget.dart';
import 'package:elemovie/ui/widget/main_item_movie_widget.dart';
import 'package:elemovie/ui/widget/main_rating_widget.dart';
import 'package:elemovie/ui/widget/main_scaffold_widget.dart';
import 'package:elemovie/ui/widget/main_smartrefresher_widget.dart';
import 'package:elemovie/ui/widget/main_textfield_widget.dart';
import 'package:elemovie/ui/widget/photo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var controller = Get.find<HomeController>();

  @override
  void initState() {
    controller.initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double upperImageSize = context.width / 2 - 50;

    Widget searchMovieWidget() {
      return SizedBox();
    }

    return Obx(() => MainScaffoldWidget(
          body: MainSmartRefresherWidget(
            enablePullDown: true,
            enablePullUp: true,
            onRefresh: () =>
                controller.onRefreshingLoadingList(isRefresing: true),
            onLoading: () =>
                controller.onRefreshingLoadingList(isRefresing: false),
            controller: controller.refreshController.value,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  if (!controller.isSearch.value)
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                          itemCount: controller.upperListModel.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: index == 0 ? 16 : 0,
                                  right: 10,
                                  bottom: 3),
                              child: InkWell(
                                onTap: () => controller.onCheckedCategory(index,
                                    isUpper: true),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                child: MainCardTopMenuWidget(
                                  isChecked: controller
                                      .upperListModel[index].isChecked,
                                  categoryName: controller
                                          .upperListModel[index].categoryName ??
                                      '',
                                ),
                              ),
                            );
                          }),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            controller.isSearch.value
                                ? Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: MainTextFieldWidget(
                                        errorText: ''.obs,
                                        hint: controller.isMovie.value
                                            ? 'find_movie'.tr
                                            : 'find_tv'.tr,
                                        textColor: Colors.white,
                                        onChange: (s) =>
                                            controller.onStartSearch(s),
                                      ),
                                    ),
                                  )
                                : Text(
                                    controller.isMovie.value
                                        ? 'top_movie_this_year'.tr
                                        : 'top_tv_this_year'.tr,
                                    style: AppTheme.theme.textTheme.headline2!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                  ),
                            controller.loadingStatus.value
                                ? LoadingWidget.customCircularProgressindicator(
                                    size: 14)
                                : InkWell(
                                    onTap: () =>
                                        controller.onSearchButtonClicked(),
                                    child: Icon(
                                      controller.isSearch.value
                                          ? Icons.close_rounded
                                          : Icons.search_rounded,
                                      color: Colors.white,
                                    ),
                                  )
                          ],
                        ),
                        if (!controller.isSearch.value)
                          SizedBox(
                            height: 16,
                          ),
                        if (!controller.isSearch.value)
                          MainItemMovieWidget(
                              onTap: () => controller
                                  .onClickMovie(controller.moviePopular.value),
                              isLoadingItem: controller.upperLoading.value,
                              posterUrl:
                                  controller.moviePopular.value.poster_path ??
                                      '',
                              isPosterLoading: false,
                              title: (controller.moviePopular.value.title?.isNotEmpty ?? false)
                                  ? controller.moviePopular.value.title ?? ''
                                  : controller.moviePopular.value.name ?? '',
                              year: (controller.moviePopular.value.release_date?.isNotEmpty ?? false)
                                  ? controller.moviePopular.value.release_date ??
                                      ''
                                  : controller.moviePopular.value.first_air_date ??
                                      '',
                              posterSize: Size(upperImageSize, 200),
                              genre: Utility.listGenreToString(
                                  value: controller.moviePopular.value.genres
                                          ?.map((e) => e.name ?? '')
                                          .toList() ??
                                      ['empty_genre'.tr]),
                              description:
                                  controller.moviePopular.value.overview,
                              runTimes: ((controller.moviePopular.value.runtime)?.toString() ?? '').isNotEmpty
                                  ? (((controller.moviePopular.value.runtime)?.toString() ?? '') +
                                      ' Minutes')
                                  : '',
                              rating: controller.moviePopular.value.vote_average ?? 6.0)
                      ],
                    ),
                  ),
                  if (!controller.isSearch.value)
                    Padding(
                      padding: EdgeInsets.only(
                          top: !controller.isSearch.value ? 16 : 0,
                          right: 16,
                          left: 16,
                          bottom: 16),
                      child: Text(
                        'suggested_movie'.tr,
                        style: AppTheme.theme.textTheme.headline2!.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  if (!controller.isSearch.value)
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                          itemCount: controller.filterListModel.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: index == 0 ? 16 : 0,
                                  right: 10,
                                  bottom: 3),
                              child: InkWell(
                                onTap: () =>
                                    controller.onCheckedCategory(index),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                child: MainCardTopMenuWidget(
                                  isChecked: controller
                                      .filterListModel[index].isChecked,
                                  categoryName: controller
                                          .filterListModel[index]
                                          .categoryName ??
                                      '',
                                ),
                              ),
                            );
                          }),
                    ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: !controller.isSearch.value ? 16 : 0,
                        right: 16,
                        left: 16,
                        bottom: 16),
                    child: controller.isSearch.value &&
                            controller.getItemCount() == 0
                        ? Center(
                            child: Text(
                              '${'cannot_find'.tr} ${controller.searchText.value}...',
                              style: AppTheme.theme.textTheme.bodyText2,
                            ),
                          )
                        : ListView.builder(
                            itemCount: controller.getItemCount(),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var movieModel = controller.getItemModel(index);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: MainItemMovieWidget(
                                    onTap: () => controller.onClickMovie(
                                        movieModel ?? MovieTvModel(),
                                        index: index),
                                    isLoadingItem:
                                        controller.loadingStatus.value,
                                    posterUrl: movieModel?.poster_path ?? '',
                                    description: null,
                                    runTimes: null,
                                    isPosterLoading:
                                        movieModel?.isLoading.value ?? false,
                                    title:
                                        (movieModel?.title?.isNotEmpty ?? false)
                                            ? movieModel?.title ?? ''
                                            : movieModel?.name ?? '',
                                    year:
                                        (movieModel?.release_date?.isNotEmpty ??
                                                false)
                                            ? movieModel?.release_date ?? ''
                                            : movieModel?.first_air_date ?? '',
                                    posterSize: Size(90, 120),
                                    genre: movieModel?.overview.toString() ??
                                        'no_description'.tr,
                                    rating: movieModel?.vote_average == 0.0
                                        ? controller.getRandomRate()
                                        : movieModel?.vote_average ?? 6.0),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
