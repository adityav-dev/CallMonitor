import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../data/model/analytics_model/call_history_model.dart';
import '../../../../widgets/analytics_widgets/filter_bottom_sheet.dart';

class TotalPhoneCallsController extends GetxController
    with FilterableController {
  final RxInt selectedTab = 0.obs;

  @override
  final RxString selectedFilter = 'Yesterday'.obs;

  @override
  final RxString selectedFilterRange = ''.obs;

  // Custom date storage
  DateTime? customFrom;
  DateTime? customTo;

  final RxList<CallHistoryItem> callHistoryList = <CallHistoryItem>[
    CallHistoryItem(
      name: 'Krushna TDS',
      phoneNumber: '+917385664978',
      date: '31 Oct 2025',
      time: '10:14 PM',
      duration: '3m 28s',
      callType: CallType.incoming,
    ),
    CallHistoryItem(
      name: 'Ankur Bhaii',
      phoneNumber: '+918604579654',
      date: '31 Oct 2025',
      time: '09:21 PM',
      duration: '41m 35s',
      callType: CallType.incoming,
    ),
    CallHistoryItem(
      name: 'Brijendra CS',
      phoneNumber: '+917785889485',
      date: '31 Oct 2025',
      time: '09:17 PM',
      duration: '1m 44s',
      callType: CallType.outgoing,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    // Set initial range on load
    selectFilter('Yesterday');
  }

  void changeTab(int index) => selectedTab.value = index;

  void showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => FilterBottomSheet(
        controller: this as FilterableController, // ✅ Fixed!
      ),
    );
  }

  @override
  void selectFilter(String filter) {
    selectedFilter.value = filter;
    Get.back();
    _updateDateRange(filter);
  }

  void _updateDateRange(String filter) {
    final now = DateTime(2025, 11, 4); // Current date: Nov 04, 2025
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final last7Start = today.subtract(const Duration(days: 6));

    String range;

    switch (filter) {
      case 'Today':
        range = 'Today 12:00 AM - 11:59 PM';
        break;
      case 'Yesterday':
        range = '${_formatDate(yesterday)} 12:00 AM - 11:59 PM';
        break;
      case 'Last 7 Days':
        range = '${_formatDate(last7Start)} - ${_formatDate(today)}';
        break;
      case 'Custom':
        if (customFrom != null && customTo != null) {
          range =
              'Custom: ${_formatDate(customFrom!)} - ${_formatDate(customTo!)}';
        } else {
          range = 'Custom Date';
        }
        break;
      default:
        range = filter;
    }

    selectedFilterRange.value = range;
  }

  @override
  void updateCustomDateRange(DateTime? from, DateTime? to) {
    customFrom = from;
    customTo = to;
    _updateDateRange('Custom');
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd MMM').format(date); // e.g., 04 Nov
  }
}
