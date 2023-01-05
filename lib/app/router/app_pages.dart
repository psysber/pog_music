import 'package:get/get.dart';

import '../modules/Index/Index_view.dart';
import '../modules/home/home.binding.dart';
import '../modules/home/home_view.dart';
import '../modules/login/login_binding.dart';
import '../modules/login/login_view.dart';
import '../modules/my/bindings/my_binding.dart';
import '../modules/my/views/my_view.dart';
import '../modules/notfound/notfound_view.dart';
import '../modules/player/bindings/player_binding.dart';
import '../modules/player/views/player_view.dart';
import '../modules/proxy/proxy_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.INITIAL;

  static final routes = [
    GetPage(
      name: _Paths.Index,
      page: () => IndexPage(),
    ),
    GetPage(
      name: _Paths.Login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.Home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PLAYER,
      page: () => const PlayerView(),
      binding: PlayerBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.MY,
      page: () => const MyView(),
      binding: MyBinding(),
    ),
  ];

  static final unknownRoute = GetPage(
    name: _Paths.NotFound,
    page: () => NotfoundPage(),
  );

  static final proxyRoute = GetPage(
    name: _Paths.Proxy,
    page: () => ProxyPage(),
  );
}
