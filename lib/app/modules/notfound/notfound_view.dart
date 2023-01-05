import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pog_music/app/router/app_pages.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class NotfoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/2_404 Error.png",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.3,
            right: MediaQuery.of(context).size.width * 0.3,
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed("/home");
              },
              child: Text(
                "Go Home".toUpperCase(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
