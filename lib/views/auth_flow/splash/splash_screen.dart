import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/app-export.dart';
import 'controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo animation
            SizedBox(
                  height: 120.h,
                  width: 120.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.r),
                    child: Image.asset(
                      ImageConstant.appLogo,
                      height: 80.h,
                      fit: BoxFit.fitHeight,
                    ).paddingAll(12),
                  ),
                )
                .animate()
                .scaleXY(
                  begin: 0.8,
                  end: 1.2,
                  duration: 250.ms,
                  curve: Curves.easeInOutQuad,
                )
                .then()
                .scaleXY(
                  begin: 1.2,
                  end: 1.0,
                  duration: 200.ms,
                  curve: Curves.easeInOutQuad,
                ),

            SizedBox(height: 16.h),

            // App name
            Text(
                  'Call Monitor',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.colorHeading,
                  ),
                )
                .animate()
                .fadeIn(duration: 600.ms, delay: 200.ms)
                .slideY(
                  begin: 0.3,
                  end: 0.0,
                  duration: 600.ms,
                  delay: 200.ms,
                  curve: Curves.easeOutQuad,
                ),

            SizedBox(height: 8.h),

            // Tagline
            Text(
                  'Track & Analyze Your Calls Smartly',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.grey,
                  ),
                )
                .animate()
                .fadeIn(duration: 600.ms, delay: 400.ms)
                .slideY(
                  begin: 0.3,
                  end: 0.0,
                  duration: 600.ms,
                  delay: 400.ms,
                  curve: Curves.easeOutQuad,
                ),
          ],
        ),
      ),
    );
  }
}
