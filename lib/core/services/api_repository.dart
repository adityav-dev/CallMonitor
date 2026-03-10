// lib/data/repository/api_repository.dart

import '../../../data/model/analytics/analysis/call_analytics_analysis_model.dart';
import '../../../data/model/analytics/call_filter_response_model.dart';
import '../../../data/model/analytics/summary/call_analytics_summary_model.dart';
import '../../../data/model/analytics/upload_call_logs_model.dart';
import '../../../data/model/auth_model/google_login_model.dart';

abstract class ApiRepository {
  Future<GoogleProfilesResponse> googleLogin(String googleIdToken);

  Future<UploadCallLogsResponse> uploadCallLogs(UploadCallLogsRequest request);

  Future<CallAnalyticsSummaryModel> getCallLogsSummary({
    required String range,
    String? start,
    String? end,
    String? direction,
  });

  Future<CallAnalyticsAnalysisModel> getCallLogsAnalysis({
    required String range,
    required String type,
    String? start,
    String? end,
    String? direction,
  });

  Future<CallLogDetailModel> getCallLogDetail(String callLogId);

  Future<CallLogsFilterResponse> getFilteredCallLogs({
    required String range,
    int page = 1,
    int limit = 200,
    String? direction,
    String? status,
    DateTime? start,
    DateTime? end,
  });
}