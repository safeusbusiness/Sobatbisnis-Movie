import 'package:elemovie/config/app_theme.dart';
import 'package:elemovie/logic/controller/home_controller.dart';
import 'package:elemovie/logic/controller/init_controller.dart';
import 'package:elemovie/ui/screen/home_screen.dart';
import 'package:elemovie/ui/screen/movie/favorite_movie_screen.dart';
import 'package:elemovie/ui/screen/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class InitScreen extends StatelessWidget {
  var controller = Get.put(InitController());
  var homeController = Get.put(HomeController());

  List<Widget> _buildScreens() {
    return [const HomeScreen(), FavoriteMovieScreen(), SettingsScreen()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(
          CupertinoIcons.home,
          size: 23,
          color: Colors.white,
        ),
        title: ("Home"),
        activeColorSecondary: Colors.white,
        textStyle:
            AppTheme.theme.textTheme.bodyText2!.copyWith(color: Colors.white),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.favorite_border_rounded,
          size: 18,
          color: Colors.white,
        ),
        title: ("Favorite"),
        activeColorSecondary: Colors.white,
        textStyle:
            AppTheme.theme.textTheme.bodyText2!.copyWith(color: Colors.white),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          CupertinoIcons.settings,
          size: 18,
          color: Colors.white,
        ),
        title: ("Settings"),
        activeColorSecondary: Colors.white,
        textStyle:
            AppTheme.theme.textTheme.bodyText2!.copyWith(color: Colors.white),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => PersistentTabView(
          context,
          controller: controller.tabController.value,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          onWillPop: (s) async => await controller.onWillPop(),
          backgroundColor: AppTheme.theme.primaryColor,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          hideNavigationBar: homeController.isSearch.value,
          stateManagement: true,
          navBarHeight: 65,
          hideNavigationBarWhenKeyboardShows: true,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: ItemAnimationProperties(
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style9,
        ));
  }
}
