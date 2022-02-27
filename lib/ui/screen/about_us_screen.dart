import 'package:elemovie/config/app_theme.dart';
import 'package:elemovie/logic/model/custom_appbar_model.dart';
import 'package:elemovie/ui/helper/assets.dart';
import 'package:elemovie/ui/widget/main_click_custom_widget.dart';
import 'package:elemovie/ui/widget/main_scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  final String myPhoneNumber = '+6285770338593';
  final String myEmail = 'gerzhahp@gmail.com';
  final String descSendMessage = "interested".tr;

  @override
  Widget build(BuildContext context) {
    Widget itemWidget(
        {required IconData icon,
        required String value,
        required Function() onTap}) {
      return MainClickCustomWidget(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 23,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  value,
                  style: AppTheme.theme.textTheme.bodyText1!
                      .copyWith(color: Colors.white),
                )
              ],
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: Colors.white70,
              size: 30,
            ),
          ],
        ),
      );
    }

    return MainScaffoldWidget(
      onBackPressed: () => Get.back(),
      body: Stack(
        children: [
          Image(
            fit: BoxFit.cover,
            image: Assets.bgAboutUs,
            width: double.maxFinite,
            height: double.maxFinite,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MainClickCustomWidget(
                    onTap: () => Get.back(),
                    child: CircleAvatar(
                        backgroundColor: AppTheme.theme.primaryColor,
                        radius: 18,
                        child: Icon(
                          Icons.close_rounded,
                          size: 20,
                          color: Colors.white,
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Image(
                    image: Assets.icElemovieLogo,
                    width: 120,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'title_about_us'.tr,
                    style: GoogleFonts.bebasNeue()
                        .copyWith(color: Colors.white, fontSize: 28),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 1,
                    color: Colors.white.withOpacity(0.35),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'about_developer'.tr,
                          style: GoogleFonts.bebasNeue()
                              .copyWith(color: Colors.white, fontSize: 24),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.white.withOpacity(0.35),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(120),
                              child: Image(
                                image: Assets.icMe,
                                height: 65,
                                width: 65,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Gerzha Hayat Prakarsha',
                                  style: AppTheme.theme.textTheme.headline1!
                                      .copyWith(color: Colors.white),
                                ),
                                Text(
                                  'Lead Mobile Developer',
                                  style: AppTheme.theme.textTheme.headline1!
                                      .copyWith(
                                          color: Colors.white.withOpacity(0.45),
                                          fontSize: 14),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'developer_contact'.tr,
                        style: GoogleFonts.bebasNeue()
                            .copyWith(color: Colors.white, fontSize: 24),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        height: 1,
                        color: Colors.white.withOpacity(0.35),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      itemWidget(
                          icon: Icons.email_rounded,
                          value: myEmail,
                          onTap: () {
                            final Uri params = Uri(
                              scheme: 'mailto',
                              path: myEmail,
                              query:
                                  'subject=${'accepted_send_email'.tr} Feedback&body=$descSendMessage',
                            );
                            launch(params.toString());
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      itemWidget(
                          icon: Icons.phone_rounded,
                          value: myPhoneNumber,
                          onTap: () => launch(
                              "https://wa.me/$myPhoneNumber?text=$descSendMessage"))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
