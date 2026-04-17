import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:edusync_app/core/app_theme.dart';

class AttendanceCardWidget extends StatelessWidget {
  const AttendanceCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF4F7FFF),
            Color(0xFF3A4DFF),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),

      child: Stack(
        children: [

          /// 🔥 الأيقونة الكبيرة (Overlay)
          Positioned(
            right: 10,
            bottom: 10,
            child: SvgPicture.asset(
              "assets/icons/over.svg",
              width: 100,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.15),
                BlendMode.srcIn,
              ),
            ),
          ),

          /// 🔥 المحتوى
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// الأيقونة الصغيرة
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/over.svg",
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              Padding(
                padding: const EdgeInsets.only(right: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [

                    Text(
                      "Take Attendance",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 6),

                    Text(
                      "Next class starts in 15 mins: CS-402 Advanced Algorithms",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// زرار
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Start Now →",
                  style: TextStyle(
                    color: AppTheme.primaryLight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}