import 'package:intl/intl.dart';
import '../../../../data/model/myDial/call_log_model.dart' hide CallLog;
import '../core/app-export.dart';
import '../views/call_logs/controller/call_logs_controller.dart';

class CallLogItemWidget extends StatelessWidget {
  final CallLog callLog;
  final CallLogsController controller;

  const CallLogItemWidget({
    super.key,
    required this.callLog,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: ColorConstants.grey.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.grey.withOpacity(0.12),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TOP ROW: Name + Number + Time + Duration
            /// ------------------------------
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: callLog.isIncoming
                        ? Colors.green.withOpacity(0.15)
                        : Colors.orange.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    callLog.isIncoming ? Icons.call_received : Icons.call_made,
                    color: callLog.isIncoming ? Colors.green : Colors.orange,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                // SizedBox(width: 10.w), // Optional left spacing if icon re-added

                /// Caller Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        callLog.contactName.isNotEmpty
                            ? callLog.contactName
                            : "Unknown",
                        style: TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.black,
                          letterSpacing: 0.2,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        callLog.phoneNumber,
                        style: TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorConstants.grey.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),

                /// Time + Duration
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat('hh:mm a').format(callLog.dateTime),
                      style: TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.black,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '${callLog.duration.inMinutes}m ${callLog.duration.inSeconds % 60}s',
                      style: TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.grey.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 10.h),
            Divider(color: ColorConstants.grey.withOpacity(0.1), height: 1),
            SizedBox(height: 10.h),

            /// ------------------------------
            /// ACTION BUTTONS ROW
            /// ------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _iconButton(
                  icon: Icons.copy,
                  onTap: () => controller.copyNumber(callLog.phoneNumber),
                ),
                _iconButton(
                  icon: Icons.sms,
                  onTap: () => controller.sendSMS(callLog.phoneNumber),
                ),
                _iconButton(
                  icon: Icons.message,
                  iconColor: Colors.green,
                  onTap: () => controller.openWhatsApp(callLog.phoneNumber),
                ),
                _iconButton(
                  icon: Icons.call,
                  iconColor: ColorConstants.appThemeColor,
                  onTap: () => controller.makeCall(callLog.phoneNumber),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// ------------------------------
  /// Icon Button Builder
  /// ------------------------------
  Widget _iconButton({
    required IconData icon,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, color: iconColor ?? ColorConstants.grey, size: 20.sp),
    );
  }
}
