import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
///
const String themeModeKey = 'key_theme_mode';
const String appColorKey = 'key_app_color';
const String dynamicColorKey = 'keydynamicColor';
const String pushNotificationKey = 'key_push_notification';
const String biometricKey = 'key_biometric';

class SettingsService {
  SettingsService(this.sharedPrefs);

  final SharedPreferences sharedPrefs;

  /// Loads the User's preferred ThemeMode from local or remote storage.
  Future<ThemeMode> themeMode() async =>
      ThemeMode.values[sharedPrefs.getInt(themeModeKey) ?? 0];

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    await sharedPrefs.setInt(themeModeKey, theme.index);
  }

  Future<Brightness> themeBrightness() async {
    final theme = await themeMode();
    switch (theme) {
      case ThemeMode.dark:
        return Brightness.light;
      case ThemeMode.light:
        return Brightness.light;
      default:
        return Brightness.light;
    }
  }

  Future<void> updateNotification(bool isOn) async {
    await sharedPrefs.setBool(pushNotificationKey, isOn);
  }

  Future<bool> getNotification() async {
    return sharedPrefs.getBool(pushNotificationKey) ?? false;
  }

  Future<void> updateBiometric(bool isOn) async {
    await sharedPrefs.setBool(biometricKey, isOn);
  }

  Future<bool> biometric() async {
    return sharedPrefs.getBool(biometricKey) ?? false;
  }

  Future<void> updateAppThemeColor(Color color) async {
    await sharedPrefs.setInt(appColorKey, color.value);
  }

  Future<Color> appColor() async {
    final colorInt = sharedPrefs.getInt(appColorKey) ?? 0xFF795548;
    return Color(colorInt);
  }

  Future<void> setDynamicColor(bool dynamicColor) async {
    await sharedPrefs.setBool(dynamicColorKey, dynamicColor);
  }

  Future<bool> dynamicColor() async {
    return sharedPrefs.getBool(dynamicColorKey) ?? false;
  }
}
