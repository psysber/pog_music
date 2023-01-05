import 'dart:collection';

import 'package:flutter/animation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pog_music/app/http/request_api.dart';
import 'package:pog_music/app/utils/request.dart';

import '../model/search_suggest.dart';

class SearchController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //TODO: Implement SearchController
  Queue<String> searchHistory = Queue();
  static const histSize = 10;
  String searchText = '';

  late AnimationController animationController;
  late Animation<double> animation;

  List<SearchSuggest>? searchSuggest;
  bool isSearch = true;

  @override
  void onInit() {
    animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animationController.reverse();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    animationController.dispose();
  }

  void onSearch() {
    addHistory();
  }

  void getSearchSuggest(value) async {
    ResponseEntity resp = await Request()
        .post(RequestApi.searchSuggest, params: {"keyword": value});
    if (null != resp.data) {
      searchSuggest = SearchSuggest.fromList(resp.data).data;
      print(searchSuggest![0].name);
    } else {
      searchSuggest = [];
    }
  }

  void onTextChange(value) {
    this.searchText = value;
    update();
  }

  bool isExist() {
    for (var element in searchHistory) {
      return element == searchText;
    }
    return false;
  }

  void addHistory() {
    if (searchHistory.length > 10) {
      searchHistory.removeLast();
    }

    if (searchText != '' && !isExist()) {
      searchHistory.addFirst(searchText);
    }
    update();
  }
}
