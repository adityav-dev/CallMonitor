import '../../../../core/app-export.dart';
import 'controller/help_support_controller.dart';

class HelpSupportScreen extends GetView<HelpSupportController> {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Help & Support",
        showBackButton: true,
        titleStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          fontFamily: AppFonts.poppins,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Need assistance? We’re just a message away.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.textColor,
                ),
              ),
              SizedBox(height: 20.h),
              _buildSupportCard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSupportCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorConstants.cardColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Get in Touch with Us',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: ColorConstants.blackText,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Our team is here 24/7 to assist you with any queries or issues.',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12.sp,
                color: ColorConstants.lightTextColor,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: _buildSupportOption(
                    context: context,
                    icon: Icons.email,
                    title: 'Email Our Team',
                    actionText: 'Send Message',
                    onTap: controller.sendEmail,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildSupportOption(
                    context: context,
                    icon: Icons.phone,
                    title: 'Speak with Support',
                    actionText: 'Call Now',
                    onTap: controller.makeCall,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String actionText,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: ColorConstants.lightBackground,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: ColorConstants.whatsappGradient,
              ),
              child: Icon(icon, size: 20.h, color: ColorConstants.white),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: ColorConstants.blackText,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              actionText,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: ColorConstants.appThemeColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
