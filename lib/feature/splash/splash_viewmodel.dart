import 'package:edusync_app/core/services/local_storage_service.dart';
import 'package:edusync_app/feature/login/login_view.dart';
import 'package:edusync_app/feature/onboarding/onboarding_view.dart';

class SplashViewmodel {
  Future<String> getNextRoute() async {
    final seen = await LocalStorageService.isOnboardingSeen();
    return seen ? LoginView.routeName : OnboardingView.routeName;
  }
}
