import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pog_music/app/common/langs/translation_service.dart';
import 'package:pog_music/app/global.dart';
import 'package:pog_music/app/modules/Index/Index_view.dart';
import 'package:pog_music/app/modules/Index/index_binding.dart';
import 'package:pog_music/app/modules/player/services/audio_manage.dart';
import 'package:pog_music/app/router/app_pages.dart';
import 'package:get/get.dart';

import 'app/common/theme/themes.dart';
import 'app/modules/player/services/audio_handler.dart';

void main() => Global.init().then((e) async {
      await initServices();
      runApp(MyApp());
    });

Future<void> initServices() async {
  print("初始化服务");
  await AudioHandlerService().initAudioService();
  // await Get.putAsync(() async => await AudioHandlerService());
  await Get.putAsync(() async => await AudioManage.getInstance());
  print("所有服务启动");
  print(TranslationService.locale);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          defaultTransition: Transition.rightToLeftWithFade,
          title: 'Flutter With GetX',
          home: IndexPage(),
          initialBinding: IndexBinding(),
          debugShowCheckedModeBanner: false,
          enableLog: true,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          unknownRoute: AppPages.unknownRoute,
          builder: EasyLoading.init(),
          translations: TranslationService(),
          locale: TranslationService.locale,
          fallbackLocale: TranslationService.fallbackLocale,
          darkTheme: dartTheme,
          theme: lightTheme,
        );
      },
    );
  }
}
