import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  primarySwatch: createMaterialColor(Colors.black),
  primaryColor: Colors.black,
  primaryTextTheme: Typography.englishLike2018
      .apply(fontSizeFactor: 1.sp, bodyColor: Colors.black),
  indicatorColor: Colors.grey[600],
  backgroundColor: Colors.white,
  tabBarTheme: TabBarTheme(
    labelColor: Colors.black,
    unselectedLabelColor: Colors.grey[600],
  ),
);

final dartTheme = ThemeData.dark().copyWith();

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
