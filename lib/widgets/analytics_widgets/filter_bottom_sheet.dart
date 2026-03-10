// widgets/analytics_widgets/filter_bottom_sheet.dart
import 'package:intl/intl.dart';
import '../../core/app-export.dart';

mixin FilterableController {
  RxString get selectedFilter;
  RxString get selectedFilterRange;
  void selectFilter(String filter);
  void updateCustomDateRange(DateTime? from, DateTime? to);
}

class FilterBottomSheet extends StatelessWidget {
  final FilterableController controller;

  const FilterBottomSheet({super.key, required this.controller});

  // Date format helper
  // ignore: unused_element
  String _formatDate(DateTime date) => DateFormat('dd MMM yyyy').format(date);

  Future<void> _showCustomDatePicker(BuildContext context) async {
    final DateTime? from = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 7)),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFFFF9800)),
          ),
          child: child!,
        );
      },
    );

    if (from == null) return;

    final DateTime? to = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: from,
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFFFF9800)),
          ),
          child: child!,
        );
      },
    );

    if (to != null) {
      controller.updateCustomDateRange(from, to);
      controller.selectFilter('Custom');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Select Filter',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.grey,
                  ),
                ),
              ),
              const Divider(height: 1),

              // Filter Options
              _buildFilterOption('Today'),
              _buildFilterOption('Yesterday'),
              _buildFilterOption('Last 7 Days'),
              _buildCustomFilterOption(context),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterOption(String label) {
    return Obx(() {
      final isSelected = controller.selectedFilter.value == label;

      return InkWell(
        onTap: () => controller.selectFilter(label),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          color: isSelected ? const Color(0xFFFFF3E0) : Colors.transparent,
          child: Row(
            children: [
              Icon(
                isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
                color: isSelected
                    ? const Color(0xFFFF9800)
                    : Colors.grey.shade400,
                size: 22,
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? const Color(0xFF212121)
                      : Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildCustomFilterOption(BuildContext context) {
    return Obx(() {
      final isSelected = controller.selectedFilter.value == 'Custom';

      return InkWell(
        onTap: () => _showCustomDatePicker(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          color: isSelected ? const Color(0xFFFFF3E0) : Colors.transparent,
          child: Row(
            children: [
              Icon(
                isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
                color: isSelected
                    ? const Color(0xFFFF9800)
                    : Colors.grey.shade400,
                size: 22,
              ),
              const SizedBox(width: 16),
              Text(
                'Custom Date',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? const Color(0xFF212121)
                      : Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
