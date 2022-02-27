import 'package:elemovie/config/app_data.dart';

import 'package:get/get.dart';

class FavoriteMovieController {
  var movieFavoriteList = (AppData.movieFavoriteList ?? []).obs;
}
