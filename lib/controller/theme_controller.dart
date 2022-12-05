/* import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  late ThemeData _currentTheme;
  var isDarkTheme = false.obs;

  set setDarkTheme(bool value) {
    isDarkTheme.value = !isDarkTheme.value;
    if (isDarkTheme.value) {
      _currentTheme = ThemeData.dark();
    } else {
      _currentTheme = ThemeData.light();
    }
  }

  get getCurrentTheme => _currentTheme;
}
 */