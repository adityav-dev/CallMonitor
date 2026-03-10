import '../../../app-export.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    this.loading,
    this.shape,
    this.padding,
    this.variant,
    this.fontStyle,
    this.alignment,
    this.margin,
    this.onTap,
    this.width,
    this.height,
    this.text,
    this.prefixWidget,
    this.suffixWidget,
    this.rowWidget,
    this.child,
  });

  final bool? loading;
  final ButtonShape? shape;
  final ButtonPadding? padding;
  final ButtonVariant? variant;
  final ButtonFontStyle? fontStyle;
  final Alignment? alignment;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final String? text;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Widget? rowWidget;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(alignment: alignment!, child: _buildButtonWidget())
        : _buildButtonWidget();
  }

  Widget _buildButtonWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: TextButton(
        onPressed: (loading ?? false) ? null : onTap,
        style: _buildTextButtonStyle(),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (rowWidget != null) return rowWidget!;

    final spinner = SizedBox(
      height: 20.h,
      width: 20.h,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: ColorConstants.appThemeColor,
        valueColor: AlwaysStoppedAnimation<Color>(
          _getSpinnerColor(),
        ),
      ),
    );
    if (loading ?? false) {
      return Center(child: spinner);
    }
    if (child != null) {
      return Center(child: child!);
    }
    if (prefixWidget != null || suffixWidget != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefixWidget != null) prefixWidget!,
          if (prefixWidget != null) const SizedBox(width: 4),
          Expanded(
            child: Text(
              text ?? '',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: _setFontStyle(),
            ),
          ),
          if (suffixWidget != null) const SizedBox(width: 4),
          if (suffixWidget != null) suffixWidget!,
        ],
      );
    }

    // Default case: show the text in the center
    return Center(
      child: Text(
        text ?? '',
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: _setFontStyle(),
      ),
    );
  }

  ButtonStyle _buildTextButtonStyle() {
    return TextButton.styleFrom(
      fixedSize: Size(width ?? double.infinity, height ?? 40.h),
      padding: _setPadding(),
      backgroundColor: _setBackgroundColor(),
      foregroundColor: _getFontColor(),
      side: _setBorder(),
      shape: RoundedRectangleBorder(borderRadius: _setRadius()),
    );
  }

  /// 🎯 Improved: Spinner color always matches content
  Color _getSpinnerColor() {
    switch (variant) {
      case ButtonVariant.OutlineOnlyBorder:
        return ColorConstants.appThemeColor1;
      case ButtonVariant.White:
        return ColorConstants.secondaryColor;
      case ButtonVariant.OutlneColorHeading:
        return ColorConstants.colorHeading;
      default:
        return ColorConstants.white;
    }
  }

  EdgeInsets _setPadding() {
    switch (padding) {
      case ButtonPadding.PaddingAll10:
        return EdgeInsets.all(10.h);
      case ButtonPadding.PaddingT7:
        return EdgeInsets.only(right: 7.w, bottom: 7.h);
      default:
        return EdgeInsets.symmetric(horizontal: 12.w);
    }
  }

  /// ✅ Dynamic background fill
  Color _setBackgroundColor() {
    switch (variant) {
      case ButtonVariant.red:
        return ColorConstants.redColor;
      case ButtonVariant.White:
      case ButtonVariant.FillWhiteA700:
        return ColorConstants.white;
      case ButtonVariant.FillGray80001:
        return Get.isDarkMode ? ColorConstants.surfaceColor : const Color(0xFF424242);
      case ButtonVariant.OutlineOnlyBorder:
        return Colors.transparent;
      case ButtonVariant.OutlneColorHeading:
        return Colors.transparent;
      case ButtonVariant.FillActive:
        return ColorConstants.appThemeColor;
      case ButtonVariant.FillUnctive:
        return ColorConstants.appThemeColor;
      default:
        return ColorConstants.appThemeColor;
    }
  }

  /// ✅ Dynamic border outlines
  BorderSide? _setBorder() {
    switch (variant) {
      case ButtonVariant.White:
        return BorderSide(color: ColorConstants.secondaryColor, width: 1.w);
      case ButtonVariant.OutlinePink700:
        return BorderSide(color: ColorConstants.white, width: 1.w);
      case ButtonVariant.OutlneColorHeading:
        return BorderSide(color: ColorConstants.colorHeading, width: 1.w);
      case ButtonVariant.OutlineOnlyBorder:
        return BorderSide(color: ColorConstants.appThemeColor, width: 1.2.w);
      default:
        return null;
    }
  }

  BorderRadius _setRadius() {
    switch (shape) {
      case ButtonShape.Circle:
        return BorderRadius.circular((height ?? 40.h) / 2);
      case ButtonShape.Square:
        return BorderRadius.zero;
      case ButtonShape.RoundedBorder16:
        return BorderRadius.circular(16.r);
      case ButtonShape.RoundedBorder3:
        return BorderRadius.circular(3.r);
      default:
        return BorderRadius.circular(6.r);
    }
  }

  /// ✅ Consistent font color by variant & dark mode
  Color _getFontColor() {
    switch (variant) {
      case ButtonVariant.White:
        return ColorConstants.secondaryColor;
      case ButtonVariant.OutlineOnlyBorder:
        return ColorConstants.appThemeColor;
      case ButtonVariant.OutlneColorHeading:
        return ColorConstants.colorHeading;
      default:
        return ColorConstants.white;
    }
  }

  TextStyle _setFontStyle() {
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      fontFamily: AppFonts.poppins,
      color: _getFontColor(),
    );
  }
}

enum ButtonShape {
  Circle,
  Square,
  RoundedBorder6,
  RoundedBorder16,
  RoundedBorder3,
}

enum ButtonPadding {
  PaddingT12,
  PaddingAll10,
  PaddingT7,
}

enum ButtonVariant {
  red,
  White,
  FillGray80001,
  OutlinePink700,
  FillWhiteA700,
  OutlineGray30001_1,
  FillGray400,
  FillActive,
  FillUnctive,
  OutlneColorHeading,
  OutlineOnlyBorder,
}

enum ButtonFontStyle {
  MontserratRegular12,
  MontserratRegular13,
  MontserratMedium14,
  MontserratSemiBold12,
  MontserratSemiBold10,
  MontserratRegular10,
  MontserratSemiBold12WhiteA700,
}