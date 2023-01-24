import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pog_music/app/components/skeleton.dart';
import 'package:pog_music/app/modules/home/home_controller.dart';
import 'package:pog_music/app/modules/home/model/discovery_model.dart';
import 'package:pog_music/app/modules/home/model/song_item_list_model.dart';
import 'package:pog_music/app/modules/player/services/audio_manage.dart';

import '../../../components/animation_tabs.dart';
import '../../../http/request_api.dart';
import '../../../utils/request.dart';

class DiscoveryController extends GetxController
    with StateMixin<DiscoveryEntity> {
  var itemList = <ItemListEntity>[];
  var current = 0;

  @override
  void onReady() {
    getDiscovery();
  }

  getDiscovery() async {
    ResponseEntity response = await Request().get(RequestApi.discoveryUrl);
    change(null, status: RxStatus.loading());
    if (null != response.data) {
      DiscoveryEntity discoveryEntity = DiscoveryEntity.fromList(response.data);
      if (itemList.isEmpty) {
        String url = discoveryEntity.data![0].api!;
        getItems(url);
      }
      change(discoveryEntity, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error('获取数据失败'));
    }
  }

  Future<void> getItems(String url) async {
    ResponseEntity resp = await Request().get(url);

    if (null != resp.data) {
      itemList = ItemListEntity.fromList(resp.data).data!;
      update();
    } else {
      itemList = <ItemListEntity>[];
      update();
    }
  }
}

class DiscoveryView extends GetView<DiscoveryController> {
  int _current = 0;
  String? url;
  static const padding = EdgeInsets.fromLTRB(5, 0, 5, 0);
  static const textSty = TextStyle(overflow: TextOverflow.ellipsis);
  final audioManage = AudioManage.getInstance();

  @override
  Widget build(BuildContext context) {
    Get.put(DiscoveryController());
    var homeController = Get.put(HomeController());
    return controller.obx(
      (state) {
        List<DiscoveryEntity>? entitys = state?.data;
        List lists = [];
        entitys?.forEach((element) {
          lists.add(element.name);
        });
        url = entitys![_current]?.api!;

        return AnimatedSwitcherTables(
            texts: lists,
            indexChange: (int index) {
              this._current = index;
              url = entitys![_current]?.api;
              controller
                  .getItems(url!)
                  .whenComplete(() => homeController.scrollBottom());
              audioManage?.clearPlayLists();
            },
            child: GetBuilder<DiscoveryController>(builder: (context) {
              var length = audioManage?.getLength();
              final list = controller.itemList;
              if (length == 0) {
                audioManage?.addPlaylists(list
                    .map((e) => MediaItem(
                        id: "${e.id}",
                        title: "${e.name}",
                        album: e.album,
                        extras: {
                          'url': "${RequestApi.song_url}${e.id}",
                          "singer": "${e.singer}",
                          "image": '${e.imgUrl}'
                        },
                        artUri: Uri.tryParse("${e.imgUrl}")))
                    .toList());
              }

              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemExtent: 70.sp,
                  itemCount: list.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        audioManage
                            ?.playOrPauseById(int.parse("${list[index].id}"));
                      },
                      contentPadding: padding,
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                            width: 55.sp,
                            height: 60.sp,
                            child: FadeInImage(
                              placeholder: AssetImage(
                                "assets/images/loading.png",
                              ),
                              image: NetworkImage(list[index].imgUrl!),
                              fit: BoxFit.cover,
                            )),
                      ),
                      title: Text(list[index].name!,
                          textScaleFactor: 1, style: textSty),
                      subtitle: Text(
                          "${list[index].singer} - ${list[index].album!}",
                          style: textSty),
                      trailing: InkWell(
                        child: Icon(Icons.more_vert),
                        onTap: () {
                          Get.bottomSheet(
                            _BottomSheet(
                              songName: list[index].name,
                              singer: list[index].singer,
                              album: list[index].album,
                              image: list[index].imgUrl,
                            ),
                          );
                        },
                      ),
                    );
                  });
            }));
      },
      onLoading: Skeleton(
        height: 170,
      ),
      onError: (error) => Center(
        child: Text(error!),
      ),
      onEmpty: Center(
        child: Text('暂无数据'),
      ),
    );
  }
}

class _BottomSheet extends StatelessWidget {
  String? songName;
  String? singer;
  String? album;
  String? image;

  _BottomSheet({Key? key, this.songName, this.singer, this.album, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(fontSize: 10.sp);
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            )),
        child: Padding(
          padding: EdgeInsets.all(8.sp),
          child: Wrap(
            children: [
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    this.image!,
                    fit: BoxFit.cover,
                    width: 40.sp,
                    height: 40.sp,
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "歌曲 :   ${this.songName}",
                      style: textStyle,
                    ),
                    Text(
                      this.singer!,
                      style:
                          TextStyle(fontSize: 10.sp, color: Colors.grey[700]),
                    )
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.play_arrow),
                title: Text(
                  "下一首播放",
                  style: textStyle,
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.collections),
                title: Text(
                  "收藏到歌单",
                  style: textStyle,
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text(
                  "分享",
                  style: textStyle,
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  "歌手 :  ${this.singer}",
                  style: textStyle,
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.radar_outlined),
                title: Text(
                  "专辑 :  ${this.album}",
                  style: textStyle,
                ),
                onTap: () {},
              )
            ],
          ),
        ));
  }
}
