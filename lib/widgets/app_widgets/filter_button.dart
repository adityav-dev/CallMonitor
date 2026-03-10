import 'package:call_monitor/core/app-export.dart';


class FilterButton extends StatelessWidget {
  final String label;
  final RxBool isSelected;
  final VoidCallback onTap;

  const FilterButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected.value
              ? ColorConstants.appThemeColor
              : ColorConstants.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: AppFonts.poppins,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: isSelected.value
                ? ColorConstants.white
                : ColorConstants.grey,
          ),
        ),
      ),
    ));
  }
}