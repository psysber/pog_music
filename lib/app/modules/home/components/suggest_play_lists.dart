import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:pog_music/app/components/skeleton.dart';
import 'package:pog_music/app/http/request_api.dart';
import 'package:pog_music/app/modules/home/model/suggest_play_lists_model.dart';
import 'package:pog_music/app/utils/request.dart';

import '../../../components/title_bar.dart';

class SuggestPlayListController extends GetxController
    with StateMixin<SuggestPlayListsEntity> {
  var current = 0.obs;

  @override
  void onReady() {
    getSuggestList();
  }

  void changeValue(int index, id) {
    current.value = index;
    update([id]);
  }

  void getSuggestList() async {
    ResponseEntity response = await Request().get(RequestApi.suggestListsUrl);
    change(null, status: RxStatus.loading());

    if (null != response.data) {
      change(SuggestPlayListsEntity.fromJson(response.data),
          status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error("获取数据失败"));
    }
  }
}

class SuggestPlayListsView extends GetView<SuggestPlayListController> {
  @override
  Widget build(BuildContext context) {
    Get.put(SuggestPlayListController());
    return controller.obx((suggestPlayListsEntity) {
      List<SuggestPlayLists>? playlist = suggestPlayListsEntity?.data;
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ItemTitle(suggestPlayListsEntity!.name!),
          SizedBox(
              height: 90.sp,
              width: double.infinity,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: playlist?.length,
                  itemExtent: 70.sp, //
                  itemBuilder: (BuildContext context, int index) {
                    List<SuggestPlayListItem>? item = playlist![index].data;
                    return SuggestPlayListsItemView(
                      item: item,
                      key: key,
                    );
                  }))
        ],
      );
    },
        onError: (error) => Center(
              child: Text(error!),
            ),
        onEmpty: Center(
          child: Text('暂无数据'),
        ),
        onLoading: Skeleton(
          height: 100,
        ));
  }
}

class SuggestPlayListsItemView extends StatefulWidget {
  const SuggestPlayListsItemView({Key? key, this.item}) : super(key: key);

  final List<SuggestPlayListItem>? item;

  @override
  _SuggestPlayListsItemState createState() =>
      _SuggestPlayListsItemState(item: item);
}

class _SuggestPlayListsItemState extends State<SuggestPlayListsItemView> {
  final List<SuggestPlayListItem>? item;
  int index = 0;

  _SuggestPlayListsItemState({this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60.sp,
          height: 65.sp,
          margin: EdgeInsets.only(right: 5.sp, left: 5.sp),
          child: Swiper(
              onIndexChanged: (index) {
                setState(() {
                  this.index = index;
                });
              },
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int pointer) {
                return ClipRRect(
                    borderRadius: BorderRadius.circular(10.sp),
                    child: FadeInImage(
                      placeholder: AssetImage(
                        "assets/images/loading.png",
                      ),
                      image: NetworkImage(item![index].image!),
                      fit: BoxFit.cover,
                    ));
              },
              itemCount: item!.length),
        ),
        SizedBox(
            width: 65.sp,
            child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  //执行缩放动画
                  return ScaleTransition(
                    child: child,
                    scale: animation,
                  );
                },
                child: Text(
                  item![index].title!,
                  //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
                  key: ValueKey<int>(index),
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp,
                      overflow: TextOverflow.clip),
                ))),
      ],
    );
  }
}
