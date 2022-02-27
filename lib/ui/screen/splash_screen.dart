import 'package:elemovie/logic/controller/splash_controller.dart';
import 'package:elemovie/ui/helper/assets.dart';
import 'package:elemovie/ui/widget/loading_widget.dart';
import 'package:elemovie/ui/widget/main_scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return MainScaffoldWidget(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: Assets.icElemovieLogo,
              width: 160,
            ),
            SizedBox(
              height: 30,
            ),
            LoadingWidget.customCircularProgressindicator()
          ],
        ),
      ),
      onBackPressed: () {},
    );
  }

  @override
  void initState() {
    controller.initializeData();
    super.initState();
  }
}
