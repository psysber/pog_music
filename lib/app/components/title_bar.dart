import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemTitle extends StatelessWidget {
  String title;

  ItemTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ));
  }
}
