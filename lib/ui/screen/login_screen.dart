import 'package:elemovie/config/app_theme.dart';
import 'package:elemovie/logic/controller/login_controller.dart';
import 'package:elemovie/ui/helper/assets.dart';
import 'package:elemovie/ui/widget/animation/sk_chasing_dots_widget.dart';
import 'package:elemovie/ui/widget/loading_widget.dart';
import 'package:elemovie/ui/widget/main_choose_country_widget.dart';
import 'package:elemovie/ui/widget/main_scaffold_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => MainScaffoldWidget(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image(
                      image: Assets.bgLeftLogin,
                      height: 300,
                    ),
                    Flexible(
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: 20, top: 20, bottom: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, bottom: 20),
                                    child: MainChooseCountryWidget(),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(controller.timeNow.value,
                                        style: AppTheme
                                            .lightTheme.textTheme.headline5!
                                            .copyWith(fontSize: 24)),
                                    AnimatedOpacity(
                                      opacity: controller.isLoadingWeather.value
                                          ? 0.0
                                          : 1.0,
                                      duration: Duration(milliseconds: 500),
                                      child: Visibility(
                                        visible:
                                            !controller.isLoadingWeather.value,
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 25),
                                              child: Image(
                                                width: 16,
                                                height: 13,
                                                image: Assets.icCloud,
                                              ),
                                            ),
                                            Container(
                                                margin: const EdgeInsets.only(
                                                    left: 8),
                                                child: Text(
                                                    controller.tempNow.value,
                                                    style: AppTheme.lightTheme
                                                        .textTheme.bodyText2)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    AnimatedOpacity(
                                      opacity: controller.isLoadingWeather.value
                                          ? 1.0
                                          : 0.0,
                                      duration: Duration(milliseconds: 500),
                                      child: Visibility(
                                        visible:
                                            controller.isLoadingWeather.value,
                                        child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 25),
                                            child: LoadingWidget
                                                .customCircularProgressindicator(
                                                    size: 12)),
                                      ),
                                    )
                                  ],
                                ),
                                Text(controller.dateNow.value,
                                    style: AppTheme
                                        .lightTheme.textTheme.bodyText2!
                                        .copyWith(color: Colors.grey[700])),
                                Container(
                                  transform:
                                      Matrix4.translationValues(-5.0, 0.0, 0.0),
                                  margin: const EdgeInsets.only(top: 30),
                                  child: Image(
                                    width: 120,
                                    image: Assets.icElemovieLogo,
                                  ),
                                ),
                                Text(
                                    "${'login_desc_1'.tr}\n${'login_desc_2'.tr}",
                                    style: AppTheme
                                        .lightTheme.textTheme.bodyText2!
                                        .copyWith(color: Colors.grey[700])),
                                const SizedBox(height: 30),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 1.0,
                            bottom: 1.0,
                            child: InkWell(
                              onTap: () {
                                controller.isRegister.value =
                                    !controller.isRegister.value;
                                controller.usernameController.value.clear();
                                controller.kataSandiController.value.clear();
                                controller.phoneNumberController.value.clear();
                              },
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(120),
                                  bottomLeft: Radius.circular(120)),
                              child: Card(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: const Radius.circular(120),
                                      bottomLeft: const Radius.circular(120)),
                                ),
                                elevation: 6,
                                margin: EdgeInsets.zero,
                                child: Container(
                                  margin: const EdgeInsets.all(16),
                                  child: Text(
                                    !controller.isRegister.value
                                        ? 'register'.tr
                                        : 'Login',
                                    style: AppTheme.theme.textTheme.headline1!
                                        .copyWith(
                                            color: AppTheme.theme.primaryColor,
                                            fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 60, bottom: 30),
                width: Get.width - 95,
                height: !controller.isRegister.value ? 102 : 155,
                child: Stack(
                  children: [
                    Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: const Radius.circular(120),
                            bottomRight: const Radius.circular(120)),
                      ),
                      elevation: 6,
                      margin: EdgeInsets.zero,
                      child: Container(
                        width: Get.width - 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                minLines: 1,
                                controller: controller.usernameController.value,
                                focusNode: controller.usernameFocus.value,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.none,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.person_rounded,
                                    size: 20,
                                  ),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintStyle: AppTheme.theme.textTheme.bodyText1!
                                      .copyWith(color: Colors.grey),
                                  hintText: 'Username',
                                  contentPadding:
                                      const EdgeInsets.only(top: 16),
                                ),
                                style: AppTheme.theme.textTheme.bodyText1,
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: Colors.grey.withOpacity(0.25),
                            ),
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                minLines: 1,
                                controller:
                                    controller.kataSandiController.value,
                                focusNode: controller.kataSandiFocus.value,
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.lock_rounded,
                                    size: 20,
                                  ),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintStyle: AppTheme.theme.textTheme.bodyText1!
                                      .copyWith(color: Colors.grey),
                                  hintText: 'password'.tr,
                                  contentPadding:
                                      const EdgeInsets.only(top: 16),
                                ),
                                style: AppTheme.theme.textTheme.bodyText1,
                              ),
                            ),
                            Visibility(
                              visible: controller.isRegister.value,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Divider(
                                    height: 1,
                                    color: Colors.grey.withOpacity(0.25),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: TextFormField(
                                      minLines: 1,
                                      controller: controller
                                          .phoneNumberController.value,
                                      focusNode:
                                          controller.phoneNumberFocus.value,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.phone_iphone_rounded,
                                          size: 20,
                                        ),
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        hintStyle: AppTheme
                                            .theme.textTheme.bodyText1!
                                            .copyWith(color: Colors.grey),
                                        hintText: '085770338593',
                                        contentPadding:
                                            const EdgeInsets.only(top: 16),
                                      ),
                                      style: AppTheme.theme.textTheme.bodyText1,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: FloatingActionButton(
                        onPressed: () => controller.loginButton(),
                        elevation: 3,
                        backgroundColor: AppTheme.theme.primaryColor,
                        child: controller.loadingStatus.value
                            ? const SkChasingDotsWidget(
                                size: 24,
                                color: Colors.white,
                              )
                            : Icon(
                                controller.isRegister.value
                                    ? Icons.check
                                    : Icons.keyboard_arrow_right_rounded,
                                color: Colors.white,
                              ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 120,
              ),
            ],
          ),
        )));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.initializeData();
  }
}
