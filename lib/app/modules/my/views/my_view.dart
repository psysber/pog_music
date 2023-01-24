import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pog_music/app/components/title_bar.dart';

import '../controllers/my_controller.dart';

class MyView extends GetView<MyController> {
  const MyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fontsize = TextStyle(fontSize: 14.sp);
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(5.sp),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://ccgoat.oss-cn-hongkong.aliyuncs.com/images/5qp085eo9f491.jpg'),
                    opacity: 0.2,
                    fit: BoxFit.cover)),
            child: Row(children: [
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: ClipOval(
                  child: Image.network(
                    'https://ccgoat.oss-cn-hongkong.aliyuncs.com/images/5qp085eo9f491.jpg',
                    height: 60.sp,
                    width: 60.sp,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.sp, 10.sp, 0, 10.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "真夜真影",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "无名真夜,唯有真影",
                      style: TextStyle(color: Colors.black54, fontSize: 12.sp),
                    ),
                  ],
                ),
              )
            ]),
          ),
          ListTile(
            leading: Icon(Icons.star_border),
            title: Text(
              "我的收藏",
              style: TextStyle(fontSize: 14.sp),
            ),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            leading: Icon(Icons.queue_music),
            title: Text(
              "最近播放",
              style: TextStyle(fontSize: 14.sp),
            ),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            leading: Icon(Icons.download),
            title: Text(
              "我的下载",
              style: TextStyle(fontSize: 14.sp),
            ),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            leading: Icon(Icons.music_video),
            title: Text(
              "本地音乐",
              style: TextStyle(fontSize: 14.sp),
            ),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: ItemTitle("创建的歌单"),
          ),
          ListTile(
            leading: Image.network(
              'https://ccgoat.oss-cn-hongkong.aliyuncs.com/images/5qp085eo9f491.jpg',
              height: 40.sp,
              width: 40.sp,
              fit: BoxFit.cover,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '我喜欢的音乐',
                  style: fontsize,
                ),
                Text("30首")
              ],
            ),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            leading: Image.network(
              'https://ccgoat.oss-cn-hongkong.aliyuncs.com/images/5qp085eo9f491.jpg',
              height: 40.sp,
              width: 40.sp,
              fit: BoxFit.cover,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '古典音乐',
                  style: fontsize,
                ),
                Text("30首")
              ],
            ),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            leading: Image.network(
              'https://ccgoat.oss-cn-hongkong.aliyuncs.com/images/5qp085eo9f491.jpg',
              height: 40.sp,
              width: 40.sp,
              fit: BoxFit.cover,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '流行音乐',
                  style: fontsize,
                ),
                Text("30首")
              ],
            ),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            leading: Image.network(
              'https://ccgoat.oss-cn-hongkong.aliyuncs.com/images/5qp085eo9f491.jpg',
              height: 40.sp,
              width: 40.sp,
              fit: BoxFit.cover,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '金属音乐',
                  style: fontsize,
                ),
                Text("30首")
              ],
            ),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            leading: Image.network(
              'https://ccgoat.oss-cn-hongkong.aliyuncs.com/images/5qp085eo9f491.jpg',
              height: 40.sp,
              width: 40.sp,
              fit: BoxFit.cover,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '轻音乐',
                  style: fontsize,
                ),
                Text("30首")
              ],
            ),
            trailing: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
