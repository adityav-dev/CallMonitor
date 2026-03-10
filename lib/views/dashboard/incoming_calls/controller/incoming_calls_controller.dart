import 'package:get/get.dart';
import '../../../../data/model/analytics_model/call_history_model.dart';

class IncomingCallsController extends GetxController {
  final RxList<CallHistoryItem> allCalls = <CallHistoryItem>[].obs;
  final RxList<CallHistoryItem> filteredCalls = <CallHistoryItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadAllCalls();
  }

  void _loadAllCalls() {
    allCalls.assignAll([
      CallHistoryItem(
        name: 'John Doe',
        phoneNumber: '+91 9876543210',
        duration: '41m 35s',
        date: 'Nov 1, 2025',
        time: '10:15 AM',
        callType: CallType.incoming,
      ),
      CallHistoryItem(
        name: 'Amit Sharma',
        phoneNumber: '+91 8765432109',
        duration: '5m 12s',
        date: 'Nov 1, 2025',
        time: '9:00 AM',
        callType: CallType.outgoing,
      ),
      CallHistoryItem(
        name: 'Rohit Singh',
        phoneNumber: '+91 7654321098',
        duration: '0s',
        date: 'Oct 31, 2025',
        time: '8:45 PM',
        callType: CallType.missed,
      ),
      CallHistoryItem(
        name: 'Neha Patel',
        phoneNumber: '+91 6543210987',
        duration: '0s',
        date: 'Oct 31, 2025',
        time: '8:15 PM',
        callType: CallType.rejected,
      ),
    ]);
  }

  void loadCalls(String type) {
    switch (type) {
      case 'incoming':
        filteredCalls.assignAll(
          allCalls.where((e) => e.callType == CallType.incoming),
        );
        break;
      case 'outgoing':
        filteredCalls.assignAll(
          allCalls.where((e) => e.callType == CallType.outgoing),
        );
        break;
      case 'missed':
        filteredCalls.assignAll(
          allCalls.where((e) => e.callType == CallType.missed),
        );
        break;
      case 'rejected':
        filteredCalls.assignAll(
          allCalls.where((e) => e.callType == CallType.rejected),
        );
        break;
      default:
        filteredCalls.assignAll(allCalls);
    }
  }
}
