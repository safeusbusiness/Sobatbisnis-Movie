import 'package:elemovie/config/app_config.dart';
import 'package:elemovie/config/app_theme.dart';
import 'package:elemovie/logic/model/custom_appbar_model.dart';
import 'package:elemovie/ui/helper/assets.dart';
import 'package:flutter/material.dart';

class MainScaffoldWidget extends StatelessWidget {
  final Function()? onBackPressed;
  final CustomAppBarModel? appBar;
  final Widget? body;
  final Widget? bottomSheet;
  final Widget? floatingActionButton;
  final Color? backgroundColor;

  const MainScaffoldWidget(
      {Key? key,
      this.onBackPressed,
      this.appBar,
      this.floatingActionButton,
      required this.body,
      this.backgroundColor,
      this.bottomSheet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget shadowBody({required child}) {
      return ShaderMask(
        shaderCallback: (Rect rect) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.red,
              Colors.transparent,
              Colors.transparent,
              Colors.red
            ],
            stops: [0.0, 0.01, 1.0, 0.0],
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: child,
      );
    }

    return WillPopScope(
      onWillPop: () async => await onBackPressed!(),
      child: Scaffold(
        floatingActionButton: floatingActionButton,
        bottomSheet: bottomSheet != null
            ? Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                child: SizedBox(height: 45, child: bottomSheet),
              )
            : null,
        backgroundColor: backgroundColor ?? AppTheme.theme.primaryColorDark,
        appBar: appBar != null
            ? PreferredSize(
                preferredSize: const Size(55, kToolbarHeight),
                child: Material(
                  child: AppBar(
                    centerTitle: false,
                    systemOverlayStyle: AppConfig.topAppBarStyle(),
                    bottom: appBar?.bottomAppBar,
                    leading: appBar?.isShowBackIcon ?? true
                        ? onBackPressed != null
                            ? IconButton(
                                icon: const Icon(Icons.chevron_left_rounded,
                                    color: Colors.white, size: 30),
                                onPressed: onBackPressed,
                              )
                            : null
                        : null,
                    elevation: appBar?.elevationAppBar,
                    shadowColor: Colors.white70,
                    title: appBar?.titleWidgetAppBar ??
                        Text(appBar?.titleTextAppBar ?? '',
                            style: AppTheme.theme.textTheme.headline1!
                                .copyWith(color: Colors.white),
                            textAlign: TextAlign.left),
                    backgroundColor: AppTheme.theme.primaryColorDark,
                    actions: appBar?.actionsAppBar,
                  ),
                ),
              )
            : null,
        body: SafeArea(
          child: shadowBody(child: body),
        ),
      ),
    );
  }
}
