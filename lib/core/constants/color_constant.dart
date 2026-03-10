import '../app-export.dart';

class ColorConstants {
  // 🎨 PRIMARY BRAND COLORS
  // static const Color appThemeColor = Color(0xFF5D822E);
  static const Color appThemeColor = Color(0xFF56369B); // Brand purple
  static const appThemeColor1 = Color(0xFF452C83); // Darker purple for outline/spinner
  static const secondaryColor = Color(0xFFFFD23F); // Golden yellow accents
  static const accentColor = Color(0xFFFFC107); // Amber for highlights

  // Primary Brand Gradients (Purple)
  static const primaryGradient1 = Color(0xFF56369B);
  static const primaryGradient2 = Color(0xFF6E4CB7);
  static const primaryGradient3 = Color(0xFF452C83);

  // Professional Blue Gradients (CRM Standard)
  static const blueGradient1 = Color(0xFF2196F3);    // Material Blue
  static const blueGradient2 = Color(0xFF64B5F6);    // Light Blue
  static const blueGradient3 = Color(0xFF1976D2);    // Dark Blue
  static const blueGradient4 = Color(0xFF0D47A1);    // Deep Blue

  // Success & Growth Gradients
  static const successGradient1 = Color(0xFF4CAF50);  // Green
  static const successGradient2 = Color(0xFF66BB6A);  // Light Green
  static const successGradient3 = Color(0xFF2E7D32);  // Dark Green

  // Warning & Attention Gradients
  static const warningGradient1 = Color(0xFFFF9800);  // Orange
  static const warningGradient2 = Color(0xFFFFB74D);  // Light Orange
  static const warningGradient3 = Color(0xFFF57400);  // Dark Orange// Dark Red

  // Premium & Enterprise Gradients
  static const premiumGradient1 = Color(0xFF9C27B0);  // Purple
  static const premiumGradient2 = Color(0xFFBA68C8);  // Light Purple
  static const premiumGradient3 = Color(0xFF7B1FA2);  // Dark Purple
  static const premiumGradient4 = Color(0xFF4A148C);  // Deep Purple

  // 🌟 LEGACY COLORS (keeping for compatibility)
  static const redColor = Color(0xFFC5354F);
  static const appBarColor2 = Color(0xFF721F2E);
  static const error = Color(0xFFE42222);
  static Color errorBorder = const Color(0xFF990000);
  static const resendOtp = Color(0xFFB88B00);
  static const inactive = Color(0xFFE8E8E8);
  static const orangeTwo = Color(0xFFF9E5D7);
  static const lightPink = Color(0xFFFFF0F1);

  // Static fixed colors
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);

  // 🌙 DARK MODE SPECIFIC COLORS
  static const darkPrimary = Color(0xFF56369B);
  static const darkSecondary = Color(0xFFFFD23F);
  static const darkAccent = Color(0xFFFFC107);
  static const darkSurface = Color(0xFF121212);
  static const darkBackground = Color(0xFF000000);
  static const darkCard = Color(0xFF1E1E1E);

  // ☀️ LIGHT MODE SPECIFIC COLORS
  static const lightPrimary = Color(0xFF56369B);
  static const lightSecondary = Color(0xFFFFD23F);
  static const lightAccent = Color(0xFFFFC107);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightBackground = Color(0xFFFAFAFA);
  static const lightCard = Color(0xFFFFFFFF);

  // 🎯 DYNAMIC COLORS BASED ON THEME
  static Color get homeBackgroundColor =>
      const Color(0xFFFFFFFF);

  static Color get surfaceColor =>
      Get.isDarkMode ? darkSurface : lightSurface;

  static Color get cardColor =>
      Get.isDarkMode ? darkCard : lightCard;

  static Color get textColor =>
      Get.isDarkMode ? const Color(0xFFE0E0E0) : const Color(0xFF424242);

  static Color get blackText =>
      Get.isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFF212121);

  static Color get lightTextColor =>
      Get.isDarkMode ? const Color(0xFFB0B0B0) : const Color(0xFF757575);

  static Color get colorHeading =>
      Get.isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFF212121);

  static Color get grey =>
      Get.isDarkMode ? const Color(0xFF9E9E9E) : const Color(0xFF757575);

  static Color get lightGrey =>
      Get.isDarkMode ? const Color(0xFF424242) : const Color(0xFFE0E0E0);

  static Color get outlineStroke =>
      Get.isDarkMode ? const Color(0xFF424242) : const Color(0xFFE0E0E0);

  static Color get appgrey =>
      Get.isDarkMode ? const Color(0xFF2A2A2A) : const Color(0xFFF5F5F5);

  static Color get greyBG =>
      Get.isDarkMode ? const Color(0xFF121212) : const Color(0xFFFAFAFA);

  static Color get greyBgs =>
      Get.isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFF3F3F3);

  static Color get neutral20 =>
      Get.isDarkMode ? const Color(0xFF1C1C1C) : const Color(0xFFF5F6F7);

  static Color get cardAcceptedBG =>
      Get.isDarkMode ? const Color(0xFF003B1F) : const Color(0xFFE0F2F1);


  // WhatsApp Style Gradient Colors 🌿
  static const whatsappGradientDark = Color(0xFF075E54); // Dark green
  static const whatsappGradientLight = Color(0xFF128C7E); // Light green

  static const LinearGradient whatsappGradient = LinearGradient(
    colors: [
      whatsappGradientDark,
      whatsappGradientLight,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

}
