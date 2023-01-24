part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const INITIAL = _Paths.Index;
  static const Home = _Paths.Home;
  static const Login = _Paths.Login;
  static const NotFound = _Paths.NotFound;
  static const PLAYER = _Paths.PLAYER;
  static const SWIPER_VIEW = _Paths.SWIPER_VIEW;
  static const SEARCH = _Paths.SEARCH;
  static const MY = _Paths.MY;
  static const PLAY_LIST = _Paths.PLAY_LIST;
}

abstract class _Paths {
  _Paths._();
  static const Index = '/index';
  static const Home = '/home';
  static const Login = '/login';
  // notfound
  static const NotFound = '/notfound';

  // setproxy
  static const Proxy = '/proxy';
  static const PLAYER = '/player';
  static const SWIPER_VIEW = '/swiper-view';
  static const SEARCH = '/search';
  static const MY = '/my';
  static const PLAY_LIST = '/play-list';
}
