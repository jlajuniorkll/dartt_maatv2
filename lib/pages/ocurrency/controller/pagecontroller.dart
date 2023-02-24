import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class PageManager extends GetxController{

  final PageController _pageController = PageController();
  TabController? tabController;

  int page = 0;

 PageController get pageController => _pageController;
  void setPage(int value) {
    if (value == page) return;
    page = value;
    tabController!.index = value;
    _pageController.jumpToPage(value);
  }
}