import 'package:call_monitor/views/auth_flow/login/controller/login_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/app-export.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF7F8FA), Color(0xFFF0F4FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Decorative blur circles
          Positioned(
            top: -60,
            left: -40,
            child: _buildBlurCircle(160, ColorConstants.appThemeColor.withOpacity(0.2)),
          ),
          Positioned(
            bottom: -50,
            right: -40,
            child: _buildBlurCircle(200, ColorConstants.appThemeColor.withOpacity(0.1)),
          ),

          // Main scrollable content
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
              child: Column(
                children: [
                  SizedBox(height: 100.h),
                  _buildHeader(),
                  SizedBox(height: 60.h),
                  _buildGoogleSignIn(),
                  SizedBox(height: 140.h), // Extra space before footer
                ],
              ),
            ),
          ),

          // Footer (Terms & Privacy)
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildFooter(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          height: 120.h,
          width: 120.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28.r),
            boxShadow: [
              BoxShadow(
                color: ColorConstants.appThemeColor.withOpacity(0.25),
                blurRadius: 18,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28.r),
            child: Image.asset(ImageConstant.appLogo, fit: BoxFit.cover),
          ),
        )
            .animate()
            .scale(duration: 800.ms, curve: Curves.easeOutBack)
            .then(delay: 200.ms),

        SizedBox(height: 20.h),

        Text(
          'Welcome',
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
            color: ColorConstants.colorHeading,
            fontFamily: AppFonts.poppins,
          ),
        ).animate().slideY(begin: 0.2, end: 0, duration: 600.ms),

        SizedBox(height: 10.h),

        Text(
          'Sign in with Google to get started',
          style: TextStyle(
            fontSize: 15.sp,
            color: ColorConstants.grey,
            fontFamily: AppFonts.poppins,
          ),
        ).animate().fadeIn(duration: 700.ms, delay: 200.ms),
      ],
    );
  }

  Widget _buildGoogleSignIn() {
    return Obx(() => GestureDetector(
          onTap: controller.isLoading.value ? null : controller.signInWithGoogle,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: double.infinity,
            height: 55.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: controller.isLoading.value
                  ? ColorConstants.grey.withOpacity(0.3)
                  : Colors.white,
              gradient: controller.isLoading.value
                  ? null
                  : const LinearGradient(
                      colors: [ColorConstants.appThemeColor, Color(0xFF6C63FF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: controller.isLoading.value
                  ? null
                  : [
                      BoxShadow(
                        color: ColorConstants.appThemeColor.withOpacity(0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            child: controller.isLoading.value
                ? const SizedBox(
                    width: 26,
                    height: 26,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/google.png',
                        height: 22.h,
                        width: 22.w,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          letterSpacing: 0.3,
                          fontFamily: AppFonts.poppins,
                        ),
                      ),
                    ],
                  ),
          ),
        ).animate().fadeIn(duration: 700.ms, delay: 200.ms));
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.only(bottom: 24.h, left: 24.w, right: 24.w, top: 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'By continuing, you agree to our',
            style: TextStyle(fontSize: 13.sp, color: ColorConstants.grey, fontFamily: AppFonts.poppins),
          ),
          SizedBox(height: 4.h),
          Text.rich(
            TextSpan(
              text: 'Terms of Service',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: ColorConstants.appThemeColor,
                fontFamily: AppFonts.poppins,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => _launchUrl('https://www.freeprivacypolicy.com/live/61d80502-cadf-40e0-bd63-3b2959fd3ecd'),
              children: [
                TextSpan(
                  text: ' and ',
                  style: TextStyle(fontSize: 13.sp, color: ColorConstants.grey, fontFamily: AppFonts.poppins),
                ),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.appThemeColor,
                    fontFamily: AppFonts.poppins,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => _launchUrl('https://www.freeprivacypolicy.com/live/61d80502-cadf-40e0-bd63-3b2959fd3ecd'),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 800.ms, delay: 400.ms),
        ],
      ),
    );
  }

  Widget _buildBlurCircle(double size, Color color) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Future<void> _launchUrl(String link) async {
    final uri = Uri.parse(link);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('Error', 'Could not open link', backgroundColor: Colors.red);
    }
  }
}