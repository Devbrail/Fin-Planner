import 'package:flutter/material.dart';

abstract class SplashRepository {
  void setName(String name);
  Future<String> getName();

  void setLoggedIn(bool isLogin);
  Future<bool> isLoggedIn();

  void setImage(String name);
  Future<String> getImage();

  Future<Locale> getLanguage();

  Future<void> setLanguage(Locale locale);
}
