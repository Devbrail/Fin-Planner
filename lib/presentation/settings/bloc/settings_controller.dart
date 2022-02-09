import 'package:flutter/material.dart';

import '../../../data/notification/notification_service.dart';
import '../../../data/settings/settings_service.dart';
import '../../../di/service_locator.dart';

class SettingsController with ChangeNotifier {
  SettingsController({required this.settingsService});

  final SettingsService settingsService;
  late bool showNotificatons = false;
  late bool useBiometrics = false;
  late Color _currentColor = Colors.orange;
  late ThemeMode _themeMode;
  late bool _dynamicColor = false;

  ThemeMode get themeMode => _themeMode;
  bool get dynamicColor => _dynamicColor;
  Color get currentColor => _currentColor;

  Future<void> loadSettings() async {
    _themeMode = await settingsService.themeMode();
    showNotificatons = await settingsService.notification();
    _currentColor = await settingsService.themeColor();
    notifyListeners();
  }

  Future<void> updateNotification(bool isOn) async {
    showNotificatons = isOn;
    notifyListeners();
    if (isOn) {
      locator.get<NotificationService>().sechuldeNotification();
    } else {
      locator.get<NotificationService>().notification.cancelAll();
    }
    await settingsService.setUpdateNotification(isOn);
  }

  Future<void> updateBiometric(bool isOn) async {
    useBiometrics = isOn;
    notifyListeners();
    await settingsService.setBiometric(isOn);
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;
    if (newThemeMode == _themeMode) return;
    _themeMode = newThemeMode;
    notifyListeners();
    await settingsService.setThemeMode(newThemeMode);
  }

  Future<void> updateColor(Color color) async {
    if (currentColor == color) return;
    _currentColor = color;
    notifyListeners();
    await settingsService.setThemeColor(color);
  }

  Future<void> setDynamicColor(bool color) async {
    if (dynamicColor == color) return;
    _dynamicColor = color;
    notifyListeners();
    await settingsService.setDynamicColor(color);
  }
}
