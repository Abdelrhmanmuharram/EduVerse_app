import 'package:edusync_app/core/app_theme.dart';
import 'package:edusync_app/core/widgets/main_button.dart';
import 'package:edusync_app/core/widgets/main_text_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  static const String routeName = '/';

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = PageController();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text('EduSync', style: textTheme.headlineSmall)),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller,
              onPageChanged: (index) {
                currentIndex = index;
                setState(() {});
              },
              children: [
                Column(
                  mainAxisAlignment: .spaceAround,
                  children: [
                    Image.asset('assets/images/onboarding_background.png'),
                    Text(
                      'Manage Materials \nEasily',
                      style: textTheme.headlineMedium,
                      textAlign: .center,
                    ),
                    Text(
                      'Organize your course materials,\nassignments, and notes in one smart\nuniversity dashboard.',
                      style: textTheme.titleMedium!.copyWith(fontWeight: .w500),
                      textAlign: .center,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: .spaceEvenly,
                  children: [
                    Image.asset('assets/images/onboarding_2.png'),
                    Text(
                      'Track Attendance',
                      style: textTheme.headlineMedium,
                      textAlign: .center,
                    ),
                    Text(
                      'Stay on top of your classes with real-time\nattendance tracking and smart\nnotifications for upcoming lectures.',
                      style: textTheme.titleMedium!.copyWith(fontWeight: .w500),
                      textAlign: .center,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: .spaceAround,
                  children: [
                    Image.asset('assets/images/onboarding_3.png'),
                    Text(
                      'Stay Connected',
                      style: textTheme.headlineMedium,
                      textAlign: .center,
                    ),
                    Text(
                      'Real-time updates and seamless\ncommunication across your entire\nacademic community.',
                      style: textTheme.titleMedium!.copyWith(fontWeight: .w500),
                      textAlign: .center,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: ExpandingDotsEffect(
              expansionFactor: 3,
              spacing: 8.0,
              radius: 16,
              dotHeight: 8.0,
              dotWidth: 8.0,
              dotColor: Color(0xffE2E8F0),
              activeDotColor: AppTheme.primaryLight,
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: MainBotton(
              onPressed: () => controller.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              ),
              text: currentIndex == 0
                  ? 'Continue'
                  : currentIndex == 2
                  ? 'Get Started'
                  : 'Next',
            ),
          ),
          SizedBox(height: 16),
          Visibility(
            visible: currentIndex == 0
                ? true
                : currentIndex == 1
                ? true
                : false,
            child: MainTextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
              },
              text: currentIndex == 0 ? 'Skip' : 'Skip for now',
              color: currentIndex == 0
                  ? AppTheme.primaryLight
                  : AppTheme.secondText.withAlpha(100),
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
        ],
      ),
    );
  }
}
