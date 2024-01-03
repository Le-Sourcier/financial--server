import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../index.dart';

var theme = Get.put(Themes());

class Themes extends GetxController {
  RxBool _isDark = false.obs;

  Themes() {
    getThemePreference();
    update();
  }

  RxBool get isDark => _isDark;

  set isDark(RxBool value) {
    _isDark = value;

    help.writeDataToStorage('isDark', value.value.toString());
    update();
  }

  Future<void> getThemePreference() async {
    final value = await help.readDataFromStorage('isDark');
    if (value == 'true') {
      _isDark.value = true;
    } else {
      _isDark.value = false;
    }
    update();
  }

  ThemeData get themeData {
    return ThemeData(
      brightness: _isDark.value ? Brightness.dark : Brightness.light,
      useMaterial3: true,
      colorSchemeSeed: Colors.indigo,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
      appBarTheme: AppBarTheme(color: help.appColorDark),
    );
  }

  // Toggle between light and dark mode
  Future<void> toggleTheme(Themes value) async {
    value.isDark.value = !value.isDark.value;

    await help.writeDataToStorage('isDark', value._isDark.value.toString());

    update();
  }
}
