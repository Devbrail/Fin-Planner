import 'package:device_info_plus/device_info_plus.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ServiceBoxModule {
  @singleton
  DeviceInfoPlugin providesDeviceInfoPlugin() {
    return DeviceInfoPlugin();
  }

  @singleton
  InAppReview providesInAppReview() {
    return InAppReview.instance;
  }
}
