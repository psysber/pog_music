import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyrics_log.dart';
import 'package:flutter_lyric/lyrics_model_builder.dart';
import 'package:flutter_lyric/lyrics_reader_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pog_music/app/modules/player/services/audio_manage.dart';

import '../../../components/customerLyricUI.dart';
import '../../../components/playerBottomNavigationBar.dart';
import '../controllers/player_controller.dart';
import '../notifiers/play_button_notifier.dart';
import '../notifiers/progress_notifier.dart';
import '../notifiers/repeat_button_notifier.dart';

class PlayerView extends GetView<PlayerController> {
  const PlayerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: Color(0x7EF6F6F6),
            elevation: 0,
            centerTitle: true,
            title: Container(
              width: 230.w,
              child: ValueListenableBuilder<MediaItem>(
                builder: (_, value, __) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        controller: controller.appBarScrollController,
                        child: Text(
                          "${value.title}",
                          style: TextStyle(
                              fontSize: 20, overflow: TextOverflow.fade),
                        ),
                      ),
                      Text(
                        "${value.extras!['singer']}",
                        style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                      )
                    ],
                  );
                },
                valueListenable: AudioManage.currentSongNotifier,
              ),
            )),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.only(top: 90.h),
            decoration: BoxDecoration(
              image: DecorationImage(
                  opacity: .1,
                  image: NetworkImage(
                      "https://ccgoat.oss-cn-hongkong.aliyuncs.com/images/5qp085eo9f491.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                GetBuilder<PlayerController>(
                  init: controller,
                  builder: (controller) {
                    Widget? widget;
                    if (!controller.swScreen) {
                      widget = InkWell(
                          onTap: () => controller.onSwScreen(),
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          child: ValueListenableBuilder<ButtonState>(
                            builder: (_, value, __) {
                              if (value != ButtonState.playing) {
                                controller.animatePause();
                              } else {
                                controller.animatePlay();
                              }
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                      top: 70.h,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            child: Image.asset(
                                              "assets/images/record.png",
                                              width: 300.sp,
                                              height: 300.sp,
                                            ),
                                          ),
                                          RotationTransition(
                                            turns: controller.recordController,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(160),
                                              child: Image.network(
                                                "https://ccgoat.oss-cn-hongkong.aliyuncs.com/images/5qp085eo9f491.jpg",
                                                height: 160.sp,
                                                width: 160.sp,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                  Positioned(
                                    top: 0.h,
                                    left: 100.w,
                                    child: RotationTransition(
                                      turns: controller.pointController,
                                      alignment: Alignment.topLeft,
                                      child: Image.asset(
                                        "assets/images/record-point.png",
                                        width: 150,
                                        height: 130,
                                      ),
                                    ),
                                    //   ],
                                  ),
                                ],
                              );
                            },
                            valueListenable: AudioManage.playButtonNotifier,
                          ));
                    } else {
                      widget = Container(
                          width: double.infinity,
                          constraints: BoxConstraints.expand(),
                          padding: EdgeInsets.only(top: 60.sp),
                          child: FutureBuilder<dynamic>(
                            future: controller.getLyric(
                                AudioManage.currentSongNotifier.value.id),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasError) {
                                  // 请求失败，显示错误
                                  return Text("Error: ${snapshot.error}");
                                } else {
                                  // 请求成功，显示数据
                                  // return SubLyrics();
                                  if (snapshot.data == '') {
                                    return InkWell(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      child: Center(
                                        child: Text('暂无歌词'),
                                      ),
                                      onTap: controller.onSwScreen,
                                    );
                                  } else {
                                    return LyricView(lyric: snapshot.data);
                                  }
                                }
                              } else {
                                // 请求未结束，显示loading
                                return SizedBox();
                              }
                            },
                          ));
                    }
                    ;
                    return AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(child: child, opacity: animation);
                      },
                      child: widget,
                    );
                  },
                ),
                Container(
                    height: 150.h,
                    width: double.infinity,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        // color: AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.download),
                              iconSize: 20.sp,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.favorite),
                              iconSize: 20.sp,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.collections_bookmark),
                              iconSize: 20.sp,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.more_vert),
                              iconSize: 20.sp,
                            ),
                          ],
                        ),
                        AudioProcessBar(),
                        AudioControlButtons(),
                      ],
                    ))
              ],
            )));
  }
}

final controllerButtonStyle = ButtonStyle(
    side: MaterialStateProperty.all(BorderSide(
  color: Colors.black,
  width: 1,
)));

class AudioControlButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RepeatButton(),
            PreviousSongButton(),
            PlayButton(),
            NextSongButton(),
            IconButton(
              onPressed: () {
                Get.bottomSheet(playListBottomSheet(),
                    backgroundColor: Colors.white);
              },
              icon: Icon(Icons.menu_open),
              iconSize: 30.sp,
            ),
          ],
        ));
  }
}

class AudioProcessBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioManage = AudioManage?.getInstance();
    // TODO: implement build
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: AudioManage.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          barHeight: 3.0,
          thumbRadius: 5,
          thumbGlowRadius: 20,
          timeLabelTextStyle: TextStyle(fontSize: 10.sp, color: Colors.black),
          baseBarColor: Color(0xFF120338),
          bufferedBarColor: Color(0xFFD3ADF7),
          thumbColor: Color(0xFF722ED1),
          progressBarColor: Color(0xFFB37FEB),
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek: audioManage?.seek,
          timeLabelLocation: TimeLabelLocation.sides,
        );
      },
    );
  }
}

class PreviousSongButton extends StatelessWidget {
  final audioManage = AudioManage?.getInstance();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ValueListenableBuilder<bool>(
      valueListenable: AudioManage.isFirstSongNotifier,
      builder: (_, isFirst, __) {
        return IconButton(
          style: controllerButtonStyle,
          onPressed: (isFirst) ? null : () => audioManage?.previous(),
          icon: Icon(Icons.skip_previous_outlined),
          iconSize: 32.sp,
        );
      },
    );
  }
}

class NextSongButton extends StatelessWidget {
  final audioManage = AudioManage?.getInstance();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ValueListenableBuilder<bool>(
      valueListenable: AudioManage.isLastSongNotifier,
      builder: (_, isLast, __) {
        return IconButton(
          style: controllerButtonStyle,
          onPressed: (isLast) ? null : audioManage?.next,
          icon: Icon(Icons.skip_next_outlined),
          iconSize: 32.sp,
        );
      },
    );
  }
}

class PlayButton<T> extends StatelessWidget {
  final audioManage = AudioManage?.getInstance();

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return ValueListenableBuilder<ButtonState>(
      valueListenable: AudioManage.playButtonNotifier,
      builder: (BuildContext context, value, Widget? child) {
        switch (value) {
          case ButtonState.loading:
            return Container(
              margin: const EdgeInsets.all(8.0),
              width: 32.0.sp,
              height: 32.0.sp,
              child: const CircularProgressIndicator(),
            );
          case ButtonState.paused:
            return IconButton(
              icon: const Icon(Icons.play_arrow),
              iconSize: 32.0.sp,
              onPressed: controller.play,
              style: controllerButtonStyle,
            );
          case ButtonState.playing:
            return IconButton(
              icon: const Icon(Icons.pause),
              iconSize: 32.0.sp,
              onPressed: controller.pause,
              style: controllerButtonStyle,
            );
          default:
            return IconButton(
              icon: const Icon(Icons.play_arrow),
              iconSize: 32.0.sp,
              onPressed: controller.play,
              style: controllerButtonStyle,
            );
        }
      },
    );
  }
}

class RepeatButton extends StatelessWidget {
  RepeatButton({Key? key}) : super(key: key);
  final audioManage = AudioManage?.getInstance();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<RepeatState>(
      valueListenable: AudioManage.repeatButtonNotifier,
      builder: (context, value, child) {
        Icon icon;
        switch (value) {
          case RepeatState.repeatPlaylist:
            icon = Icon(Icons.repeat);
            break;
          case RepeatState.off:
            icon = Icon(Icons.shuffle);
            break;
          case RepeatState.repeatSong:
            icon = Icon(Icons.repeat_one);
            break;
        }
        return IconButton(
          icon: icon,
          onPressed: audioManage?.repeat,
        );
      },
    );
  }
}

class LyricView extends StatelessWidget {
  var lyricUI = CustomerLyricUI();

  var lyricPadding = 0.0;
  final _controller = Get.put(PlayerController());
  String? lyric;

  LyricView({Key? key, required this.lyric}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lyricModel = LyricsModelBuilder.create()
        .bindLyricToMain(lyric!) // .bindLyricToExt(transLyric)
        .getModel();
    return ValueListenableBuilder<ProgressBarState>(
        valueListenable: AudioManage.progressNotifier,
        builder: (_, value, __) {
          return LyricsReader(
            onTap: () => _controller.onSwScreen(),
            padding: EdgeInsets.symmetric(horizontal: lyricPadding),
            model: lyricModel,
            position: value.current.inMilliseconds,
            lyricUi: lyricUI,
            playing:
                AudioManage.playButtonNotifier.value != ButtonState.playing,
            size: Size(double.infinity, MediaQuery.of(context).size.height / 2),
            emptyBuilder: () => Center(
              child: Text(
                "No lyrics",
                style: lyricUI.getOtherMainTextStyle(),
              ),
            ),
            selectLineBuilder: (progress, confirm) {
              return Row(
                children: [
                  IconButton(
                      onPressed: () {
                        LyricsLog.logD("点击事件");
                        confirm.call();
                        AudioManage.getInstance()
                            ?.seek(Duration(milliseconds: progress));
                      },
                      icon: Icon(Icons.play_arrow_rounded,
                          color: Colors.deepPurpleAccent)),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(color: Colors.deepPurpleAccent),
                      height: 1,
                      width: double.infinity,
                    ),
                  ),
                  Text(
                    _controller.getTimeString(Duration(milliseconds: progress)),
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  )
                ],
              );
            },
          );
        });
  }
}
