import 'dart:io';
import 'package:call_monitor/views/contacts/contacts_screen.dart';
import 'package:iconly/iconly.dart';
import '../../../core/app-export.dart';
import '../dashboard/dashboard_screen.dart';
import '../call_logs/call_logs_screen.dart';
import '../more_flow/more_screen/more_screen.dart';
import 'controller/bottom_bar_controller.dart';

class BottomBarScreen extends GetView<BottomBarController> {
  const BottomBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      body: Obx(() {
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            if (controller.numberClick.value == 0) {
              controller.lastTime.value = DateTime.now();
              controller.numberClick.value++;
              showExitPrompt(context);
            } else if (controller.numberClick.value == 1 &&
                DateTime.now().difference(controller.lastTime.value) <=
                    const Duration(seconds: 3)) {
              exit(0);
            } else {
              controller.numberClick.value = 0;
              controller.lastTime.value = DateTime.now();
              controller.numberClick.value++;
              showExitPrompt(context);
            }
          },
          child: IndexedStack(
            index: controller.currentIndex.value,
            children: const [
              DashboardScreen(),
              CallLogsScreen(),
              ContactsScreen(),
              MoreScreen(),
            ],
          ),
        );
      }),
      bottomNavigationBar: Obx(() {
        return CustomBottomNavBar(
          selectedIndex: controller.currentIndex.value,
          onTap: (index) => controller.changeIndex(index),
        );
      }),
    );
  }

  void showExitPrompt(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Press Back Button Again to Exit',
          style: TextStyle(fontFamily: AppFonts.poppins),
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────
// CUSTOM BOTTOM NAV BAR (LIGHT MODE + ICONLY ICONS + GRADIENT)
// ──────────────────────────────────────────────────────────────
class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int)? onTap;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    this.onTap,
  });

  // Define your 4 tabs with Iconly icons
  static final List<_NavItem> _items = [
    _NavItem(icon: IconlyLight.home, label: "Analytics"),
    _NavItem(icon: IconlyLight.call, label: "Call Logs"),
    _NavItem(icon: IconlyLight.user, label: "Contacts"),
    _NavItem(icon: IconlyLight.profile, label: "Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _items.asMap().entries.map((entry) {
          final int index = entry.key;
          final _NavItem item = entry.value;

          return _BottomIcon(
            icon: item.icon,
            label: item.label,
            selected: selectedIndex == index,
            onTap: () => onTap?.call(index),
          );
        }).toList(),
      ),
    );
  }
}

// Helper class for nav items
class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}

// ──────────────────────────────────────────────────────────────
// SINGLE BOTTOM ICON + LABEL (WITH GRADIENT & GREY STATES)
// ──────────────────────────────────────────────────────────────
class _BottomIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _BottomIcon({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  // Reusable gradient for selected state (brand purple)
  static final LinearGradient _selectedGradient = const LinearGradient(
    colors: [
      ColorConstants.primaryGradient1,
      ColorConstants.primaryGradient2,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ─── ICON ───
            selected
                ? ShaderMask(
                    shaderCallback: (bounds) =>
                        _selectedGradient.createShader(bounds),
                    child: Icon(icon, color: Colors.white, size: 24),
                  )
                : Icon(icon, color: ColorConstants.grey, size: 24),

            const SizedBox(height: 4),

            // ─── LABEL ───
            selected
                ? ShaderMask(
                    shaderCallback: (bounds) =>
                        _selectedGradient.createShader(bounds),
                    child: Text(
                      label,
                      style: TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white, // Required for ShaderMask
                      ),
                    ),
                  )
                : Text(
                    label,
                    style: TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: ColorConstants.grey,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
