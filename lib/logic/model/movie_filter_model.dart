import 'package:elemovie/logic/repo/movie_tv_repo.dart';

class MovieFilterModel {
  final int? id;
  final String? categoryName;
  final MovieSection? movieSection;
  final TvSection? tvSection;
  bool isChecked;

  MovieFilterModel(
      {this.id,
      this.tvSection,
      this.movieSection,
      this.categoryName,
      this.isChecked = false});
}
