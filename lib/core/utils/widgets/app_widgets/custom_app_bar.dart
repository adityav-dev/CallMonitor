import '../../../app-export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.height,
    this.title,
    this.subtitle,
    this.centerTitle = false,
    this.leadingWidth,
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
  final double? leadingWidth;
  final VoidCallback? onTapLogo;
  final VoidCallback? onTapBack;
  final bool showAppLogo;
  final bool showBackButton;
  final List<Widget>? actions;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  @override
  Widget build(BuildContext context) {
    final appBarHeight = height ?? 60.h; // Same as before

    return AppBar(
      elevation: 0,
      toolbarHeight: appBarHeight,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      flexibleSpace: _whiteBackground(context, appBarHeight),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
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
                  ? IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: 24.sp,
                        color: Colors.black,
                      ),
                      onPressed: onTapBack ?? () => Navigator.pop(context),
                      padding: EdgeInsets.all(12.w),
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
                          color: Colors.black,
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
                          color: Colors.grey[600],
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
  Size get preferredSize => Size.fromHeight(height ?? 55.h);

  /// White background covering status bar + app bar
  Widget _whiteBackground(BuildContext context, double appBarHeight) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Container(
      height: appBarHeight + topPadding,
      width: double.infinity,
      color: Colors.white,
    );
  }
}
