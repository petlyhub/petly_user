import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';

class AppSessionManager {
  static final AppSessionManager _instance = AppSessionManager._internal();
  factory AppSessionManager() => _instance;
  AppSessionManager._internal();

  int? moduleId;
  int? zoneId;

  bool get isReady => moduleId != null;

  void initFromCache(SplashController splashController) {
    moduleId ??= splashController.cacheModule?.id;
  }

  void setZone(int id) {
    zoneId = id;
  }
}