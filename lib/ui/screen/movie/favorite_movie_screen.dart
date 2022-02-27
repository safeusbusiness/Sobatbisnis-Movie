import 'package:elemovie/config/app_theme.dart';
import 'package:elemovie/logic/controller/movie/favorite_movie_controller.dart';
import 'package:elemovie/logic/helper/utility.dart';
import 'package:elemovie/logic/model/custom_appbar_model.dart';
import 'package:elemovie/ui/screen/movie/detail_movie_screen.dart';
import 'package:elemovie/ui/widget/main_empty_data_widget.dart';
import 'package:elemovie/ui/widget/main_item_movie_widget.dart';
import 'package:elemovie/ui/widget/main_scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteMovieScreen extends StatelessWidget {
  var controller = Get.put(FavoriteMovieController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => MainScaffoldWidget(
        body: controller.movieFavoriteList.isNotEmpty
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'your_favorite_movie_tv'.tr,
                        style: AppTheme.theme.textTheme.headline2!.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.movieFavoriteList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 16),
                              child: MainItemMovieWidget(
                                  onTap: () => Get.to(DetailMovieScreen(),
                                      arguments: {'model': controller.movieFavoriteList[index]}),
                                  isLoadingItem: false,
                                  posterUrl: controller.movieFavoriteList[index]
                                          .poster_path ??
                                      '',
                                  isPosterLoading: controller
                                      .movieFavoriteList[index].isLoading.value,
                                  title: (controller.movieFavoriteList[index].title?.isNotEmpty ?? false)
                                      ? controller.movieFavoriteList[index].title ??
                                          ''
                                      : controller.movieFavoriteList[index].name ??
                                          '',
                                  year: (controller.movieFavoriteList[index]
                                              .release_date?.isNotEmpty ??
                                          false)
                                      ? controller.movieFavoriteList[index].release_date ?? ''
                                      : controller.movieFavoriteList[index].first_air_date ?? '',
                                  posterSize: Size(90, 120),
                                  genre: Utility.listGenreToString(value: controller.movieFavoriteList[index].genres?.map((e) => e.name ?? '').toList() ?? []),
                                  rating: controller.movieFavoriteList[index].vote_average ?? 6.0),
                            );
                          }),
                    ],
                  ),
                ),
              )
            : MainEmptyDataWidget(title: 'no_favorit_movie'.tr)));
  }
}
