import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:pog_music/app/modules/player/services/audio_manage.dart';

import '../../http/request_api.dart';
import '../../utils/request.dart';

class HomeController extends GetxController {
  List<TabNavItem>? items;
  var currentIndex = 0.obs;

  final scrollController = new ScrollController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  Future<List<dynamic>> getSwiperEntity() async {
    var response = await Request().get(RequestApi.carouselUrl);
    return response["data"];
  }

  void changeIndex(int index) {
    currentIndex.value = index;
    update();
  }

  void scrollBottom() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      //build完成后的回调
      scrollController.animateTo(
        scrollController.position.maxScrollExtent, //滚动到底部
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
}

class TabNavItem {
  final String? name;
  final Color? color;
  final Icon? icon;

  TabNavItem(this.name, this.color, this.icon);
}
