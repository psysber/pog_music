import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pog_music/app/components/appbar_search.dart';
import 'package:pog_music/app/components/playerBottomNavigationBar.dart';
import 'package:pog_music/app/modules/home/home_controller.dart';

import '../my/views/my_view.dart';
import 'components/discovery.dart';
import 'components/suggest_play_lists.dart';
import 'components/swiper_view.dart';

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarSearch(
        readOnly: true,
        onTap: () async {
          Get.toNamed("/search");
        },
        hintText: 'search_hit_text'.tr,
        leading: IconButton(
          icon: Icon(Icons.apps_outlined),
          onPressed: () {},
        ),
        suffix: SizedBox(),
      ),
      body: _getTabBar(),
      bottomNavigationBar: Container(
        height: 45.sp,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(width: 0.5, color: Color(0xFFBBBBBB)),
        )),
        child: PlayerBottomNavigationBar(),
      ),
    );
  }

  // 导航
  Widget _getNavigation() {
    List<_NavigationItem> items = [
      _NavigationItem(
        icon: Icons.av_timer,
        text: 'suggest_nav'.tr,
        onTap: "/play-list?title=${'suggest_nav'.tr}",
      ),
      _NavigationItem(
        icon: Icons.featured_play_list,
        text: 'playlists'.tr,
        onTap: "/play-list?title=${'playlists'.tr}",
      ),
      _NavigationItem(
        icon: Icons.bar_chart,
        text: 'ranking'.tr,
        onTap: "/play-list?title=${'ranking'.tr}",
      ),
      _NavigationItem(
        icon: Icons.cast,
        text: 'radio'.tr,
        onTap: "/play-list?title=${'radio'.tr}",
      ),
      _NavigationItem(
        icon: Icons.cast,
        text: 'radio'.tr,
        onTap: "/play-list?title=${'radio'.tr}",
      ),
      _NavigationItem(
        icon: Icons.cast,
        text: 'radio'.tr,
        onTap: "/play-list?title=${'radio'.tr}",
      ),
      _NavigationItem(
        icon: Icons.cast,
        text: 'radio'.tr,
        onTap: "/play-list?title=${'radio'.tr}",
      ),
    ];

    final list = items
        .map((e) => InkWell(
              onTap: () => Get.toNamed(e.onTap!),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.sp),
                    margin: EdgeInsets.all(5.sp),
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(30.sp)),
                    child: Icon(
                      e.icon,
                      size: 20.sp,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    e.text,
                    style: TextStyle(fontSize: 12.sp),
                  )
                ],
              ),
            ))
        .toList();

    return Container(
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(left: 8.sp),
            child: Wrap(
              runAlignment: WrapAlignment.center,
              spacing: 20.0, // 主轴(水平)方向间距
              children: list,
            ),
          )),
    );
  }

  //标签页
  Widget _getTabBar() {
    List<Widget> widgets = [_getHomePage(), MyView()];
    List<String> _tabs = ["发现", "我的"];
    return _TabViewRoute(widgets: widgets, tabs: _tabs);
  }

  //主页内容
  Widget _getHomePage() {
    return Container(
      child: CustomScrollView(
        controller: controller.scrollController,
        slivers: <Widget>[
          SliverPadding(
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: 170.h,
                width: double.infinity,
                child: SwiperViewMixin(),
              ),
            ),
            padding: EdgeInsets.only(left: 8.sp, right: 8.sp),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100.h,
              width: double.infinity,
              child: _getNavigation(),
            ),
          ),
          SliverToBoxAdapter(
            child: Divider(),
          ),
          SliverPadding(
            sliver: SliverList(
              delegate: SliverChildListDelegate([_getItemList()]),
            ),
            padding: EdgeInsets.only(left: 8.sp, right: 8.sp),
          ),
          // _getItemList()
        ],
      ),
    );
  }

  //列表项
  Widget _getItemList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SuggestPlayListsView(),
        Divider(),
        DiscoveryView(),
      ],
    );
  }
}

class _TabViewRoute extends StatelessWidget {
  List<Widget> widgets;
  List<String> tabs;

  _TabViewRoute({Key? key, required this.widgets, required this.tabs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, 40.sp), //设置高度为30
            child: Material(
                color: Colors.white,
                child: Container(
                  margin: EdgeInsets.only(bottom: 8.sp),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Color(0xFFE8E7E7)))),
                  child: TabBar(
                    isScrollable: true,
                    tabs: tabs.map((e) => Tab(text: e)).toList(),
                    labelStyle: TextStyle(color: Colors.black, fontSize: 12.sp),
                    indicatorSize: TabBarIndicatorSize.label,
                  ),
                )),
          ),
          body: TabBarView(
            children: widgets,
          ),
        ));
  }
}

class _NavigationItem {
  final String text;
  final IconData icon;
  final String? onTap;

  _NavigationItem({required this.icon, required this.text, this.onTap});
}
