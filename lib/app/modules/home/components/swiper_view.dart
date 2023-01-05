import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';
import 'package:pog_music/app/http/request_api.dart';
import 'package:get/get.dart';
import '../../../utils/request.dart';

class SwiperMixinController extends GetxController
    with StateMixin<List<SwiperEntity>> {
  @override
  void onReady() {
    getSwiperEntity();
  }

  void getSwiperEntity() async {
    change(null, status: RxStatus.loading());
    ResponseEntity response = await Request().get(RequestApi.carouselUrl);
    if (null != response.data) {
      change(SwiperEntity.fromJsonList(response.data),
          status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error('获取信息失败'));
    }
  }
}

class SwiperViewMixin extends GetView<SwiperMixinController> {
  SwiperViewMixin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SwiperMixinController());
    return controller.obx(
      (swiperEntity) => _SwiperViewPage(list: swiperEntity!),
      onLoading: Center(
        child: CircularProgressIndicator(),
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

class _SwiperViewPage extends StatelessWidget {
  final List<SwiperEntity> list;

  const _SwiperViewPage({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 170.h,
      width: double.infinity,
      child: ConstrainedBox(
          constraints: BoxConstraints.loose(Size(60, 170.h)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Swiper(
                itemBuilder: (context, index) {
                  return FadeInImage(
                    placeholder: AssetImage(
                      "assets/images/loading.png",
                    ),
                    image: NetworkImage(list[index].carouselUrl!),
                    fit: BoxFit.cover,
                  );
                },
                itemCount: list.length,
                autoplay: true,
                pagination: SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: SwiperCustomPagination(builder:
                        (BuildContext context, SwiperPluginConfig config) {
                      return SwiperDotCustom(config.activeIndex, list.length);
                    }))),
          )),
    );
  }
}

class SwiperDotCustom extends StatelessWidget {
  final _currentIndex;
  final _itemCount;

  SwiperDotCustom(this._currentIndex, this._itemCount);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      // height: ScreenAdapter.setHeight(10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _itemCount,
            childAspectRatio: 3 / 1,
            crossAxisSpacing: 6),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
                color: _currentIndex == index
                    ? Theme.of(context).primaryColor
                    : Colors.black38,
                borderRadius: BorderRadius.circular(20)),
          );
        },
        itemCount: _itemCount,
      ),
    );
  }
}

class SwiperEntity {
  String? id;
  String? carouselUrl;

  SwiperEntity({this.id, this.carouselUrl});

  SwiperEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carouselUrl = json['carousel_url'];
  }

  static List<SwiperEntity> fromJsonList(List<dynamic> jsonData) {
    return jsonData.map((typeJson) => SwiperEntity.fromJson(typeJson)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['carousel_url'] = carouselUrl;
    return data;
  }
}
