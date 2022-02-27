import 'dart:convert';

class MovieReviewModel {
  String? id_movie;
  String? username_movie;
  String? userid_movie;
  String? userimage_movie;
  String? review_movie;
  double? rate_movie;
  MovieReviewModel({
    this.id_movie,
    this.username_movie,
    this.userid_movie,
    this.userimage_movie,
    this.review_movie,
    this.rate_movie,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_movie': id_movie,
      'username_movie': username_movie,
      'userid_movie': userid_movie,
      'userimage_movie': userimage_movie,
      'review_movie': review_movie,
      'rate_movie': rate_movie,
    };
  }

  factory MovieReviewModel.fromMap(Map<String, dynamic> map) {
    return MovieReviewModel(
      id_movie: map['id_movie'],
      username_movie: map['username_movie'],
      userid_movie: map['userid_movie'],
      userimage_movie: map['userimage_movie'],
      review_movie: map['review_movie'],
      rate_movie: map['rate_movie']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());
}
