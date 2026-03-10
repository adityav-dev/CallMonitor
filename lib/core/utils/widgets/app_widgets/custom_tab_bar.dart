import '../../../app-export.dart';

class CustomTabBar extends StatelessWidget {
  final List<Tab> tabs;
  final Function(int)? onTap;
  final Color? backgroundColor;
  final BoxDecoration? decoration; // ✅ Added decoration property
  final Color? indicatorColor;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final double? height;
  final EdgeInsets? labelPadding;
  final EdgeInsets? indicatorPadding;
  final bool isScrollable;

  const CustomTabBar({
    super.key,
    required this.tabs,
    this.onTap,
    this.backgroundColor,
    this.decoration, // ✅ New parameter
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.height,
    this.labelPadding,
    this.indicatorPadding,
    this.isScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 60.h,
      decoration:
          decoration ??
          BoxDecoration(
            // ✅ Use decoration if provided
            color: backgroundColor ?? Colors.white,
            border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
          ),
      child: TabBar(
        tabs: tabs,
        isScrollable: isScrollable,
        labelPadding:
            labelPadding ??
            (isScrollable
                ? EdgeInsets.only(right: 30.w)
                : EdgeInsets.symmetric(horizontal: 4.w)),
        indicatorPadding: indicatorPadding ?? EdgeInsets.zero,
        indicatorColor: indicatorColor ?? ColorConstants.appThemeColor,
        labelColor: labelColor ?? ColorConstants.appThemeColor,
        unselectedLabelColor: unselectedLabelColor ?? Colors.grey,
        labelStyle:
            labelStyle ??
            TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.poppins,
            ),
        unselectedLabelStyle:
            unselectedLabelStyle ??
            TextStyle(fontSize: 11.sp, fontFamily: AppFonts.poppins),
        indicatorSize: isScrollable
            ? TabBarIndicatorSize.label
            : TabBarIndicatorSize.tab,
        onTap: onTap,
      ),
    );
  }
}
