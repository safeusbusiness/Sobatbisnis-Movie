import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:elemovie/config/app_theme.dart';
import 'package:elemovie/logic/helper/utility.dart';
import 'package:elemovie/ui/widget/loading_widget.dart';
import 'package:elemovie/ui/widget/main_click_custom_widget.dart';
import 'package:elemovie/ui/widget/main_rating_widget.dart';

import 'photo_widget.dart';

class MainItemMovieWidget extends StatelessWidget {
  Function() onTap;
  bool isLoadingItem;
  String posterUrl;
  Size posterSize;
  bool isPosterLoading;
  String title;
  String year;
  String genre;
  double rating;
  String? description;
  String? runTimes;

  MainItemMovieWidget(
      {Key? key,
      required this.onTap,
      required this.isLoadingItem,
      required this.posterUrl,
      required this.isPosterLoading,
      required this.title,
      required this.year,
      required this.posterSize,
      required this.genre,
      required this.rating,
      this.description,
      this.runTimes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget titleRatingGenreWidget(
        {required String title,
        required String year,
        required String genre,
        required double initialRating,
        required bool isLoading,
        String? description,
        String? runTimes}) {
      return !isLoading
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      Utility.limitationText(title, maxLength: 15),
                      style: AppTheme.theme.textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (year.isNotEmpty)
                      const SizedBox(
                        width: 5,
                      ),
                    if (year.isNotEmpty)
                      Text(
                        '(${year.split('-').first})',
                        style: AppTheme.theme.textTheme.bodyText2,
                      )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                MainRatingWidget(initialRating: initialRating),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: context.width / 2,
                  child: Text(
                    genre.capitalize ?? '',
                    style: AppTheme.theme.textTheme.bodyText2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                if (description != null)
                  SizedBox(
                    width: context.width / 2,
                    child: Text(
                      description,
                      style: AppTheme.theme.textTheme.bodyText2,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                if (description != null)
                  SizedBox(
                    height: 5,
                  ),
                if (runTimes != null)
                  Text(
                    runTimes,
                    style: AppTheme.theme.textTheme.bodyText2,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            )
          : SizedBox(
              width: context.width / 2 - 30,
              child: LoadingWidget.loadingShimmerText());
    }

    return MainClickCustomWidget(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          isLoadingItem
              ? LoadingWidget.loadingShimmerCard(
                  radius: 8, width: posterSize.width, height: posterSize.height)
              : MainPosterMovieWidget(
                  posterUrl: posterUrl,
                  isLoading: isPosterLoading,
                  posterSize: posterSize,
                ),
          SizedBox(
            width: 16,
          ),
          titleRatingGenreWidget(
              isLoading: isLoadingItem,
              title: title,
              year: year,
              genre: genre,
              description: description,
              runTimes: runTimes,
              initialRating: rating)
        ],
      ),
    );
  }
}

class MainPosterMovieWidget extends StatelessWidget {
  String posterUrl;
  bool isLoading;
  Size posterSize;

  MainPosterMovieWidget(
      {Key? key,
      required this.posterUrl,
      required this.isLoading,
      required this.posterSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: posterSize.width,
      height: posterSize.height,
      child: Stack(
        children: [
          PhotoWidget(
            isIgnoreOnClick: true,
            photoURL: posterUrl,
            width: posterSize.width,
            height: posterSize.height,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          if (isLoading)
            Center(
              child: LoadingWidget.customCircularProgressindicator(),
            )
        ],
      ),
    );
  }
}
