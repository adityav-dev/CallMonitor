import 'dart:async';
import 'package:call_log/call_log.dart' as device_call_log;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/app-export.dart';
import '../../../core/utils/snack_bar.dart';

class CallLog {
  final String contactName;
  final String phoneNumber;
  final device_call_log.CallType callType;
  final DateTime dateTime;
  final Duration duration;
  final String? simInfo;

  CallLog({
    required this.contactName,
    required this.phoneNumber,
    required this.callType,
    required this.dateTime,
    required this.duration,
    this.simInfo,
  });

  bool get isIncoming => callType == device_call_log.CallType.incoming;
  bool get isOutgoing => callType == device_call_log.CallType.outgoing;
  bool get isMissed => callType == device_call_log.CallType.missed;
  bool get isRejected => callType == device_call_log.CallType.rejected;
}

class CallLogsController extends GetxController {
  // -----------------------------------------------------------------
  // Observable state
  // -----------------------------------------------------------------
  final RxList<CallLog> callLogs = <CallLog>[].obs;
  final RxBool hasMore = true.obs;
  final RxBool isLoading = false.obs;
  final ScrollController scrollController = ScrollController();

  final RxInt selectedTab = 0.obs; // 0=All, 1=Incoming, …

  // -----------------------------------------------------------------
  // Pagination constants
  // -----------------------------------------------------------------
  static const int _initialPageSize = 5; // first load
  static const int _nextPageSize = 7; // every subsequent load
  int _offset = 0; // current skip count

  Timer? _debounceTimer;

  // -----------------------------------------------------------------
  // Lifecycle
  // -----------------------------------------------------------------
  @override
  void onInit() {
    super.onInit();
    _setupScrollListener();
    fetchCallLogs(); // <-- first page
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    scrollController.dispose();
    super.onClose();
  }

  // -----------------------------------------------------------------
  // Tab handling (unchanged)
  // -----------------------------------------------------------------
  void changeTab(int index) => selectedTab.value = index;

  List<CallLog> get filteredLogs {
    switch (selectedTab.value) {
      case 1:
        return callLogs
            .where((l) => l.callType == device_call_log.CallType.incoming)
            .toList();
      case 2:
        return callLogs
            .where((l) => l.callType == device_call_log.CallType.outgoing)
            .toList();
      case 3:
        return callLogs
            .where((l) => l.callType == device_call_log.CallType.missed)
            .toList();
      case 4:
        return callLogs
            .where((l) => l.callType == device_call_log.CallType.rejected)
            .toList();
      case 5:
        return callLogs
            .where((l) => l.callType == device_call_log.CallType.unknown)
            .toList();
      default:
        return callLogs;
    }
  }

  // -----------------------------------------------------------------
  // Infinite scroll listener
  // -----------------------------------------------------------------
  void _setupScrollListener() {
    scrollController.addListener(() {
      if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();

      _debounceTimer = Timer(const Duration(milliseconds: 200), () {
        final max = scrollController.position.maxScrollExtent;
        final cur = scrollController.position.pixels;

        if (cur >= max - 200 && hasMore.value && !isLoading.value) {
          fetchCallLogs(); // <-- load next page
        }
      });
    });
  }

  // -----------------------------------------------------------------
  // Core pagination method
  // -----------------------------------------------------------------
  Future<void> fetchCallLogs() async {
    if (isLoading.value) return;
    isLoading.value = true;

    // ---- Permission -------------------------------------------------
    final status = await Permission.phone.request();
    if (!status.isGranted) {
      isLoading.value = false;
      _showPermissionDialog();
      return;
    }

    try {
      // 1. Get **all** entries from the device (call_log plugin does not support offset)
      final Iterable<device_call_log.CallLogEntry> allEntries =
          await device_call_log.CallLog.get();

      // 2. Determine page size (5 for first page, 7 for the rest)
      final int pageSize = _offset == 0 ? _initialPageSize : _nextPageSize;

      // 3. Slice the required chunk
      final List<CallLog> newChunk = allEntries
          .skip(_offset)
          .take(pageSize)
          .map(
            (e) => CallLog(
              contactName: e.name ?? 'Unknown',
              phoneNumber: e.number ?? 'Unknown',
              callType: e.callType ?? device_call_log.CallType.unknown,
              dateTime: DateTime.fromMillisecondsSinceEpoch(e.timestamp ?? 0),
              duration: Duration(seconds: e.duration ?? 0),
            ),
          )
          .toList();

      // 4. Update state
      if (newChunk.length < pageSize) hasMore.value = false; // no more data

      if (_offset == 0) {
        callLogs.assignAll(newChunk); // replace for first page
      } else {
        callLogs.addAll(newChunk); // append for subsequent pages
      }

      _offset += newChunk.length;
    } catch (e) {
      customSnackBar(message: "Failed to load call logs", type: "E");
    } finally {
      isLoading.value = false;
    }
  }

  // -----------------------------------------------------------------
  // Pull-to-refresh (reset pagination)
  // -----------------------------------------------------------------
  Future<void> refreshCallLogs() async {
    _offset = 0;
    hasMore.value = true;
    callLogs.clear();
    await fetchCallLogs();
  }

  // -----------------------------------------------------------------
  // Permission dialog (unchanged)
  // -----------------------------------------------------------------
  void _showPermissionDialog() {
    Get.defaultDialog(
      title: 'Permission Required',
      middleText: 'Please grant phone permission to view call logs.',
      confirm: TextButton(
        onPressed: () {
          openAppSettings();
          Get.back();
        },
        child: const Text(
          'Open Settings',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      cancel: TextButton(onPressed: Get.back, child: const Text('Cancel')),
    );
  }

  // -----------------------------------------------------------------
  // UI actions (make call, copy, sms, whatsapp) – unchanged
  // -----------------------------------------------------------------
  Future<void> makeCall(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      customSnackBar(message: "Could not launch dialer", type: "E");
    }
  }

  Future<void> copyNumber(String phoneNumber) async {
    await Clipboard.setData(ClipboardData(text: phoneNumber));
    customSnackBar(message: "Phone number copied", type: "S");
  }

  Future<void> sendSMS(String phoneNumber) async {
    final uri = Uri(scheme: 'sms', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      customSnackBar(message: "Could not open SMS", type: "E");
    }
  }

  Future<void> openWhatsApp(String phoneNumber) async {
    String cleaned = phoneNumber.replaceAll(RegExp(r'\D'), '');
    if (!cleaned.startsWith('91') && cleaned.length == 10) {
      cleaned = '91$cleaned';
    }
    final uri = Uri.parse("https://wa.me/$cleaned?text=Hello");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      customSnackBar(message: "WhatsApp not installed", type: "E");
    }
  }
}
