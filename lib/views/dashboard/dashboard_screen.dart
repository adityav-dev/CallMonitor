// lib/modules/dashboard/views/dashboard_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app-export.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/analytics_widgets/analysis_card.dart';
import '../../../widgets/analytics_widgets/summary_card.dart';
import '../../widgets/app_widgets/calendar_button.dart';
import '../../widgets/app_widgets/filter_button.dart';
import 'controller/dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (c) => DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: ColorConstants.white,
          appBar: CustomAppBar(
            title: 'Analytics',
            showBackButton: false,
            centerTitle: true,
          ),
          body: Obx(() {
            final loading = c.isLoading.value;
            return Stack(
              children: [
                Column(
                  children: [
                    // ── Filter Bar ──
                    _buildFilterBar(context, c),

                    // ── Tab Bar ──
                    Container(
                      color: Colors.white,
                      child: const TabBar(
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.black,
                        indicatorWeight: 3,
                        tabs: [
                          Tab(text: 'Summary'),
                          Tab(text: 'Analysis'),
                        ],
                      ),
                    ),

                    // ── Tab Content ──
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: c.refreshAnalytics,
                        color: ColorConstants.appThemeColor,
                        child: TabBarView(
                          children: [
                            _buildSummaryTab(c),
                            _buildAnalysisTab(c),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // ── Loader ──
                if (loading)
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.appThemeColor),
                      ),
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }

  // ==============================================================
  // FILTER BAR
  // ==============================================================
  Widget _buildFilterBar(BuildContext context, DashboardController c) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        children: [
          Wrap(
            spacing: 12.w,
            runSpacing: 8.h,
            children: [
              _filterButton('Yesterday', c.isYesterdaySelected, () => c.selectFilter('Yesterday')),
              _filterButton('Today', c.isTodaySelected, () => c.selectFilter('Today')),
              _filterButton('Last 7 Days', c.isLast7DaysSelected, () => c.selectFilter('Last 7 Days')),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dispositions',
                    style: TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CalendarButton(
                    isSelected: c.isCustomRangeSelected,
                    onTap: () => _showDatePicker(context, c),
                  ),
                ],
              ),
            ],
          ),
          if (c.isCustomRangeSelected.value)
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: _selectedDateChip(c),
            ),
        ],
      ),
    );
  }

  Widget _filterButton(String label, RxBool selected, VoidCallback onTap) {
    return FilterButton(
      label: label,
      isSelected: selected,
      onTap: onTap,
    );
  }

  Widget _selectedDateChip(DashboardController c) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ColorConstants.appThemeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: ColorConstants.appThemeColor.withOpacity(0.3)),
      ),
      child: Text(
        '${c.formattedDate(c.selectedRange.value.start)} to ${c.formattedDate(c.selectedRange.value.end)}',
        style: TextStyle(
          fontFamily: AppFonts.poppins,
          fontSize: 13.sp,
          color: ColorConstants.appThemeColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context, DashboardController c) {
    c.initializeCalendarRange();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Select Date Range',
            style: TextStyle(fontFamily: AppFonts.poppins, fontSize: 16.sp, fontWeight: FontWeight.w500)),
        content: Obx(() => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Start
                TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Start Date',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                    suffixIcon: Icon(Icons.calendar_today, size: 16.sp),
                  ),
                  controller: TextEditingController(text: c.formattedDate(c.selectedRange.value.start)),
                  onTap: () async {
                    final d = await showDatePicker(
                      context: context,
                      initialDate: c.selectedRange.value.start,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (d != null) c.selectStartDate(d);
                  },
                ),
                SizedBox(height: 12.h),
                // End
                TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'End Date',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                    suffixIcon: Icon(Icons.calendar_today, size: 16.sp),
                    errorText: c.dateError.value.isEmpty ? null : c.dateError.value,
                  ),
                  controller: TextEditingController(text: c.formattedDate(c.selectedRange.value.end)),
                  onTap: () async {
                    final d = await showDatePicker(
                      context: context,
                      initialDate: c.selectedRange.value.end,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (d != null) c.selectEndDate(d);
                  },
                ),
              ],
            )),
        actions: [
          TextButton(
            onPressed: () {
              if (c.validateDateRange()) {
                c.confirmCustomRange();
                Get.back();
              }
            },
            child: Text('OK', style: TextStyle(color: ColorConstants.appThemeColor)),
          ),
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
        ],
      ),
    );
  }

  // ==============================================================
  // SUMMARY TAB
  // ==============================================================
  Widget _buildSummaryTab(DashboardController c) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          // Row 1
          Row(
            children: [
              Expanded(child: _summaryCard(c, 'Total Phone Calls', c.totalCalls, c.totalTalkTime, Icons.phone_in_talk_outlined, Colors.grey[700]!, Colors.grey[200]!, AppRoutes.totalPhoneCallsScreen)),
              SizedBox(width: 12.w),
              Expanded(child: _summaryCard(c, 'Incoming Calls', c.incomingCalls, c.incomingTalkTime, Icons.phone_callback_outlined, Colors.green[700]!, Colors.green[100]!, AppRoutes.incomingCallsScreen, direction: 'incoming', status: 'connected')),
            ],
          ),
          SizedBox(height: 12.h),

          // Row 2
          Row(
            children: [
              Expanded(child: _summaryCard(c, 'Outgoing Calls', c.outgoingCalls, c.outgoingTalkTime, Icons.phone_forwarded_outlined, Colors.orange[700]!, Colors.orange[100]!, AppRoutes.incomingCallsScreen, direction: 'outgoing', status: 'connected')),
              SizedBox(width: 12.w),
              Expanded(child: _summaryCard(c, 'Missed Calls', c.missedCalls, null, Icons.phone_missed_outlined, Colors.red[700]!, Colors.red[100]!, AppRoutes.incomingCallsScreen, direction: 'incoming', status: 'missed')),
            ],
          ),
          SizedBox(height: 12.h),

          // Row 3
          Row(
            children: [
              Expanded(child: _summaryCard(c, 'Rejected Calls', c.rejectedCalls, null, Icons.phone_disabled_outlined, Colors.red[700]!, Colors.red[100]!, AppRoutes.incomingCallsScreen, direction: 'incoming', status: 'rejected')),
              SizedBox(width: 12.w),
              Expanded(child: _summaryCard(c, 'Never Attended Calls', c.neverAttendedCalls, null, Icons.phone_paused_outlined, Colors.orange[700]!, Colors.orange[100]!, AppRoutes.neverAttendedCallsScreen, direction: 'incoming', status: 'never_attended')),
            ],
          ),
          SizedBox(height: 12.h),

          // Row 4
          Row(
            children: [
              Expanded(child: _summaryCard(c, 'Not Picked by Client', c.notPickedByClient, null, Icons.phone_missed_outlined, Colors.blue[700]!, Colors.blue[100]!, AppRoutes.neverAttendedCallsScreen, direction: 'outgoing', status: 'not_picked_by_client')),
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryCard(
    DashboardController c,
    String title,
    RxInt count,
    RxDouble? durationSec,
    IconData icon,
    Color iconColor,
    Color bgColor,
    String route, {
    String? direction,
    String? status,
  }) {
    return AnalyticsCard(
      title: title,
      count: count.value.toString(),
      duration: durationSec == null ? null : c.formatSeconds(durationSec.value),
      icon: icon,
      iconColor: iconColor,
      iconBgColor: bgColor,
      onTap: () => Get.toNamed(
        route,
        arguments: c.getNavigationData(
          title: title,
          direction: direction,
          status: status,
        ),
      ),
    );
  }

  // ==============================================================
  // ANALYSIS TAB
  // ==============================================================
  Widget _buildAnalysisTab(DashboardController c) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          // Row 1
          Row(
            children: [
              Expanded(
                child: AnalysisCard(
                  title: 'Top Caller',
                  value: c.topCaller.value.isEmpty ? '-' : c.topCaller.value,
                  icon: Icons.person_outline,
                  iconColor: Colors.grey[700]!,
                  iconBgColor: Colors.grey[200]!,
                  onTap: () => Get.toNamed(
                    AppRoutes.topCallerScreen,
                    arguments: c.getNavigationData(
                      title: 'Top Caller',
                      extra: {
                        'type': 'top_caller',
                        'callLogId': c.topCallerCallLogId(),
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: AnalysisCard(
                  title: 'Longest Call',
                  value: c.longestCallDuration.value > 0 ? c.formatSeconds(c.longestCallDuration.value) : '0s',
                  valueFontSize: 18.sp,
                  valueFontWeight: FontWeight.w600,
                  icon: Icons.timer_outlined,
                  iconColor: Colors.orange[700]!,
                  iconBgColor: Colors.orange[100]!,
                  onTap: () => Get.toNamed(
                    AppRoutes.topCallerScreen,
                    arguments: c.getNavigationData(
                      title: 'Longest Call',
                      extra: {
                        'type': 'longest_call',
                        'callLogId': c.longestCallId.value,
                        'highlightDuration': c.longestCallDuration.value,
                        'highlightName': c.longestCallName.value,
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Row 2
          Row(
            children: [
              Expanded(
                child: AnalysisCard(
                  title: 'Highest Total Call Duration',
                  value: c.mostTalkTimeContact.value.isNotEmpty
                      ? '${c.mostTalkTimeContact.value}\n${c.formatSeconds(c.top10ByDuration.isNotEmpty ? c.top10ByDuration.first['duration'] : 0)}'
                      : '0s',
                  valueFontSize: 16.sp,
                  valueFontWeight: FontWeight.w600,
                  icon: Icons.timelapse_outlined,
                  iconColor: Colors.orange[700]!,
                  iconBgColor: Colors.orange[100]!,
                  onTap: () => Get.toNamed(
                    AppRoutes.topCallerScreen,
                    arguments: c.getNavigationData(
                      title: 'Highest Call Duration',
                      extra: {
                        'type': 'highest_duration',
                        'callLogId': c.highestDurationCallLogId(),
                        'highlightDuration': c.top10ByDuration.isNotEmpty ? c.top10ByDuration.first['duration'] : 0,
                        'highlightName': c.mostTalkTimeContact.value,
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: AnalysisCard(
                  title: 'Average Call Duration',
                  value: 'Per Call & Per Day',
                  icon: Icons.av_timer_outlined,
                  iconColor: Colors.orange[700]!,
                  iconBgColor: Colors.orange[100]!,
                  onTap: () => Get.toNamed(
                    AppRoutes.perCallScreen,
                    arguments: c.getNavigationData(
                      title: 'Average Call Duration',
                      extra: {'callLogIds': c.filteredCallLogItems.map((e) => e.id).toList()},
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Row 3
          Row(
            children: [
              Expanded(
                child: AnalysisCard(
                  title: 'Top 10 Frequently Talked',
                  value: 'Incoming & Outgoing',
                  icon: Icons.people_outline,
                  iconColor: Colors.grey[700]!,
                  iconBgColor: Colors.grey[200]!,
                  onTap: () => Get.toNamed(
                    AppRoutes.topTalkedScreen,
                    arguments: c.getNavigationData(
                      title: 'Top 10 Frequent',
                      extra: {
                        'type': 'frequency',
                        'callLogIds': c.top10ByCount.map((e) => e['id'] as String).toList(),
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: AnalysisCard(
                  title: 'Top 10 Call Duration',
                  value: 'Incoming & Outgoing',
                  icon: Icons.access_time_outlined,
                  iconColor: Colors.orange[700]!,
                  iconBgColor: Colors.orange[100]!,
                  onTap: () => Get.toNamed(
                    AppRoutes.topTalkedScreen,
                    arguments: c.getNavigationData(
                      title: 'Top 10 Duration',
                      extra: {
                        'type': 'duration',
                        'callLogIds': c.top10ByDuration.map((e) => e['id'] as String).toList(),
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}