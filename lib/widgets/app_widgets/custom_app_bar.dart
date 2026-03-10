import '../../core/app-export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.height,
    this.title,
    this.subtitle,
    this.centerTitle = false,
    this.styleType,
    this.leadingWidth,
    this.bgColor,
    this.onTapLogo,
    this.onTapBack,
    this.showAppLogo = false,
    this.showBackButton = false,
    this.actions,
    this.titleStyle,
    this.subtitleStyle,
  });

  final double? height;
  final String? title;
  final String? subtitle;
  final bool centerTitle;
  final Style? styleType;
  final double? leadingWidth;
  final Color? bgColor;
  final VoidCallback? onTapLogo;
  final VoidCallback? onTapBack;
  final bool showAppLogo;
  final bool showBackButton;
  final List<Widget>? actions;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  @override
  Widget build(BuildContext context) {
    final appBarHeight = height ?? 90.h;
    final isDark = Get.isDarkMode;

    return AppBar(
      elevation: 0,
      toolbarHeight: appBarHeight,
      automaticallyImplyLeading: false,
      backgroundColor: bgColor ?? _resolveBackgroundColor(isDark),
      flexibleSpace: _getStyle(context, appBarHeight, isDark),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      titleSpacing: 0,
      leadingWidth: showBackButton
          ? 60.w
          : showAppLogo
          ? (leadingWidth ?? 100.w)
          : 0,
      leading: (showBackButton || showAppLogo)
          ? Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: showBackButton
                  ? Container(
                      constraints: BoxConstraints(
                        minWidth: 48.w,
                        minHeight: 48.h,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: 24.sp,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (onTapBack != null) {
                            onTapBack!();
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                        padding: EdgeInsets.all(12.w),
                        constraints: const BoxConstraints(),
                      ),
                    )
                  : InkWell(
                      onTap: onTapLogo,
                      child: Image.asset(
                        ImageConstant.appLogo,
                        fit: BoxFit.contain,
                      ),
                    ),
            )
          : null,
      title: (title != null || subtitle != null)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: centerTitle
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style:
                        titleStyle ??
                        TextStyle(
                          fontSize: 20.sp,
                          fontFamily: AppFonts.playfair,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                  ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style:
                        subtitleStyle ??
                        TextStyle(
                          fontSize: 14.sp,
                          fontFamily: AppFonts.playfair,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                  ),
              ],
            )
          : null,
      centerTitle: centerTitle,
      actions: actions
          ?.map(
            (widget) => Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: widget,
            ),
          )
          .toList(),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, height ?? 50.h);

  /// ------------------------------
  /// Dynamic Gradient Styles
  /// ------------------------------
  Widget? _getStyle(BuildContext context, double appBarHeight, bool isDark) {
    final double fullHeight = appBarHeight + MediaQuery.of(context).padding.top;

    switch (styleType) {
      case Style.bgGradientWhatsApp:
        return Container(
          height: fullHeight,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: ColorConstants.whatsappGradient,
          ),
        );

      case Style.bgGradientDynamic:
        return Container(
          height: fullHeight,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFF1E56), Color(0xFF00FF85), Color(0xFFFFF200)],
            ),
          ),
        );

      case Style.bgGradientPink700Pink900:
        return Container(
          height: fullHeight,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [ColorConstants.redColor, ColorConstants.appBarColor2],
            ),
          ),
        );

      case Style.bgFillWhite:
        return Container(
          height: fullHeight,
          width: double.infinity,
          color: ColorConstants.white,
        );

      case Style.bgFillGrey:
        return Container(
          height: fullHeight,
          width: double.infinity,
          color: ColorConstants.greyBgs,
        );

      default:
        return Container(
          height: fullHeight,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: ColorConstants.whatsappGradient,
          ),
        );
    }
  }

  Color _resolveBackgroundColor(bool isDark) {
    if (styleType != null || bgColor != null) return Colors.transparent;
    return isDark ? const Color(0xFF121212) : ColorConstants.surfaceColor;
  }
}

enum Style {
  bgGradientWhatsApp,
  bgGradientDynamic,
  bgGradientPink700Pink900,
  bgFillWhite,
  bgFillGrey,
}
