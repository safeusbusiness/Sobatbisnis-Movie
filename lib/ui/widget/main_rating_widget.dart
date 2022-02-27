import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MainRatingWidget extends StatelessWidget {
  double initialRating;
  double itemSize;
  Function(double)? onResultRating;
  MainRatingWidget(
      {Key? key,
      required this.initialRating,
      this.itemSize = 18.0,
      this.onResultRating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: initialRating,
      minRating: 1,
      itemSize: itemSize,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        if (onResultRating != null) {
          onResultRating!(rating);
        }
      },
    );
  }
}
