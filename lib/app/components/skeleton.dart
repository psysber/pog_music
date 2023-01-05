import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  final double? height;
  final double? width;

  Skeleton(
      {Key? key, this.width = double.infinity, this.height = double.infinity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(color: Colors.grey[300]),
    );
  }
}
