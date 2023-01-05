import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pog_music/app/components/appbar_search.dart';
import 'package:pog_music/app/components/title_bar.dart';

import '../../../components/lightText.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({Key? key}) : super(key: key);

  Widget getSuggest() {
    if (null != controller.searchSuggest && '' != controller.searchText) {
      return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.sp),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.5, 5.0), //阴影xy轴偏移量
                    blurRadius: 5.0, //阴影模糊程度
                    spreadRadius: 1.0 //阴影扩散程度
                    )
              ],
              color: Colors.white,
              border: Border.all(color: Colors.black12)),
          child: Column(
            children: controller.searchSuggest!
                .map((e) => ListTile(
                      onTap: () =>
                          Get.toNamed('/player', parameters: {'id': '${e.id}'}),
                      title: LightText(
                        text: '${e.name}',
                        lightText: controller.searchText,
                        textStyle: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ))
                .toList(),
          ));
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(SearchController());
    return Scaffold(
        appBar: AppBarSearch(
          onChanged: (value) {
            controller.onTextChange(value);
            controller.animationController.forward();
            controller.getSearchSuggest(value);
            controller.isSearch = false;
          },
          onSearch: (value) {
            controller.onSearch();
            controller.animationController.reverse();
            controller.isSearch = true;
          },
          onRightTap: () {
            controller.onSearch();
            controller.animationController.reverse();
            controller.isSearch = true;
          },
          onCancel: () {
            controller.animationController.reverse();
            controller.isSearch = false;
          },
          onClear: () {
            controller.animationController.reverse();
            controller.isSearch = false;
          },
        ),
        body: GetBuilder<SearchController>(
            init: controller,
            builder: (context) {
              var history = controller.searchHistory;
              var list = history.map((e) => _SearchText(text: e)).toList();
              Widget widget = list.isEmpty
                  ? SizedBox()
                  : Container(
                      padding: EdgeInsets.all(5.sp),
                      color: Colors.white,
                      width: double.infinity,
                      child: Text(
                        "搜索历史",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                    );
              final searchSuggest;
              return Container(
                color: Colors.white,
                constraints: BoxConstraints.expand(),
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    controller.isSearch ? SizedBox() : widget,
                    controller.isSearch
                        ? SizedBox()
                        : Positioned(
                            top: 35.sp,
                            left: 10.sp,
                            right: 10.sp,
                            child: Wrap(
                              spacing: 15.sp, // 主轴(水平)方向间距
                              runSpacing: 10.sp,
                              children: list,
                            ),
                          ),
                    Positioned(
                      top: 0.sp,
                      left: 5.sp,
                      right: 61.sp,
                      child: FadeTransition(
                        opacity: controller.animation,
                        child: getSuggest(),
                      ),
                    ),
                    controller.isSearch && controller.searchText != ''
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.black12))),
                                padding:
                                    EdgeInsets.only(left: 15.sp, right: 15.sp),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ItemTitle('播放全部'),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.play_circle))
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: ListView.builder(
                                itemCount: 100,
                                itemExtent: 50.sp,
                                //列表项构造器
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        LightText(
                                          text: "The Everlasting Guilty Crown",
                                          lightText: controller.searchText,
                                          textStyle:
                                              TextStyle(color: Colors.black),
                                          lightStyle: TextStyle(
                                              color: Colors.deepPurpleAccent),
                                        ),
                                        LightText(
                                          text:
                                              "EGOIST - The Everlasting Guilty Crown",
                                          lightText: "e",
                                          textStyle: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.grey[600]),
                                          lightStyle: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.deepPurpleAccent),
                                        ),
                                        LightText(
                                          text: "TV动画<<罪恶王冠>> OP2",
                                          lightText: controller.searchText,
                                          textStyle: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.grey[600]),
                                          lightStyle: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.deepPurpleAccent),
                                        )
                                      ],
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(
                                        Icons.more_vert,
                                        color: Colors.grey[600],
                                        size: 16.sp,
                                      ),
                                      onPressed: () {},
                                    ),
                                  );
                                },
                              ))
                            ],
                          )
                        : SizedBox()
                  ],
                ),
              );
            }));
  }
}

class _SearchText extends StatelessWidget {
  final String text;

  _SearchText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        style: TextStyle(fontSize: 12.sp),
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(6.sp),
      ),
      padding: EdgeInsets.all(4.sp),
    );
  }
}
