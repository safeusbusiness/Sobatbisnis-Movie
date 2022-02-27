import 'dart:convert';

import 'package:get/get.dart';

class MovieTvModel {
  bool? adult;
  List<dynamic>? genre_ids;
  int? id;
  String? overview;
  String? name;
  double? vote_average;
  String? poster_path;
  String? release_date;
  String? title;
  String? first_air_date;
  int? runtime;
  String? status;
  String? section;
  List<MovieGenreModel>? genres;

  var isLoading = false.obs;

  MovieTvModel({
    this.adult,
    this.genre_ids,
    this.id,
    this.status,
    this.section,
    this.name,
    this.overview,
    this.first_air_date,
    this.vote_average,
    this.poster_path,
    this.release_date,
    this.title,
    this.runtime,
    this.genres,
  });

  Map<String, dynamic> toMap() {
    return {
      'adult': adult,
      'genre_ids': genre_ids,
      'id': id,
      'overview': overview,
      'first_air_date': first_air_date,
      'vote_average': vote_average,
      'poster_path': poster_path,
      'name': name,
      'release_date': release_date,
      'title': title,
      'section': section,
      'runtime': runtime,
      'status': status,
      'genres': genres?.map((x) => x.toMap()).toList(),
    };
  }

  factory MovieTvModel.fromMap(Map<String, dynamic> map) {
    return MovieTvModel(
      adult: map['adult'],
      genre_ids: List<dynamic>.from(map['genre_ids'] ?? []),
      id: map['id']?.toInt(),
      first_air_date: map['first_air_date'],
      overview: map['overview'],
      vote_average: map['vote_average']?.toDouble(),
      name: map['name'],
      section: map['section'],
      status: map['status'],
      poster_path:
          'https://image.tmdb.org/t/p/w500/' + (map['poster_path'] ?? ''),
      release_date: map['release_date'],
      title: map['title'],
      runtime: map['runtime']?.toInt(),
      genres: map['genres'] != null
          ? List<MovieGenreModel>.from(
              map['genres']?.map((x) => MovieGenreModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());
}

class MovieGenreModel {
  int? id;
  String? name;

  MovieGenreModel({
    this.id,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory MovieGenreModel.fromMap(Map<String, dynamic> map) {
    return MovieGenreModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
}
