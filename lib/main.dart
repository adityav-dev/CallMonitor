import 'package:call_monitor/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/app-export.dart';
import 'core/services/dio_client.dart';
import 'core/services/network/network_controller.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await GetStorage.init();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Get.put(DioClient());
  await initServices();

  runApp(const MyApp());
}

Future<void> initServices() async {
  Get.put(NetworkController(), permanent: true); // Always alive
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, __) {
        // Removed Obx + themeController
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Call Monitor",
          initialRoute: AppRoutes.initialRoute,
          getPages: AppRoutes.pages,
          theme: _buildLightTheme(),
          darkTheme: _buildDarkTheme(),
          // Default to light theme (or change to .dark / .system)
          themeMode: ThemeMode.light,
          builder: (context, child) {
            return DismissKeyboard(child: child!);
          },
        );
      },
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      cardColor: Colors.white,
      textTheme: ThemeData.light().textTheme.apply(
        fontFamily: AppFonts.poppins,
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      cardColor: const Color(0xFF1E1E1E),
      textTheme: ThemeData.dark().textTheme.apply(fontFamily: AppFonts.poppins),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
