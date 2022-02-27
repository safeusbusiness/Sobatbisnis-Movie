import 'package:elemovie/config/app_data.dart';
import 'package:elemovie/config/app_theme.dart';
import 'package:elemovie/logic/controller/movie/detail_movie_controller.dart';
import 'package:elemovie/logic/model/custom_appbar_model.dart';
import 'package:elemovie/ui/widget/loading_widget.dart';
import 'package:elemovie/ui/widget/main_button_widget.dart';
import 'package:elemovie/ui/widget/main_card_top_menu_widget.dart';
import 'package:elemovie/ui/widget/main_rating_widget.dart';
import 'package:elemovie/ui/widget/main_scaffold_widget.dart';
import 'package:elemovie/ui/widget/photo_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailMovieScreen extends StatefulWidget {
  const DetailMovieScreen({Key? key}) : super(key: key);

  @override
  _DetailMovieScreenState createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  var controller = Get.put(DetailMovieController());

  @override
  Widget build(BuildContext context) {
    Widget upperContent() {
      return Stack(
        children: [
          ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height + 30));
            },
            blendMode: BlendMode.dstIn,
            child: PhotoWidget(
              boxFit: BoxFit.cover,
              photoURL: controller.movieModel.poster_path,
              borderRadius: const BorderRadius.all(Radius.zero),
              width: double.maxFinite,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.chevron_left_rounded,
                  size: 32, color: Colors.white),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(
                onPressed: () => controller.onFavoriteMovie(),
                icon: Obx(() => Icon(
                    controller.isFavorite.value
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    size: 28,
                    color: controller.isFavorite.value
                        ? AppTheme.theme.primaryColor
                        : Colors.white)),
              ),
            ),
          ),
        ],
      );
    }

    return Obx(() => MainScaffoldWidget(
          onBackPressed: () => Get.back(),
          bottomSheet: controller.isUserAlreadyRate.value
              ? SizedBox()
              : MainButtonWidget(
                  height: 45,
                  text: 'Rate this Movie',
                  onPressed: () => controller.onRateMovie(),
                ),
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScroleld) {
              return [
                SliverAppBar(
                    iconTheme: const IconThemeData(color: Colors.white),
                    shadowColor: Colors.white,
                    elevation: 0,
                    expandedHeight: 380.0,
                    floating: false,
                    pinned: false,
                    backgroundColor: AppTheme.theme.primaryColorDark,
                    automaticallyImplyLeading: false,
                    flexibleSpace: FlexibleSpaceBar(
                      background: upperContent(),
                    ))
              ];
            },
            body: SingleChildScrollView(
              child: Container(
                color: AppTheme.theme.primaryColorDark,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  (controller.movieModel.title?.isNotEmpty ??
                                          false)
                                      ? controller.movieModel.title ?? ''
                                      : controller.movieModel.name ?? '',
                                  style: AppTheme.theme.textTheme.headline3!
                                      .copyWith(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: ((controller
                                                                .movieModel
                                                                .release_date
                                                                ?.isNotEmpty ??
                                                            false)
                                                        ? controller.movieModel
                                                            .release_date
                                                        : controller.movieModel
                                                            .first_air_date)
                                                    ?.split('-')
                                                    .first ??
                                                '',
                                            style: AppTheme
                                                .theme.textTheme.bodyText1!
                                                .copyWith(
                                                    color: AppTheme
                                                        .theme.hintColor)),
                                        TextSpan(
                                            text: ' • ',
                                            style: AppTheme
                                                .theme.textTheme.bodyText1!
                                                .copyWith(
                                                    color: AppTheme
                                                        .theme.hintColor
                                                        .withOpacity(0.25))),
                                        TextSpan(
                                            text: (controller.movieModel
                                                            .runtime ??
                                                        0) >
                                                    0
                                                ? 'Runtime: ' +
                                                    (controller.movieModel
                                                                .runtime ??
                                                            0)
                                                        .toString()
                                                : controller.movieModel.status,
                                            style: AppTheme
                                                .theme.textTheme.bodyText1!
                                                .copyWith(
                                                    color: AppTheme
                                                        .theme.hintColor)),
                                      ],
                                    )),
                                SizedBox(
                                  height: 8,
                                ),
                                MainRatingWidget(
                                    itemSize: 20,
                                    initialRating:
                                        controller.movieModel.vote_average ??
                                            6.0),
                                SizedBox(
                                  height: 14,
                                ),
                                SizedBox(
                                  height: 45,
                                  child: ListView.builder(
                                    itemCount:
                                        controller.movieModel.genres?.length ??
                                            0,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: MainCardTopMenuWidget(
                                            isChecked: false,
                                            categoryName: controller.movieModel
                                                    .genres?[index].name ??
                                                ''),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            'overview'.tr,
                            textAlign: TextAlign.start,
                            style: AppTheme.theme.textTheme.headline1!
                                .copyWith(color: Colors.white),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            controller.movieModel.overview ?? '',
                            style: AppTheme.theme.textTheme.bodyText1!
                                .copyWith(color: AppTheme.theme.hintColor),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          if (controller.userListReview.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'review'.tr,
                                  textAlign: TextAlign.start,
                                  style: AppTheme.theme.textTheme.headline1!
                                      .copyWith(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ListView.builder(
                                    itemCount: controller.userListReview.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      var model =
                                          controller.userListReview[index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 16),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            PhotoWidget(
                                              photoURL:
                                                  model.userimage_movie ?? '',
                                              width: 45,
                                              height: 45,
                                            ),
                                            SizedBox(
                                              width: 16,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    model.userid_movie ==
                                                            (controller
                                                                    .userModel
                                                                    ?.user_name ??
                                                                '')
                                                        ? 'you'.tr
                                                        : model.username_movie ??
                                                            '',
                                                    style: AppTheme.theme
                                                        .textTheme.bodyText1!
                                                        .copyWith(
                                                            color: AppTheme
                                                                .theme
                                                                .hintColor),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  MainRatingWidget(
                                                      initialRating:
                                                          model.rate_movie ??
                                                              0),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    model.review_movie ?? '',
                                                    style: AppTheme.theme
                                                        .textTheme.bodyText1!
                                                        .copyWith(
                                                            color: AppTheme
                                                                .theme
                                                                .hintColor),
                                                    maxLines: 4,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                            )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  @override
  void initState() {
    controller.initializeData();
    super.initState();
  }
}
