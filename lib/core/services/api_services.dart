// lib/data/repository/api_service.dart

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../../data/model/analytics/analysis/call_analytics_analysis_model.dart';
import '../../../data/model/analytics/call_filter_response_model.dart';
import '../../../data/model/analytics/summary/call_analytics_summary_model.dart';
import '../../../data/model/analytics/upload_call_logs_model.dart';
import '../../../data/model/auth_model/google_login_model.dart';
import '../app-export.dart';
import 'api_constants.dart';
import 'api_repository.dart';

class ApiService implements ApiRepository {
  final Dio dio;

  ApiService({required this.dio});

  // Helper to build query params safely
  Map<String, dynamic> _buildQueryParams(
    Map<String, dynamic> base,
    Map<String, dynamic?> optional,
  ) {
    final params = Map<String, dynamic>.from(base);

    optional.forEach((key, value) {
      if (value == null) return;

      if (value is String && value.isEmpty) return;

      if (value is DateTime) {
        params[key] = DateFormat('yyyy-MM-dd').format(value);
      } else {
        params[key] = value;
      }
    });

    return params;
  }

  @override
  Future<GoogleProfilesResponse> googleLogin(String googleIdToken) async {
     try {
      final String url =
          'https://aitotabackend-sih2.onrender.com/api/v1/client/google/profiles';
      print('Calling URL: $url');
      print('Request data: {"token": "$googleIdToken"}');

      final response = await dio.post(url, data: {"token": googleIdToken});
      print("GoogleProfilesResponse: ${response.data}");

      if (response.statusCode == 200) {
        return GoogleProfilesResponse.fromJson(response.data);
      }
      throw Exception('Backend error: ${response.statusCode}');
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      print('DioException response: ${e.response?.data}');
      throw Exception('API Error: ${e.message}');
    } catch (e) {
      print('General Exception: $e');
      throw Exception(e.toString());
    }
  }

  @override
  Future<UploadCallLogsResponse> uploadCallLogs(UploadCallLogsRequest request) async {
    try {
      final url = '${ApiEndpoints.baseUrl}${ApiEndpoints.uploadCallLogs}';
      print('Calling URL: $url');
      print('Request data: ${request.toJson()}');

      final response = await dio.post(
        ApiEndpoints.uploadCallLogs,
        data: request.toJson(),
      );

      print("UploadCallLogsResponse: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return UploadCallLogsResponse.fromJson(response.data);
      } else {
        throw Exception('Backend error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      print('Error response: ${e.response?.data}');
      throw Exception('API Error: ${e.message}');
    } catch (e) {
      print('General Exception: $e');
      throw Exception(e.toString());
    }
  }

  @override
  Future<CallAnalyticsSummaryModel> getCallLogsSummary({
    required String range,
    String? start,
    String? end,
    String? direction,
  }) async {
    final query = _buildQueryParams(
      {'range': range},
      {'start': start, 'end': end, 'direction': direction},
    );

    try {
      final url = '${ApiEndpoints.baseUrl}${ApiEndpoints.getCallLogsSummary}';
      print('Calling URL: $url');
      print('Query params: $query');

      final response = await dio.get(
        ApiEndpoints.getCallLogsSummary,
        queryParameters: query,
      );

      print("CallLogsSummary Response: ${response.data}");

      if (response.statusCode == 200) {
        return CallAnalyticsSummaryModel.fromJson(response.data);
      } else {
        throw Exception('Backend error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      throw Exception('API Error: ${e.message}');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<CallAnalyticsAnalysisModel> getCallLogsAnalysis({
    required String range,
    required String type,
    String? start,
    String? end,
    String? direction,
  }) async {
    final query = _buildQueryParams(
      {'range': range, 'type': type},
      {'start': start, 'end': end, 'direction': direction},
    );

    try {
      final url = '${ApiEndpoints.baseUrl}${ApiEndpoints.getCallLogsAnalysis}';
      print('Calling URL: $url');
      print('Query params: $query');

      final response = await dio.get(
        ApiEndpoints.getCallLogsAnalysis,
        queryParameters: query,
      );

      print("CallLogsAnalysis Response: ${response.data}");

      if (response.statusCode == 200) {
        return CallAnalyticsAnalysisModel.fromJson(response.data);
      } else {
        throw Exception('Backend error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      throw Exception('API Error: ${e.message}');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<CallLogDetailModel> getCallLogDetail(String callLogId) async {
    final endpoint = '${ApiEndpoints.getCallLogDetail}$callLogId';
    try {
      final url = '${ApiEndpoints.baseUrl}$endpoint';
      print('Calling URL: $url');

      final response = await dio.get(endpoint);

      print("CallLogDetail Response: ${response.data}");

      if (response.statusCode == 200) {
        return CallLogDetailModel.fromJson(response.data);
      } else {
        throw Exception('Backend error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      throw Exception('API Error: ${e.message}');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<CallLogsFilterResponse> getFilteredCallLogs({
    required String range,
    int page = 1,
    int limit = 200,
    String? direction,
    String? status,
    DateTime? start,
    DateTime? end,
  }) async {
    final query = _buildQueryParams(
      {
        'range': range,
        'page': page,
        'limit': limit,
      },
      {
        'direction': direction,
        'status': status,
        'start': start,
        'end': end,
      },
    );

    try {
      final url = '${ApiEndpoints.baseUrl}${ApiEndpoints.callLogsFilters}';
      print('Calling URL: $url');
      print('Query params: $query');

      final response = await dio.get(
        ApiEndpoints.callLogsFilters,
        queryParameters: query,
      );

      print("FilteredCallLogs Response: ${response.data}");

      if (response.statusCode == 200) {
        return CallLogsFilterResponse.fromJson(response.data);
      } else {
        throw Exception('Backend error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      print('Error response: ${e.response?.data}');
      throw Exception('API Error: ${e.message}');
    } catch (e) {
      print('General Exception: $e');
      throw Exception(e.toString());
    }
  }
}