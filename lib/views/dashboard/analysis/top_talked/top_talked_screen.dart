import 'package:call_monitor/views/dashboard/analysis/top_talked/controller/top_talked_controller.dart';
import '../../../../core/app-export.dart';

class TopTalkedScreen extends GetView<TopTalkedController> {
  const TopTalkedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {};
    final type = args['type'] ?? 'frequently';
    controller.initType(type);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: type,
        titleStyle: TextStyle(
          fontFamily: AppFonts.poppins,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        showBackButton: true,
        onTapBack: () => Get.back(),
      ),
      body: Column(
        children: [
          // Tabs
          Obx(() => _buildTabBar()),

          // List
          Expanded(child: Obx(() => _buildContactList())),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildTabButton(
              icon: Icons.phone,
              label: 'All',
              count: controller.allCalls.length,
              index: 0,
              isSelected: controller.selectedTab.value == 0,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildTabButton(
              icon: Icons.phone_callback,
              label: 'Incoming',
              count: controller.incomingCalls.length,
              index: 1,
              isSelected: controller.selectedTab.value == 1,
              iconColor: const Color(0xFF8BC34A),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildTabButton(
              icon: Icons.phone_forwarded,
              label: 'Outgoing',
              count: controller.outgoingCalls.length,
              index: 2,
              isSelected: controller.selectedTab.value == 2,
              iconColor: const Color(0xFFFFA726),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required IconData icon,
    required String label,
    required int count,
    required int index,
    required bool isSelected,
    Color? iconColor,
  }) {
    final displayIconColor = isSelected
        ? Colors.black
        : (iconColor ?? Colors.grey);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => controller.changeTab(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: displayIconColor, size: 22),
          const SizedBox(height: 4),
          Text(
            '$label ($count)',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.black : Colors.grey,
              fontFamily: AppFonts.poppins,
            ),
          ),
          const SizedBox(height: 4),
          if (isSelected)
            Container(
              height: 2,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContactList() {
    final contacts = controller.getCurrentTabData();
    final type = controller.type.value;

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: contacts.length,
      separatorBuilder: (context, index) =>
          const Divider(height: 1, color: Color(0xFFE0E0E0)),
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return _ContactListItem(
          contact: contact,
          isDurationType: type == 'duration',
        );
      },
    );
  }
}

class _ContactListItem extends StatelessWidget {
  final ContactCall contact;
  final bool isDurationType;

  const _ContactListItem({required this.contact, required this.isDurationType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 36.w,
            height: 36.w,
            decoration: const BoxDecoration(
              color: Color(0xFFFFA726),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person, color: Colors.white, size: 22.w),
          ),
          const SizedBox(width: 12),

          // Contact Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    fontFamily: AppFonts.poppins,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  contact.phoneNumber,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                    fontFamily: AppFonts.poppins,
                  ),
                ),
              ],
            ),
          ),

          // Right Side Value
          Text(
            isDurationType
                ? contact.totalDuration
                : '${contact.callCount} Call${contact.callCount > 1 ? 's' : ''}',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
              fontFamily: AppFonts.poppins,
            ),
          ),
        ],
      ),
    );
  }
}
