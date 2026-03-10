import '../../core/app-export.dart';

class CalendarButton extends StatelessWidget {
  final RxBool isSelected;
  final VoidCallback onTap;

  const CalendarButton({
    super.key,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: isSelected.value
                  ? ColorConstants.appThemeColor
                  : ColorConstants.white,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: isSelected.value
                      ? ColorConstants.appThemeColor.withOpacity(0.3)
                      : ColorConstants.grey.withOpacity(0.15),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.calendar_month,
              size: 22.sp,
              color: isSelected.value
                  ? ColorConstants.white
                  : ColorConstants.appThemeColor.withOpacity(0.8),
            ),
          ),
        ));
  }
}

class SelectedDateRange extends StatelessWidget {
  final String formattedStartDate;
  final String formattedEndDate;

  const SelectedDateRange({
    super.key,
    required this.formattedStartDate,
    required this.formattedEndDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: ColorConstants.grey.withOpacity(0.3)),
      ),
      child: Text(
        'Selected: $formattedStartDate - $formattedEndDate',
        style: TextStyle(
          fontFamily: AppFonts.poppins,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: ColorConstants.appThemeColor,
        ),
      ),
    );
  }
}
