import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final appThemeStateNotifier = ChangeNotifierProvider(
  (ref) => AppThemeState()
);

class AppThemeState extends ChangeNotifier{
  var isDarkModeEnable = false;
  void setLightTheme(){
    isDarkModeEnable = false;
    notifyListeners();
  }
  void setDarkTheme(){
    isDarkModeEnable = true;
    notifyListeners();
  }
}