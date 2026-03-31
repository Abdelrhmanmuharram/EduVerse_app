import 'package:edusync_app/core/services/local_storage_service.dart';
import 'package:edusync_app/feature/login/view/login_view.dart';
import 'package:edusync_app/feature/onboarding/view/onboarding_view.dart';

class SplashViewmodel {
  Future<String> getNextRoute() async {
    final seen = await LocalStorageService.isOnboardingSeen();
    return seen ? LoginView.routeName : OnboardingView.routeName;
  }
}
