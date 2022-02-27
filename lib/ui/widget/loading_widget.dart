import 'package:elemovie/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget {
  static Widget customCircularProgressindicator(
      {double size = 23, double? value}) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        backgroundColor: AppTheme.theme.primaryColor,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
        value: value,
      ),
    );
  }

  static Widget loadingShimmerCard(
      {double height = 230,
      double radius = 8,
      double width = double.maxFinite}) {
    return Shimmer.fromColors(
      baseColor: Color(0xff1b1b1f),
      highlightColor: Colors.grey.shade800,
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius))),
        elevation: 0,
        child: SizedBox(height: height, width: width),
      ),
    );
  }

  static Widget loadingShimmerText() {
    return Shimmer.fromColors(
      baseColor: Color(0xff1b1b1f),
      highlightColor: Colors.grey.shade800,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40,
            height: 12.0,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4))),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
          ),
          Container(
            width: double.maxFinite,
            height: 12.0,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4))),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
          ),
          Container(
            width: double.maxFinite,
            height: 12.0,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4))),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
          ),
          Container(
            width: 120,
            height: 12.0,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4))),
          ),
        ],
      ),
    );
  }
}
