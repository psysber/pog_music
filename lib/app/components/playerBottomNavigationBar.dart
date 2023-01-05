import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pog_music/app/components/scrollText.dart';
import 'package:pog_music/app/components/skeleton.dart';
import 'package:pog_music/app/modules/player/notifiers/repeat_button_notifier.dart';
import 'package:pog_music/app/modules/player/services/audio_manage.dart';

import '../modules/player/notifiers/play_button_notifier.dart';

class PlayerBottomNavigationBarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final player = AudioManage.getInstance();
  late AnimationController recordController;

  @override
  onInit() {
    recordController =
        AnimationController(duration: Duration(seconds: 20), vsync: this);
  }
}

class PlayerBottomNavigationBar
    extends GetView<PlayerBottomNavigationBarController> {
  @override
  Widget build(BuildContext context) {
    Get.put(PlayerBottomNavigationBarController());
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 5,
            child: ValueListenableBuilder<MediaItem>(
                valueListenable: AudioManage.currentSongNotifier,
                builder: (_, media, __) {
                  if ('' == media.id) {
                    return Container();
                  } else {
                    return Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(5.sp),
                            child: SizedBox(
                              width: 30.sp,
                              height: 30.sp,
                              child: ValueListenableBuilder<ButtonState>(
                                builder: (_, value, __) {
                                  if (value != ButtonState.playing) {
                                    controller.recordController.stop();
                                  } else {
                                    controller.recordController.repeat();
                                  }
                                  return RotationTransition(
                                      turns: controller.recordController,
                                      child: ClipOval(
                                        child: getImage(media.extras!['image']),
                                      ));
                                },
                                valueListenable: AudioManage.playButtonNotifier,
                              ),
                            )),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            Get.toNamed('/player',
                                parameters: {"id": media.id});
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              getText(media.title,
                                  style: TextStyle(fontSize: 13.sp)),
                              getText(
                                "${media.extras!['singer']}",
                                style: TextStyle(
                                    fontSize: 10.sp, color: Colors.grey[700]),
                              )
                            ],
                          ),
                        ))
                      ],
                    );
                  }
                }),
          ),
          Expanded(
              flex: 1,
              child: ValueListenableBuilder<ButtonState>(
                builder: (BuildContext context, value, Widget? child) {
                  switch (value) {
                    case ButtonState.loading:
                      return Skeleton();
                    case ButtonState.paused:
                      return InkWell(
                        onTap: () {
                          controller.player?.play();
                        },
                        child: Icon(Icons.play_arrow),
                      );
                    case ButtonState.playing:
                      return InkWell(
                        onTap: () {
                          controller.player?.pause();
                        },
                        child: Icon(Icons.pause),
                      );
                    default:
                      return InkWell(
                        onTap: () {
                          controller.player?.play();
                        },
                        child: Icon(Icons.play_arrow),
                      );
                  }
                },
                valueListenable: AudioManage.playButtonNotifier,
              )),
          Expanded(
              flex: 1,
              child: ValueListenableBuilder<bool>(
                builder: (_, isLast, __) {
                  if (isLast) {
                    return InkWell(
                      onTap: () {
                        // controller.player?.next();
                      },
                      child: Icon(
                        Icons.skip_next,
                        color: Colors.grey[200],
                      ),
                    );
                  } else {
                    return InkWell(
                      onTap: () {
                        controller.player?.skipToNext();
                        controller.player?.play();
                      },
                      child: Icon(
                        Icons.skip_next,
                        color: Colors.black,
                      ),
                    );
                  }
                },
                valueListenable: AudioManage.isLastSongNotifier,
              )),
          Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  Get.bottomSheet(playListBottomSheet());
                },
                child: Icon(Icons.menu_open),
              )),
        ],
      ),
    );
  }

  Widget getImage(String url) {
    var cover = BoxFit.cover;
    final size = 35.sp;
    print("image ${url}");
    if (url == 'null') {

      return Image.asset(
        "assets/images/record.png",
        fit: cover,
        width: size,
        height: size,
      );
    } else {
      return Image.network(
        url,
        fit: cover,
        width: size,
        height: size,
      );
    }
  }

  Widget getText(String text, {TextStyle? style}) {
    if (text.length < 20) {
      return Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: style,
      );
    } else {
      return ScrollText(
        child: text,
        style: style,
      );
    }
  }
}

