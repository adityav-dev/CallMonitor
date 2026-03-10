import '../../../core/app-export.dart';
import 'package:shimmer/shimmer.dart';
import 'controller/more_controller.dart';

class MoreScreen extends GetView<MoreController> {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: CustomAppBar(
        title: 'Profile',
        centerTitle: true,
        showBackButton: false,
        onTapBack: () => Get.back(),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.refreshSettings();
          await Future.delayed(const Duration(milliseconds: 500));
        },
        displacement: 60,
        color: ColorConstants.appThemeColor,
        backgroundColor: ColorConstants.white,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              _buildUserProfileSection(controller, context),
              SizedBox(height: 8.h),
              _buildRoleBasedSections(),
              _buildCardSection(
                context: context,
                title: 'Account',
                children: [
                  _buildSettingsItem(
                    context: context,
                    icon: Icons.person_outline,
                    iconColor: ColorConstants.appThemeColor,
                    iconBackground: ColorConstants.appThemeColor.withAlpha(20),
                    title: 'Profile Info',
                    subtitle: 'Edit your account details',
                    onTap: controller.onProfileInfoTap,
                  ),
                  _buildSettingsItem(
                    context: context,
                    icon: Icons.help_outline,
                    iconColor: ColorConstants.appThemeColor,
                    iconBackground: ColorConstants.appThemeColor.withAlpha(20),
                    title: 'Help & Support',
                    subtitle: 'Find answers to your questions',
                    onTap: controller.onHelpSupportTap,
                  ),
                ],
              ),
              _buildCardSection(
                context: context,
                title: '',
                children: [
                  _buildSettingsItem(
                    context: context,
                    icon: Icons.logout,
                    iconColor: ColorConstants.appThemeColor,
                    iconBackground: ColorConstants.appThemeColor.withAlpha(20),
                    title: 'Logout',
                    subtitle: 'Are you sure you want to logout?',
                    onTap: controller.onLogoutTap,
                    isLast: true,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  // Role-based sections
  Widget _buildRoleBasedSections() {
    return Obx(() {
      if (controller.userRole.value == 'client') {
        return _buildHumanAgentsSection();
      } else if (controller.userRole.value == 'executive' ||
          controller.userRole.value == 'humanAgent') {
        return _buildAssociatedClientsSection();
      }
      return const SizedBox.shrink();
    });
  }

  Widget _buildHumanAgentsSection() {
    return Obx(
      () => controller.isHumanAgentsLoading.value
          ? _buildShimmerSection()
          : _buildCardSection(
              context: Get.context!,
              title: '',
              children: [
                _buildSettingsItem(
                  context: Get.context!,
                  icon: Icons.people,
                  iconColor: ColorConstants.appThemeColor,
                  iconBackground: ColorConstants.appThemeColor.withAlpha(20),
                  title: 'Team',
                  subtitle:
                      '${controller.humanAgents.length} members available',
                  onTap: controller.onHumanAgentsTap,
                  isLast: true,
                ),
              ],
            ),
    );
  }

  Widget _buildAssociatedClientsSection() {
    return Obx(
      () => controller.isAssociatedClientsLoading.value
          ? _buildShimmerSection()
          : _buildCardSection(
              context: Get.context!,
              title: 'Associated Clients',
              children: [
                _buildSettingsItem(
                  context: Get.context!,
                  icon: Icons.business,
                  iconColor: ColorConstants.appThemeColor,
                  iconBackground: ColorConstants.appThemeColor.withAlpha(20),
                  title: 'Associated Clients',
                  subtitle:
                      '${controller.associatedClients.length} clients available',
                  onTap: controller.onAssociatedClientsTap,
                  isLast: true,
                ),
              ],
            ),
    );
  }

  Widget _buildShimmerSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(16.w),
      child: Shimmer.fromColors(
        baseColor: ColorConstants.lightGrey,
        highlightColor: ColorConstants.lightGrey.withAlpha(60),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConstants.white,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 16.h,
                    width: 120.w,
                    color: ColorConstants.white,
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    height: 14.h,
                    width: 80.w,
                    color: ColorConstants.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  //  Replace the whole _buildUserProfileSection (and keep the 3 helpers)
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildUserProfileSection(
    MoreController controller,
    BuildContext context,
  ) {
    return Obx(() {
      // ── Shimmer while loading ───────────────────────────────────────
      if (controller.isProfileLoading.value ||
          (controller.userName.value.isEmpty &&
              controller.businessName.value.isEmpty)) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          color: ColorConstants.white,
          child: Row(
            children: [
              Shimmer.fromColors(
                baseColor: ColorConstants.lightGrey,
                highlightColor: ColorConstants.lightGrey.withAlpha(60),
                child: Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConstants.white,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: ColorConstants.lightGrey,
                      highlightColor: ColorConstants.lightGrey.withAlpha(60),
                      child: Container(
                        height: 14.h,
                        width: 80.w,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Shimmer.fromColors(
                      baseColor: ColorConstants.lightGrey,
                      highlightColor: ColorConstants.lightGrey.withAlpha(60),
                      child: Container(
                        height: 18.h,
                        width: 150.w,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Shimmer.fromColors(
                      baseColor: ColorConstants.lightGrey,
                      highlightColor: ColorConstants.lightGrey.withAlpha(60),
                      child: Container(
                        height: 14.h,
                        width: 200.w,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }

      // ── Main profile content ───────────────────────────────────────
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        color: ColorConstants.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── AVATAR / LOGO ───────────────────────────────────────
            Obx(() {
              if (controller.userRole.value == 'client' &&
                  controller.clientLogo.value.isNotEmpty) {
                return Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipOval(
                    child: Image.network(
                      controller.clientLogo.value,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _fallbackIcon(true),
                      loadingBuilder: (c, child, progress) =>
                          progress == null ? child : _shimmerAvatar(),
                    ),
                  ),
                );
              }
              return _fallbackIcon(controller.userRole.value == 'client');
            }),

            // ───────────────────────────────────────────────────────
            SizedBox(width: 16.w),

            // ── TEXT AREA (business name, name+role, email) ───────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---- BUSINESS NAME (alone) -------------------------
                  Text(
                    controller.businessName.value,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFonts.poppins,
                      color: ColorConstants.appThemeColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),

                  // ---- USER NAME + ROLE BADGE (same row) -------------
                  LayoutBuilder(
                    builder: (ctx, constraints) {
                      return ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // User name – can wrap
                            Expanded(
                              child: Text(
                                controller.userName.value,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppFonts.poppins,
                                  color: ColorConstants.grey,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                            // Role badge – always on the right
                            _roleBadge(controller),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 4.h),

                  // ---- EMAIL -----------------------------------------
                  Text(
                    controller.userEmail.value,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: AppFonts.poppins,
                      color: ColorConstants.lightTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  // ── Helper: fallback icon (client / person) ─────────────────────
  Widget _fallbackIcon(bool isClient) {
    return Container(
      width: 60.w,
      height: 60.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorConstants.grey.withAlpha(38),
      ),
      child: Icon(
        isClient ? Icons.business : Icons.person,
        size: 30.w,
        color: ColorConstants.grey,
      ),
    );
  }

  // ── Helper: shimmer avatar ─────────────────────────────────────
  Widget _shimmerAvatar() {
    return Shimmer.fromColors(
      baseColor: ColorConstants.lightGrey,
      highlightColor: ColorConstants.lightGrey.withAlpha(60),
      child: Container(width: 60.w, height: 60.h, color: Colors.white),
    );
  }

  // ── Helper: role badge (Admin for client, otherwise role name) ─────
  Widget _roleBadge(MoreController controller) {
    final String label = controller.userRole.value == 'client'
        ? 'Admin'
        : (controller.userRole.value.capitalizeFirst ?? '');

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: ColorConstants.grey),
        color: ColorConstants.appThemeColor.withOpacity(0.08),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          fontFamily: AppFonts.poppins,
          color: ColorConstants.grey,
        ),
      ),
    );
  }

  Widget _buildCreditsSection(MoreController controller, BuildContext context) {
    return Obx(() {
      return Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              ColorConstants.appThemeColor,
              ColorConstants.appThemeColor1,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.appThemeColor1.withAlpha(60),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: controller.isCreditsLoading.value
            ? Shimmer.fromColors(
                baseColor: ColorConstants.lightGrey,
                highlightColor: ColorConstants.lightGrey.withAlpha(60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 120.w, height: 20.h, color: Colors.white),
                    SizedBox(height: 12.h),
                    Container(
                      width: double.infinity,
                      height: 20.h,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      width: double.infinity,
                      height: 20.h,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Credits',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.white,
                          fontFamily: AppFonts.poppins,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.payment,
                          size: 24.w,
                          color: ColorConstants.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Available Balance',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: ColorConstants.white.withOpacity(0.7),
                                fontFamily: AppFonts.poppins,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              '${controller.totalCredits.value}',
                              style: TextStyle(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w500,
                                color: ColorConstants.white,
                                fontFamily: AppFonts.poppins,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          // Get.toNamed(AppRoutes.paymentHistoryScreen);
                        },
                        child: Icon(
                          Icons.visibility_outlined,
                          size: 20.w,
                          color: ColorConstants.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Get.toNamed(
                          //   AppRoutes.addRechargeScreen,
                          //   arguments: {
                          //     'totalCredits': controller.totalCredits.value,
                          //   },
                          // );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: ColorConstants.white,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Add Credits',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: ColorConstants.white,
                                fontFamily: AppFonts.poppins,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            const Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: ColorConstants.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      );
    });
  }

  Widget _buildCardSection({
    required BuildContext context,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.trim().isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.poppins,
                  color: ColorConstants.black,
                ),
              ),
            ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(
                    color: ColorConstants.lightGrey.withAlpha(50),
                    width: 0.5,
                  ),
                ),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconBackground,
              ),
              child: Icon(icon, color: iconColor, size: 20.w),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFonts.poppins,
                      color: ColorConstants.black,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppFonts.poppins,
                      color: ColorConstants.grey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: ColorConstants.grey, size: 20),
          ],
        ),
      ),
    );
  }
}
