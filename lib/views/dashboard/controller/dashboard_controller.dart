// lib/modules/dashboard/controller/dashboard_controller.dart
import 'package:intl/intl.dart';
import '../../../core/app-export.dart';
import '../../../core/services/api_services.dart';
import '../../../core/services/dio_client.dart';
import '../../../data/model/analytics/analysis/call_analytics_analysis_model.dart';
import '../../../data/model/analytics/call_filter_response_model.dart';

/// Helper class – passed to next screens
class AnalyticsNavigationData {
  final String title;
  final DateTimeRange dateRange;
  final String filterType;
  final DateTime? customFrom;
  final DateTime? customTo;
  final Map<String, dynamic> extra;
  final List<CallLogSimple> filteredLogs;

  AnalyticsNavigationData({
    required this.title,
    required this.dateRange,
    required this.filterType,
    this.customFrom,
    this.customTo,
    this.extra = const {},
    this.filteredLogs = const [],
  });

  AnalyticsNavigationData copyWith({
    String? title,
    DateTimeRange? dateRange,
    String? filterType,
    DateTime? customFrom,
    DateTime? customTo,
    Map<String, dynamic>? extra,
    List<CallLogSimple>? filteredLogs,
  }) {
    return AnalyticsNavigationData(
      title: title ?? this.title,
      dateRange: dateRange ?? this.dateRange,
      filterType: filterType ?? this.filterType,
      customFrom: customFrom ?? this.customFrom,
      customTo: customTo ?? this.customTo,
      extra: extra ?? this.extra,
      filteredLogs: filteredLogs ?? this.filteredLogs,
    );
  }
}

class DashboardController extends GetxController {
  final ApiService apiService = ApiService(dio: DioClient().dio);

  // ==================== SUMMARY ====================
  final totalCalls = 0.obs;
  final incomingCalls = 0.obs;
  final outgoingCalls = 0.obs;
  final missedCalls = 0.obs;
  final rejectedCalls = 0.obs;
  final neverAttendedCalls = 0.obs;
  final notPickedByClient = 0.obs;

  final totalTalkTime = 0.0.obs;
  final incomingTalkTime = 0.0.obs;
  final outgoingTalkTime = 0.0.obs;

  // ==================== ANALYSIS ====================
  final topCaller = ''.obs;
  final longestCallDuration = 0.obs;
  final longestCallName = ''.obs;
  final longestCallId = ''.obs;
  final mostTalkTimeContact = ''.obs;
  final highestDurationCallId = ''.obs;

  final top10ByCount = <Map<String, dynamic>>[].obs;
  final top10ByDuration = <Map<String, dynamic>>[].obs;

  // ==================== UI STATE ====================
  final isLoading = false.obs;

  // FILTERS
  final isYesterdaySelected = false.obs;
  final isTodaySelected = true.obs;
  final isLast7DaysSelected = false.obs;
  final isCustomRangeSelected = false.obs;

  final selectedRange = Rx<DateTimeRange>(
    DateTimeRange(start: DateTime.now(), end: DateTime.now()),
  );
  final dateError = ''.obs;

  // Real call-log items (Mongo _id + direction + status)
  final filteredCallLogItems = <CallLogSimple>[].obs;

  @override
  void onInit() {
    super.onInit();
    refreshAnalytics();
  }

