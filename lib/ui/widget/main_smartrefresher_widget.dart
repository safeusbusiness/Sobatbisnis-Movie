import 'package:elemovie/config/app_theme.dart';
import 'package:elemovie/ui/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MainSmartRefresherWidget extends StatelessWidget {
  bool enablePullDown;
  bool enablePullUp;
  Function? onLoading;
  Function? onRefresh;
  RefreshController? controller;
  Widget child;

  MainSmartRefresherWidget(
      {this.enablePullDown = true,
      this.enablePullUp = true,
      this.onLoading,
      this.controller,
      required this.child,
      this.onRefresh});

  @override
  Widget build(BuildContext context) {
    Widget bodyWidget(IconData icon, String text) => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 23,
              color: AppTheme.theme.hintColor,
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              text,
              style: AppTheme.theme.textTheme.bodyText2!
                  .copyWith(color: AppTheme.theme.hintColor),
            )
          ],
        );

    return RefreshConfiguration(
      headerBuilder: () => WaterDropMaterialHeader(
        backgroundColor: AppTheme.theme.primaryColor,
      ),
      headerTriggerDistance: 80.0,
      springDescription:
          SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
      maxOverScrollExtent: 100,
      maxUnderScrollExtent: 0,
      enableScrollWhenRefreshCompleted: true,
      enableLoadingWhenFailed: true,
      hideFooterWhenNotFull: false,
      enableBallisticLoad: true,
      child: SmartRefresher(
        enablePullDown: enablePullDown,
        enablePullUp: enablePullUp,
        footer: CustomFooter(
          builder: (context, mode) {
            Widget body;
            switch (mode) {
              case LoadStatus.idle:
                {
                  body = bodyWidget(Icons.refresh_rounded, "load_more".tr);
                  break;
                }
              case LoadStatus.loading:
                {
                  body = LoadingWidget.customCircularProgressindicator();
                  break;
                }
              case LoadStatus.failed:
                {
                  body = bodyWidget(Icons.error_rounded, "load_more_error".tr);
                  break;
                }
              case LoadStatus.canLoading:
                {
                  body = bodyWidget(
                      Icons.arrow_upward_rounded, "load_more_release".tr);
                  break;
                }
              default:
                {
                  body = bodyWidget(
                      Icons.hourglass_full_rounded, "load_more_no_data".tr);
                  break;
                }
            }
            return Container(
              height: 55.0,
              padding: EdgeInsets.only(bottom: 30),
              child: Center(child: body),
            );
          },
        ),
        onLoading: () {
          if (onLoading != null) onLoading!();
        },
        onRefresh: () {
          if (onRefresh != null) onRefresh!();
        },
        controller: controller!,
        child: child,
      ),
    );
  }
}
