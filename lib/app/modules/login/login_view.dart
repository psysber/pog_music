import 'package:flutter/material.dart';
import 'package:pog_music/app/modules/login/login_controller.dart';
import 'package:pog_music/app/router/app_pages.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Get.offAndToNamed(Routes.Home),
        child: Container(
          child: Center(
            child: Text('登录页'),
          ),
        ),
      ),
    );
  }
}
