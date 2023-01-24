import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pog_music/app/modules/player/services/audio_manage.dart';

import '../../../components/lightText.dart';
import '../controllers/play_list_controller.dart';

class PlayListView extends GetView<PlayListController> {
  const PlayListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 16.sp),
          title: Text('歌单'),
          expandedHeight: 250.sp,
          collapsedHeight: 70.sp,
          floating: false,
          pinned: true,
          snap: false,
          stretch: true,
          elevation: 0,
          stretchTriggerOffset: 100.sp,
          flexibleSpace: FlexibleSpaceBar(
            title: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.sp),
                      topRight: Radius.circular(8.sp))),
              padding: EdgeInsets.only(top: 8.sp, bottom: 8.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.sp),
                    child: Row(
                      children: [
                        Icon(
                          Icons.play_circle,
                          size: 10.sp,
                        ),
                        Text.rich(
                          TextSpan(children: [
                            TextSpan(text: " 播放全部"),
                            TextSpan(
                                text:
                                    " (共${AudioManage.playlistNotifier.value.length}首)",
                                style: TextStyle(color: Colors.black54))
                          ]),
                          style: TextStyle(fontSize: 10.sp),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10.sp),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_box_outlined,
                          size: 10.sp,
                        ),
                        Text(
                          ' 收藏全部  |  ',
                          style: TextStyle(fontSize: 10.sp),
                        ),
                        InkWell(
                          child: Icon(
                            Icons.delete_outline,
                            size: 10.sp,
                          ),
                          onTap: () {},
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/star.jpg'),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 20.sp,
                      bottom: 70.sp,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.sp),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black12)),
                          child: Container(
                              padding: EdgeInsets.all(2.sp),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.sp),
                                child: Image.asset(
                                  'assets/images/star.jpg',
                                  fit: BoxFit.cover,
                                ),
                              )),
                          width: 130.sp,
                          height: 130.sp,
                        ),
                      ),
                    ),
                    Positioned(
                        right: 20.sp,
                        bottom: 70.sp,
                        child: SizedBox(
                          width: 180.sp,
                          child: Wrap(
                            runAlignment: WrapAlignment.spaceEvenly,
                            runSpacing: 10.sp,
                            children: [
                              Text(
                                "把静夜流星带给你|静夜流星",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "静夜流星",
                                    style: TextStyle(
                                        color: Colors.grey[200],
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Text(
                                "喜欢在无人醒来的夜晚,静静的与黑暗相伴话题无非是面对广袤的夜空,如何让文字与灵感擦肩然后将思绪点燃然后产生静电,然后让语言幸福的失眠.",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey[200],
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ))
                  ],
                )),
            centerTitle: false,
            titlePadding: EdgeInsets.all(0),
            collapseMode: CollapseMode.parallax,
            stretchModes: [
              StretchMode.zoomBackground,
              StretchMode.blurBackground,
              StretchMode.fadeTitle,
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                child: ListTile(
                  leading: Text("${index}"),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "The Everlasting Guilty Crown",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "EGOIST - The Everlasting Guilty Crown",
                        style:
                            TextStyle(fontSize: 12.sp, color: Colors.black54),
                        maxLines: 1,
                      ),
                      Text(
                        "TV动画<<罪恶王冠>> OP2",
                        style:
                            TextStyle(fontSize: 10.sp, color: Colors.black54),
                        maxLines: 1,
                      ),
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
                ),
              );
            },
            childCount: 30,
          ),
        ),
      ],
    );
  }
//
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     extendBodyBehindAppBar: true,
//     appBar: AppBar(
//       title: Text(Get.parameters['title']!),
//       centerTitle: true,
//       backgroundColor: Color(0x7EF6F6F6),
//       elevation: 0,
//     ),
//     body: Container(
//         constraints: BoxConstraints.expand(),
//         decoration: BoxDecoration(
//             image: DecorationImage(
//                 opacity: 0.5,
//                 image: AssetImage('assets/images/star.jpg'),
//                 fit: BoxFit.cover)),
//         child: SafeArea(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 150.sp,
//                 child: Stack(
//                   children: [
//                     Positioned(
//                       left: 20.sp,
//                       top: 20.sp,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(5.sp),
//                         child: Container(
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               border: Border.all(color: Colors.black12)),
//                           child: Container(
//                               padding: EdgeInsets.all(2.sp),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(5.sp),
//                                 child: Image.asset(
//                                   'assets/images/star.jpg',
//                                   fit: BoxFit.cover,
//                                 ),
//                               )),
//                           width: 130.sp,
//                           height: 130.sp,
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                         right: 20.sp,
//                         top: 20.sp,
//                         child: SizedBox(
//                           width: 180.sp,
//                           child: Wrap(
//                             runAlignment: WrapAlignment.spaceEvenly,
//                             runSpacing: 10.sp,
//                             children: [
//                               Text(
//                                 "把静夜流星带给你|静夜流星",
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 2,
//                                 style: TextStyle(
//                                     fontSize: 16.sp,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Row(
//                                 children: [
//                                   Icon(
//                                     Icons.person,
//                                     color: Colors.black87,
//                                   ),
//                                   Text(
//                                     "静夜流星",
//                                     style: TextStyle(
//                                         color: Colors.grey[200],
//                                         fontWeight: FontWeight.bold),
//                                   )
//                                 ],
//                               ),
//                               Text(
//                                 "喜欢在无人醒来的夜晚,静静的与黑暗相伴话题无非是面对广袤的夜空,如何让文字与灵感擦肩然后将思绪点燃然后产生静电,然后让语言幸福的失眠.",
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(
//                                     fontSize: 12.sp,
//                                     color: Colors.grey[200],
//                                     fontWeight: FontWeight.bold),
//                               )
//                             ],
//                           ),
//                         ))
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 10.sp, bottom: 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Column(
//                       children: [
//                         Icon(
//                           Icons.speaker_notes_outlined,
//                           color: Colors.white,
//                         ),
//                         Text(
//                           '100',
//                           style: TextStyle(color: Colors.white),
//                         )
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Icon(
//                           Icons.share_outlined,
//                           color: Colors.white,
//                         ),
//                         Text(
//                           '100',
//                           style: TextStyle(color: Colors.white),
//                         )
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Icon(
//                           Icons.download,
//                           color: Colors.white,
//                         ),
//                         Text(
//                           '下载',
//                           style: TextStyle(color: Colors.white),
//                         )
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Icon(
//                           Icons.spellcheck,
//                           color: Colors.white,
//                         ),
//                         Text(
//                           '多选',
//                           style: TextStyle(color: Colors.white),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                   child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(20.sp),
//                         topRight: Radius.circular(20.sp))),
//                 child: ListView.builder(
//                   itemCount: 100,
//                   itemExtent: 85.sp,
//                   //列表项构造器
//                   itemBuilder: (BuildContext context, int index) {
//                     return Container(
//                       padding: EdgeInsets.only(top: 8.sp, bottom: 8.sp),
//                       child: ListTile(
//                         leading: Text("${index}"),
//                         title: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "The Everlasting Guilty Crown",
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             Text(
//                               "EGOIST - The Everlasting Guilty Crown",
//                               maxLines: 1,
//                             ),
//                             Text(
//                               "TV动画<<罪恶王冠>> OP2",
//                               maxLines: 1,
//                             ),
//                           ],
//                         ),
//                         trailing: IconButton(
//                           icon: Icon(
//                             Icons.more_vert,
//                             color: Colors.grey[600],
//                             size: 16.sp,
//                           ),
//                           onPressed: () {},
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ))
//             ],
//           ),
//         )),
//   );
// }
}
