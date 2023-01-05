import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pog_music/app/http/request_api.dart';
import 'package:pog_music/app/modules/player/model/lyric_model.dart';
import 'package:pog_music/app/modules/player/services/audio_manage.dart';

import '../../../utils/request.dart';
import '../notifiers/play_button_notifier.dart';

class PlayerController extends GetxController with GetTickerProviderStateMixin {
  //TODO: Implement PlayerController

  var lyric = '';

  bool swScreen = false;
  var subProgress = 0;
  ScrollController appBarScrollController = ScrollController();
  late AnimationController recordController;
  late AnimationController pointController;
  final audioManage = AudioManage.getInstance();

  @override
  onInit() {
    recordController =
        AnimationController(duration: Duration(seconds: 20), vsync: this);
    pointController = AnimationController(
      duration: Duration(milliseconds: 500),
      lowerBound: -.02,
      upperBound: .03,
      vsync: this,
    );
    super.onInit();
  }

  @override
  void onReady() {
    var buttonState = AudioManage.playButtonNotifier.value;
    if (buttonState == ButtonState.playing) {
      animatePlay();
    } else {
      animatePause();
    }
    super.onReady();
  }

  @override
  void onClose() {
    appBarScrollController.dispose();
    recordController.dispose();
    pointController.dispose();
    super.onClose();
  }

  void onSwScreen() {
    swScreen = !swScreen;
    update();
  }

  void animatePlay() {
    recordController.repeat();
    pointController.forward();
  }

  void animatePause() {
    recordController.stop();
    pointController.reverse();
  }

  void play() {
    audioManage?.play();
    update();
  }

  void pause() {
    audioManage?.pause();
    update();
  }

  String getTimeString(Duration time) {
    final minutes = time.inMinutes
        .remainder(Duration.minutesPerHour)
        .toString()
        .padLeft(2, '0');
    final seconds = time.inSeconds
        .remainder(Duration.secondsPerMinute)
        .toString()
        .padLeft(2, '0');
    return "$minutes:$seconds";
  }

  initPointController() async {
    return AnimationController(
      duration: Duration(milliseconds: 500),
      lowerBound: -.02,
      upperBound: .03,
      vsync: this,
    );
  }

  initRecordController() async {
    return AnimationController(duration: Duration(seconds: 20), vsync: this);
  }

  getLyric(id) async {
    final resp = await Dio().get(RequestApi.lyric_url + id);
    final decode = json.decode(resp.data);
    if (null == decode['lyric']) {
      return '';
    } else {
      return LyricEntity.fromJson(decode).lyric;
    }
  }
}
