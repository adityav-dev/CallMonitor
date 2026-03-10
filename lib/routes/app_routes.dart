import 'package:call_monitor/views/call_logs/binding/call_logs_binding.dart';
import 'package:call_monitor/views/call_logs/call_logs_screen.dart';
import 'package:call_monitor/views/contacts/binding/contacts_binding.dart';
import 'package:call_monitor/views/contacts/contacts_screen.dart';
import 'package:call_monitor/views/dashboard/analysis/per_call/binding/per_call_binding.dart';
import 'package:call_monitor/views/dashboard/analysis/per_call/per_call_screen.dart';
import 'package:call_monitor/views/dashboard/analysis/top_caller/binding/top_caller_binding.dart';
import 'package:call_monitor/views/dashboard/analysis/top_caller/top_caller_screen.dart';
import 'package:call_monitor/views/dashboard/analysis/top_talked/binding/top_talked_binding.dart';
import 'package:call_monitor/views/dashboard/analysis/top_talked/top_talked_screen.dart';
import 'package:call_monitor/views/dashboard/incoming_calls/binding/incoming_calls_binding.dart';
import 'package:call_monitor/views/dashboard/incoming_calls/incoming_calls_screen.dart';
import 'package:call_monitor/views/dashboard/never_attended_calls/binding/never_attended_calls_binding.dart';
import 'package:call_monitor/views/dashboard/never_attended_calls/never_attended_calls_screen.dart';
import 'package:call_monitor/views/dashboard/total_phone_calls/binding/total_phone_calls_binding.dart';
import 'package:call_monitor/views/dashboard/total_phone_calls/total_phone_calls_screen.dart';
import 'package:call_monitor/views/more_flow/more_screen/biniding/more_biniding.dart';
import 'package:call_monitor/views/more_flow/more_screen/more_screen.dart';
import '../core/app-export.dart';
import '../core/services/network/network_binding.dart';
import '../core/services/network/network_screen.dart';
import '../views/auth_flow/login/binding/login_binding.dart';
import '../views/auth_flow/login/login_screen.dart';
import '../views/auth_flow/splash/binding/splash_binding.dart';
import '../views/auth_flow/splash/splash_screen.dart';
import '../views/bottom_bar/binding/bottom_bar_binding.dart';
import '../views/bottom_bar/bottom_bar_screen.dart';
import '../views/dashboard/binding/dashboard_binding.dart';

class AppRoutes {
  static const String initialRoute = '/splash_screen';
  static const String loginScreen = '/login_screen';
  static const String bottomBarScreen = '/bottom_bar_screen';
  static const String dashboardScreen = '/dashboard_screen';
  static const String callLogsScreen = '/call_logs_screen';
  static const String contactsScreen = '/contacts_screen';
  static const String moreScreen = '/more_screen';
  static const String networkScreen = '/network_screen';
  static const String totalPhoneCallsScreen = '/total_phone_calls_screen';
  static const String incomingCallsScreen = '/incoming_calls_screen';
  static const String neverAttendedCallsScreen = '/never_attended_calls_screen';
  static const String topCallerScreen = '/top_caller_screen';
  static const String perCallScreen = '/per_call_screen';
  static const String topTalkedScreen = '/top_talked_screen';
  static List<GetPage> pages = [
    GetPage(
      name: initialRoute,
      page: () => const SplashScreen(),
      bindings: [SplashBinding()],
    ),
    GetPage(
      name: loginScreen,
      page: () => const LoginScreen(), // login Screen
      bindings: [LoginBinding()],
    ),

    GetPage(
      name: AppRoutes.bottomBarScreen,
      page: () => const BottomBarScreen(),
      bindings: [
        BottomBarBinding(),
        DashboardBinding(), // Add this
      ],
    ),
    GetPage(
      name: callLogsScreen,
      page: () => const CallLogsScreen(), // login Screen
      bindings: [CallLogsBinding()],
    ),
    GetPage(
      name: contactsScreen,
      page: () => const ContactsScreen(), // login Screen
      bindings: [ContactsBinding()],
    ),
    GetPage(
      name: moreScreen,
      page: () => const MoreScreen(), // login Screen
      bindings: [MoreBinding()],
    ),
    GetPage(
      name: networkScreen,
      page: () => const NetworkScreen(), // login Screen
      bindings: [NetworkBinding()],
    ),
    GetPage(
      name: totalPhoneCallsScreen,
      page: () => const TotalPhoneCallsScreen(), // login Screen
      bindings: [TotalPhoneCallsBinding()],
    ),
    GetPage(
      name: incomingCallsScreen,
      page: () => const IncomingCallsScreen(), // login Screen
      bindings: [IncomingCallsBinding()],
    ),
    GetPage(
      name: neverAttendedCallsScreen,
      page: () => const NeverAttendedCallsScreen(), // login Screen
      bindings: [NeverAttendedCallsBinding()],
    ),
    GetPage(
      name: topCallerScreen,
      page: () => const TopCallerScreen(), // login Screen
      bindings: [TopCallerBinding()],
    ),
    GetPage(
      name: perCallScreen,
      page: () => const PerCallScreen(), // login Screen
      bindings: [PerCallBinding()],
    ),
    GetPage(
      name: topTalkedScreen,
      page: () => const TopTalkedScreen(), // login Screen
      bindings: [TopTalkedBinding()],
    ),
  ];
}
