import 'package:edusync_app/core/services/local_storage_service.dart';

class SplashViewmodel {
  Future<bool> isOnboardingSeen() async {
    return await LocalStorageService.isOnboardingSeen();
  }
}
