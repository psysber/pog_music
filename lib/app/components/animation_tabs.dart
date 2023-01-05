import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedSwitcherTables extends StatefulWidget {
  var texts = [];
  final Widget? child;

  AnimatedSwitcherTables(
      {Key? key, required this.texts, required this.child, this.indexChange})
      : super(key: key);
  ValueChanged<int>? indexChange;

  get onIndexChanged => indexChange;

  @override
  _AnimatedSwitcherCounterRouteState createState() =>
      _AnimatedSwitcherCounterRouteState(this.texts, this.child);
}

class _AnimatedSwitcherCounterRouteState extends State<AnimatedSwitcherTables> {
  int current = 0;
  var texts = [];
  var child;

  _AnimatedSwitcherCounterRouteState(this.texts, this.child);

  @override
  void initState() {
    super.initState();
  }

  void _onIndexChanged(int index) {
    setState(() {
      current = index;
    });
    widget.onIndexChanged?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    Widget getText(int index, String text) {
      if (current == index) {
        return Text(
          text,
          key: ValueKey<int>(0),
          style: TextStyle(fontSize: 15.sp),
        );
      } else {
        return Text(
          text,
          key: ValueKey<int>(1),
          style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[500]),
        );
      }
    }

    return Column(
      children: [
        SizedBox(
          height: 20.sp,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Center(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _onIndexChanged(index);
                      });
                    },
                    child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 1000),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          //执行缩放动画
                          return ScaleTransition(
                              child: child, scale: animation);
                        },
                        child: getText(index, texts[index])),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Center(
                  child: Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    height: 15.sp,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(
                      color: Color(0xFFCBCBCB),
                      width: 1.sp,
                    ))),
                  ),
                );
              },
              itemCount: texts.length),
        ),
        child
      ],
    );
  }
}
