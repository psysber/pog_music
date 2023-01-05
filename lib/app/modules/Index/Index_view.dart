import 'package:flutter/material.dart';
import 'package:pog_music/app/global.dart';
import 'package:pog_music/app/modules/Index/Index_controller.dart';
import 'package:pog_music/app/modules/home/home_view.dart';
import 'package:pog_music/app/modules/login/login_view.dart';
import 'package:pog_music/app/modules/splash/spalsh_view.dart';
import 'package:get/get.dart';

class IndexPage extends GetView<IndexController> {
  const IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => IndexController());
    return Obx(() => Scaffold(
          body: controller.isloadWelcomePage.isTrue
              ? SplashPage()
              : Global.isOfflineLogin
                  ? HomePage()
                  : LoginPage(),
        ));
  }
}