  // ==============================================================
  // 1. SUMMARY
  // ==============================================================
  Future<void> _loadSummaryData() async {
    try {
      isLoading.value = true;

      final (range, start, end) = _rangeParamsForApi();
      final summary = await apiService.getCallLogsSummary(
        range: range,
        start: start,
        end: end,
      );

      if (summary.success) {
        final d = summary.data;
        totalCalls.value = d.total.count;
        incomingCalls.value = d.incoming.count;
        outgoingCalls.value = d.outgoing.count;
        missedCalls.value = d.missed.count;
        rejectedCalls.value = d.rejected.count;
        neverAttendedCalls.value = d.neverAttended.count;
        notPickedByClient.value = d.notPickedByClient.count;

        totalTalkTime.value = (d.total.durationSeconds ?? 0).toDouble();
        incomingTalkTime.value = (d.incoming.durationSeconds ?? 0).toDouble();
        outgoingTalkTime.value = (d.outgoing.durationSeconds ?? 0).toDouble();
      }
    } catch (e) {
      debugPrint('Summary error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // ==============================================================
  // 2. ANALYSIS
  // ==============================================================
  Future<void> _loadAnalysisData() async {
    try {
      isLoading.value = true;

      final (range, start, end) = _rangeParamsForApi();
      final types = [
        'top_caller',
        'longest_call',
        'highest_total_duration',
        'average_duration',
        'top10_frequent',
        'top10_duration',
      ];

      final responses = await Future.wait(
        types.map((t) => apiService.getCallLogsAnalysis(
              range: range,
              type: t,
              start: start,
              end: end,
            )),
      );

      for (var i = 0; i < types.length; i++) {
        final type = types[i];
        final resp = responses[i];
        if (resp.success) _processAnalysis(type, resp.data);
      }
    } catch (e) {
      debugPrint('Analysis error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _processAnalysis(String type, dynamic data) {
    switch (type) {
      case 'top_caller':
        final items = (data as List).cast<Map<String, dynamic>>();
        topCaller.value = items.isNotEmpty ? items.first['_id'] ?? '-' : '-';
        break;

      case 'longest_call':
        final items = (data as List).cast<Map<String, dynamic>>();
        if (items.isNotEmpty) {
          final item = LongestCallItem.fromJson(items.first);
          longestCallDuration.value = item.durationSeconds;
          longestCallName.value = item.phoneNumber ?? item.id;
          longestCallId.value = item.id;
        }
        break;

      case 'highest_total_duration':
        final items = (data as List).cast<Map<String, dynamic>>();
        if (items.isNotEmpty) {
          final item = HighestTotalDurationItem.fromJson(items.first);
          mostTalkTimeContact.value = item.phoneNumber;
          highestDurationCallId.value = item.id;
        }
        break;

      case 'top10_frequent':
        final freq = Top10FrequentModel.fromJson(data);
        top10ByCount.assignAll(
          freq.all.map((e) => {'id': e.id, 'name': e.id, 'count': e.count}).toList(),
        );
        break;

      case 'top10_duration':
        final dur = Top10FrequentModel.fromJson(data);
        top10ByDuration.assignAll(
          dur.all
              .map((e) => {'id': e.id, 'name': e.id, 'duration': e.totalDuration ?? 0})
              .toList(),
        );
        break;
    }
  }

  // ==============================================================
  // 3. FILTERED CALL LOGS (real _id)
  // ==============================================================
  Future<void> _loadFilteredCallLogs() async {
    try {
      isLoading.value = true;

      final (range, start, end) = _rangeParamsForFilteredLogs();
      final resp = await apiService.getFilteredCallLogs(
        range: range,
        limit: 500,
        start: start,
        end: end,
      );

      if (resp.success) {
        filteredCallLogItems.assignAll(resp.data.items);
      }
    } catch (e) {
      debugPrint('Filtered logs error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // ==============================================================
  // 4. REFRESH ALL
  // ==============================================================
  Future<void> refreshAnalytics({bool force = false}) async {
    if (isLoading.value && !force) return;
    await Future.wait([
      _loadSummaryData(),
      _loadAnalysisData(),
      _loadFilteredCallLogs(),
    ]);
  }

  // ==============================================================
  // 5. FILTER SELECTION
  // ==============================================================
  void selectFilter(String label) {
    isYesterdaySelected.value = label == 'Yesterday';
    isTodaySelected.value = label == 'Today';
    isLast7DaysSelected.value = label == 'Last 7 Days';
    isCustomRangeSelected.value = false;
    refreshAnalytics();
  }

  void confirmCustomRange() {
    if (!validateDateRange()) return;
    isCustomRangeSelected.value = true;
    isTodaySelected.value = isYesterdaySelected.value = isLast7DaysSelected.value = false;
    refreshAnalytics();
  }

  // ==============================================================
  // 6. DATE HELPERS
  // ==============================================================
  void selectStartDate(DateTime d) => selectedRange.value = DateTimeRange(start: d, end: selectedRange.value.end);
  void selectEndDate(DateTime d) => selectedRange.value = DateTimeRange(start: selectedRange.value.start, end: d);

  bool validateDateRange() {
    if (selectedRange.value.end.isBefore(selectedRange.value.start)) {
      dateError.value = 'End date must be after start date';
      return false;
    }
    dateError.value = '';
    return true;
  }

  String formattedDate(DateTime d) => DateFormat('yyyy-MM-dd').format(d);

  void initializeCalendarRange() {
    selectedRange.value = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 6)),
      end: DateTime.now(),
    );
    dateError.value = '';
  }

  // ==============================================================
  // 7. CURRENT FILTER KEY & RANGE
  // ==============================================================
  String get currentFilterKey {
    if (isCustomRangeSelected.value) return 'custom';
    if (isTodaySelected.value) return 'today';
    if (isYesterdaySelected.value) return 'yesterday';
    if (isLast7DaysSelected.value) return 'last7';
    return 'today';
  }

  DateTimeRange get currentDateRange {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return switch (currentFilterKey) {
      'today' => DateTimeRange(start: today, end: now),
      'yesterday' => DateTimeRange(
          start: today.subtract(const Duration(days: 1)),
          end: today.subtract(const Duration(seconds: 1)),
        ),
      'last7' => DateTimeRange(start: today.subtract(const Duration(days: 6)), end: now),
      'custom' => selectedRange.value,
      _ => DateTimeRange(start: today, end: now),
    };
  }

  // ==============================================================
  // 8. NAVIGATION DATA
  // ==============================================================
  AnalyticsNavigationData getNavigationData({
    required String title,
    Map<String, dynamic> extra = const {},
    String? direction,
    String? status,
  }) {
    final ids = filteredCallLogItems
        .where((e) =>
            (direction == null || e.direction.toLowerCase() == direction) &&
            (status == null || e.status.toLowerCase() == status))
        .map((e) => e.id)
        .toList();

    final updatedExtra = Map<String, dynamic>.from(extra)
      ..addAll({
        'callLogIds': ids,
        if (direction != null) 'direction': direction,
        if (status != null) 'status': status,
      });

    return AnalyticsNavigationData(
      title: title,
      dateRange: currentDateRange,
      filterType: currentFilterKey,
      extra: updatedExtra,
    );
  }

  // ==============================================================
  // 9. Helper – returns (range, startString?, endString?) for Summary & Analysis
  // ==============================================================
  (String, String?, String?) _rangeParamsForApi() {
    if (currentFilterKey == 'custom') {
      return (
        'custom',
        formattedDate(selectedRange.value.start),
        formattedDate(selectedRange.value.end),
      );
    }
    return (currentFilterKey, null, null);
  }

  // ==============================================================
  // 9B. Helper – returns (range, startDateTime?, endDateTime?) for Filtered Logs
  // ==============================================================
  (String, DateTime?, DateTime?) _rangeParamsForFilteredLogs() {
    if (currentFilterKey == 'custom') {
      return (
        'custom',
        selectedRange.value.start,
        selectedRange.value.end,
      );
    }
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return switch (currentFilterKey) {
      'today' => ('today', today, now),
      'yesterday' => (
          'yesterday',
          today.subtract(const Duration(days: 1)),
          today.subtract(const Duration(seconds: 1)),
        ),
      'last7' => ('last7', today.subtract(const Duration(days: 6)), now),
      _ => ('today', today, now),
    };
  }

  // ==============================================================
  // 10. Helper – top-caller / highest-duration call-log id
  // ==============================================================
  String topCallerCallLogId() {
    final phone = topCaller.value;
    return filteredCallLogItems
            .where((e) => e.phoneNumber == phone)
            .firstOrNull
            ?.id ??
        '';
  }

  String highestDurationCallLogId() {
    final phone = mostTalkTimeContact.value;
    return filteredCallLogItems
            .where((e) => e.phoneNumber == phone)
            .firstOrNull
            ?.id ??
        '';
  }

  // ==============================================================
  // 11. Format seconds → 1h 23m 45s
  // ==============================================================
  String formatSeconds(num sec) {
    if (sec <= 0) return '0s';
    final s = sec.toInt();
    final h = s ~/ 3600;
    final m = (s % 3600) ~/ 60;
    final ss = s % 60;
    final parts = <String>[];
    if (h > 0) parts.add('${h}h');
    if (m > 0) parts.add('${m}m');
    if (ss > 0 || parts.isEmpty) parts.add('${ss}s');
    return parts.join(' ');
  }
}