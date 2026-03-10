// controller/never_attended_calls_controller.dart
import 'package:intl/intl.dart';

import '../../../../core/app-export.dart';
import '../../../../data/model/analytics_model/call_data_model.dart';
import '../../../../widgets/analytics_widgets/filter_bottom_sheet.dart';

class NeverAttendedCallsController extends GetxController
    with FilterableController {
  @override
  final RxString selectedFilter = 'Yesterday'.obs;

  @override
  final RxString selectedFilterRange = '31-Oct 12:00 AM - 31-Oct 11:59 PM'.obs;

  // For custom date range
  DateTime? customFrom;
  DateTime? customTo;

  final calls = <CallData>[
    CallData(
      name: 'Unknown',
      phoneNumber: '+918223000998',
      callCount: '3',
      date: '31 Oct 2025',
      time: '02:49 PM',
    ),
    CallData(
      name: 'John Doe',
      phoneNumber: '+919876543210',
      callCount: '1',
      date: '30 Oct 2025',
      time: '10:12 AM',
    ),
    CallData(
      name: 'Rahul Mehta',
      phoneNumber: '+919800112233',
      callCount: '2',
      date: '29 Oct 2025',
      time: '08:35 PM',
    ),
  ].obs;

  void showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => FilterBottomSheet(controller: this),
    );
  }

  @override
  void selectFilter(String filter) {
    selectedFilter.value = filter;
    Get.back();
    _updateDateRange(filter);
  }

  void _updateDateRange(String filter) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final last7Start = today.subtract(const Duration(days: 6));

    switch (filter) {
      case 'Today':
        selectedFilterRange.value = 'Today 12:00 AM - 11:59 PM';
        break;
      case 'Yesterday':
        selectedFilterRange.value = '${_format(yesterday)} 12:00 AM - 11:59 PM';
        break;
      case 'Last 7 Days':
        selectedFilterRange.value =
            '${_format(last7Start)} - ${_format(today)}';
        break;
      case 'Custom':
        if (customFrom != null && customTo != null) {
          selectedFilterRange.value =
              'Custom: ${_format(customFrom!)} - ${_format(customTo!)}';
        }
        break;
      default:
        selectedFilterRange.value = filter;
    }
  }

  @override
  void updateCustomDateRange(DateTime? from, DateTime? to) {
    customFrom = from;
    customTo = to;
    _updateDateRange('Custom');
  }

  String _format(DateTime date) => DateFormat('dd MMM').format(date);
}
