import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const userNameKey = 'user_name_key';
const userLoginKey = 'user_login_key';
const userImageKey = 'user_image_key';
const userLanguageKey = 'user_laguage_key';
const scheduleTime = 'schedule_time_key';

class SplashLocalDataSource {
  SplashLocalDataSource({
    required this.sharePrefefs,
  });

  final SharedPreferences sharePrefefs;

  Future<String> getName() async {
    return sharePrefefs.getString(userNameKey) ?? 'Name';
  }

  Future<void> setName(String name) async {
    await sharePrefefs.setString(userNameKey, name);
  }

  Future<bool> isLoggedIn() async {
    return sharePrefefs.getBool(userLoginKey) ?? false;
  }

  Future<void> setLoggedIn(bool isLogin) async {
    await sharePrefefs.setBool(userLoginKey, isLogin);
  }

  Future<String> getImage() async {
    return sharePrefefs.getString(userImageKey) ?? '';
  }

  Future<void> setImage(String name) async {
    await sharePrefefs.setString(userImageKey, name);
  }

  Future<void> setLanguage(Locale locale) async {
    await sharePrefefs.setString(userLanguageKey, locale.languageCode);
  }

  Future<Locale> getLanguage() async {
    final string = sharePrefefs.getString(userLanguageKey) ?? 'INR';
    return Locale(string);
  }
}