class playListBottomSheet extends StatelessWidget {
  playListBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double fs = 14;
    final audio = AudioManage.getInstance();
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          )),
      child: ValueListenableBuilder<List<MediaItem>>(
        valueListenable: AudioManage.playlistNotifier,
        builder: (context, playlistTitles, _) {
          return Column(
            children: [
              Container(
                height: 40.sp,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey.shade200))),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                        left: 16,
                        child: buildRepeatButton(fs, playlistTitles.length)),
                    Positioned(
                      right: 31,
                      child: Row(
                        children: [
                          Icon(
                            Icons.add_box_outlined,
                            size: fs,
                          ),
                          Text(
                            ' 收藏全部  |  ',
                            style: TextStyle(fontSize: 12),
                          ),
                          InkWell(
                            child: Icon(
                              Icons.delete_outline,
                              size: fs,
                            ),
                            onTap: () {
                              audio?.clearPlayLists();
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: playlistTitles.length,
                itemExtent: 40.sp,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: ValueListenableBuilder<MediaItem>(
                      valueListenable: AudioManage.currentSongNotifier,
                      builder: (_, value, __) {
                        Widget widget;
                        if (value.id == ('${playlistTitles[index].id}')) {
                          widget = Row(
                            children: [
                              Icon(
                                Icons.volume_down_alt,
                                size: 12.sp,
                                color: Colors.deepPurpleAccent,
                              ),
                              Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                      text: '${playlistTitles[index].title} ',
                                      style: TextStyle(fontSize: 11.sp)),
                                  TextSpan(
                                      text:
                                          ' -  ${playlistTitles[index].album}',
                                      style: TextStyle(
                                        fontSize: 8.sp,
                                      )),
                                ]),
                                overflow: TextOverflow.ellipsis,
                                style:
                                    TextStyle(color: Colors.deepPurpleAccent),
                              )
                            ],
                          );
                        } else {
                          widget = Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                  text: '${playlistTitles[index].title} ',
                                  style: TextStyle(fontSize: 11.sp)),
                              TextSpan(
                                  text: ' -  ${playlistTitles[index].album}',
                                  style: TextStyle(
                                      fontSize: 8.sp, color: Colors.grey[500])),
                            ]),
                            overflow: TextOverflow.ellipsis,
                          );
                        }
                        return InkWell(
                          child: widget,
                          onTap: () {
                            audio?.playOrPauseById(
                                int.parse('${playlistTitles[index].id}'));
                          },
                        );
                      },
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        size: 10.sp,
                      ),
                      onPressed: () {
                        audio?.removeAtIndex(index);
                      },
                    ),
                  );
                },
              )),
            ],
          );
        },
      ),
    );
  }

  Widget buildRepeatButton(iconSize, length) {
    return ValueListenableBuilder<RepeatState>(
        valueListenable: AudioManage.repeatButtonNotifier,
        builder: (context, value, child) {
          Icon icon;
          switch (value) {
            case RepeatState.off:
              icon = Icon(
                Icons.repeat,
                color: Colors.grey,
                size: iconSize,
              );
              break;
            case RepeatState.repeatSong:
              icon = Icon(
                Icons.repeat_one,
                size: iconSize,
              );
              break;
            case RepeatState.repeatPlaylist:
              icon = Icon(
                Icons.repeat,
                size: iconSize,
              );
              break;
          }
          return Row(
            children: [
              InkWell(
                child: icon,
                onTap: AudioManage.getInstance()?.repeat,
              ),
              Text(
                ' 列表循环(${length})',
                style: TextStyle(fontSize: 12),
              )
            ],
          );
        });
  }
}
