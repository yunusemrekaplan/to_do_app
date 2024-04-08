import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoubleConstant {
  static double get calculateAvailableScreenHeight {
    return Get.height -
        Get.mediaQuery.padding.bottom -
        kToolbarHeight -
        kBottomNavigationBarHeight -
        16;
  }
}
