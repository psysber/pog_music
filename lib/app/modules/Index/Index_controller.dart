import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../error_screen/error_screen_view.dart';

class IndexController extends GetxController {
  // 是否展示欢迎页
  var isloadWelcomePage = true.obs;

  @override
  void onInit() {
    super.onInit();
    ErrorPageInit();
  }

  void ErrorPageInit() {
    ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
      print(flutterErrorDetails.toString());
      return ErrorScreen();
    };
  }

  @override
  void onReady() {
    startCountdownTimer();
  }

  @override
  void onClose() {}

  // 展示欢迎页，倒计时1.5秒之后进入应用
  Future startCountdownTimer() async {
    await Future.delayed(Duration(milliseconds: 1500), () {
      isloadWelcomePage.value = false;
    });
  }
}
