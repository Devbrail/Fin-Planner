import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

const String themeModeKey = 'key_theme_mode';
const String appColorKey = 'key_app_color';
const String dynamicColorKey = 'keydynamicColor';
const String biometricKey = 'key_biometric';
const String userNameKey = 'user_name_key';
const String userImageKey = 'user_image_key';
const String userLanguageKey = 'user_laguage_key';
const String scheduleTime = 'schedule_time_key';

abstract class SettingsService {
  Future<void> setThemeColor(Color color);
  Future<Color> themeColor();

  Future<void> setDynamicColor(bool dynamicColor);
  Future<bool> dynamicColor();

  Future<String> userName();
  Future<void> setUserName(String name);

  Future<String> userImage();
  Future<void> setUserImage(String name);

  Future<Locale> language();
  Future<void> setLanguage(Locale locale);
}

class SettingsServiceImpl implements SettingsService {
  final Box<dynamic> box;

  SettingsServiceImpl(this.box);

  @override
  Future<String> userName() async {
    return box.get(userNameKey, defaultValue: 'Name');
  }

  @override
  Future<void> setUserName(String name) async {
    await box.put(userNameKey, name);
  }

  @override
  Future<String> userImage() async {
    return box.get(userImageKey, defaultValue: '');
  }

  @override
  Future<void> setUserImage(String name) async {
    await box.put(userImageKey, name);
  }

  @override
  Future<Locale> language() async {
    return Locale(box.get(userLanguageKey, defaultValue: 'INR'));
  }

  @override
  Future<void> setLanguage(Locale locale) async {
    await box.put(userLanguageKey, locale.languageCode);
  }

  @override
  Future<void> setThemeColor(Color color) async {
    await box.put(appColorKey, color.value);
  }

  @override
  Future<Color> themeColor() async {
    final colorInt = box.get(appColorKey, defaultValue: 0xFF795548);
    return Color(colorInt);
  }

  @override
  Future<void> setDynamicColor(bool dynamicColor) async {
    await box.put(dynamicColorKey, dynamicColor);
  }

  @override
  Future<bool> dynamicColor() async {
    return box.get(dynamicColorKey, defaultValue: false);
  }
}
