import 'dart:async';

import 'package:elemovie/config/app_data.dart';
import 'package:elemovie/logic/helper/utility.dart';
import 'package:elemovie/logic/model/movie_tv_model.dart';
import 'package:elemovie/logic/service/api_service.dart';

enum MovieSection { TOP_RATED, UPCOMING, NOW_PLAYING, POPULAR }
enum TvSection { AIRING_TODAY, ON_THE_AIR, TOP_RATED, POPULAR }

class MovieTvRepo {
  final ApiService _apiService = ApiService('https://api.themoviedb.org/');
  final String key = 'f36f1537551d1263aed9d5f86ff68b56';

  Future<MovieTvModel?> onGetDetailMovieTv(
      {required int movieId, bool isMovie = true}) async {
    var value = await _apiService.call(
        '3/${isMovie ? 'movie' : 'tv'}/$movieId?api_key=$key&language=en-US');
    if (value.statusCode == 200) {
      return MovieTvModel.fromMap(value.data);
    } else {
      return null;
    }
  }

  Future<List<MovieTvModel>> onGetListDetailMovieTv(
      {required List<MovieTvModel> list, bool isMovie = true}) async {
    Completer<List<MovieTvModel>> completer = Completer();
    for (int i = 0; i < list.length; i++) {
      var valueDetail =
          await onGetDetailMovieTv(movieId: list[i].id ?? 0, isMovie: isMovie);
      if (valueDetail != null) {
        list[i] = valueDetail;
      }
      if (i == list.length - 1 && !completer.isCompleted) {
        completer.complete(list);
      }
    }
    return await completer.future;
  }

  Future<List<MovieTvModel>?> onGetMovieTv(
      {int page = 1,
      MovieSection? movieDBSection,
      TvSection? tvSection}) async {
    String sectionString = '';
    String sectionName = 'movie';
    if (movieDBSection != null) {
      switch (movieDBSection) {
        case MovieSection.TOP_RATED:
          sectionString = 'top_rated';
          break;
        case MovieSection.UPCOMING:
          sectionString = 'upcoming';
          break;
        case MovieSection.NOW_PLAYING:
          sectionString = 'now_playing';
          break;
        case MovieSection.POPULAR:
          sectionString = 'popular';
          break;
      }
    } else {
      sectionName = 'tv';
      switch (tvSection!) {
        case TvSection.AIRING_TODAY:
          sectionString = 'airing_today';
          break;
        case TvSection.ON_THE_AIR:
          sectionString = 'on_the_air';
          break;
        case TvSection.TOP_RATED:
          sectionString = 'top_rated';
          break;
        case TvSection.POPULAR:
          sectionString = 'popular';
          break;
      }
    }
    if (await Utility.isConnectedInternet()) {
      var value = await _apiService.call(
          '3/$sectionName/$sectionString?api_key=$key&language=en-US&page=$page',
          method: MethodRequest.GET);
      if (value.statusCode == 200) {
        var list = List.from(value.data['results']).map((e) {
          var model = MovieTvModel.fromMap(e);
          model.section = sectionString;
          return model;
        }).toList();
        return await onGetListDetailMovieTv(
            list: list, isMovie: movieDBSection != null);
      } else {
        return null;
      }
    } else {
      var list =
          movieDBSection != null ? AppData.movieListSave : AppData.tvListSave;
      return list
          ?.where((element) => element.section == sectionString)
          .toList();
    }
  }

  Future<List<MovieTvModel>?> onSearchMovieTv(
      {required String query, int page = 1, bool isMovie = true}) async {
    if (await Utility.isConnectedInternet()) {
      var value = await _apiService.call(
          '3/search/${isMovie ? 'movie' : 'tv'}?api_key=$key&query=$query&page=$page');
      if (value.statusCode == 200) {
        var list = List.from(value.data['results'])
            .map((e) => MovieTvModel.fromMap(e))
            .toList();
        return list;
      } else {
        return null;
      }
    } else {
      List<MovieTvModel> listFiltered = [];
      var list = isMovie ? AppData.movieListSave : AppData.tvListSave;
      list?.map((e) {
        if (e.name?.contains(query) ?? false) {
          listFiltered.add(e);
        }
      }).toList();
      return list;
    }
  }
}
