import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/app-export.dart';
import '../../../../core/services/api_services.dart';
import '../../../../core/services/dio_client.dart';
import '../../../../routes/app_routes.dart';
import '../../../../data/model/more/get_all_human_agents.dart';
import '../../../../data/model/more/get_team_clients.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MoreController extends GetxController {
  // User profile details
  final RxString userName = ''.obs;
  final RxString userEmail = ''.obs;
  final RxString userNumber = ''.obs;
  final RxString userRole = ''.obs;
  final RxString userProfileImage = ''.obs;
  final RxString businessName = ''.obs;

  // NEW: Client logo (only for client role)
  final RxString clientLogo = ''.obs;

  final secureStorage = FlutterSecureStorage();
  // final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ApiService apiService = ApiService(dio: DioClient().dio);
  final storage = GetStorage();

  // Loading flags
  final RxBool isProfileLoading = false.obs;
  final RxBool isCreditsLoading = false.obs;

  // UI helpers
  final RxString currentSection = ''.obs;
  final RxInt totalCredits = 0.obs;
  final RxInt tasksCompleted = 0.obs;

  // Role-based data
  final RxList<HumanAgent> humanAgents = <HumanAgent>[].obs;
  final RxList<Association> associatedClients = <Association>[].obs;
  final RxBool isHumanAgentsLoading = false.obs;
  final RxBool isAssociatedClientsLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    userName.value = '';
    userEmail.value = '';
    userNumber.value = '';
    userRole.value = '';
    userProfileImage.value = '';
    businessName.value = '';
    clientLogo.value = ''; // init

    loadUserData();
  }

  void loadUserData() {
    isProfileLoading.value = true;
    isCreditsLoading.value = true;
    isHumanAgentsLoading.value = true;
    isAssociatedClientsLoading.value = true;

    Future.wait([]).then((_) {
      humanAgents.refresh();
      associatedClients.refresh();
      print('MoreController - All data loaded');
    });
  }

  Future<void> _loadCreditsData() async {
    try {
      isCreditsLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));
      String? userId = storage.read(Constants.googleId);
      if (userId == null || userId.isEmpty) {
        storage.write(Constants.googleId, 'dummy_user_id');
      }
      totalCredits.value = 1000;
      tasksCompleted.value = 50;
    } catch (e) {
      print('MoreController - Error in _loadCreditsData: $e');
    } finally {
      isCreditsLoading.value = false;
    }
  }

  void refreshSettings() {
    loadUserData();
  }

  void onProfileInfoTap() {
    currentSection.value = 'Profile Info';
    // Get.toNamed(AppRoutes.profileScreen);
  }

  void onHelpSupportTap() {
    currentSection.value = 'Help & Support';
    // Get.toNamed(AppRoutes.helpSupportScreen);
  }

  void onHumanAgentsTap() {
    // Get.toNamed(AppRoutes.humanAgentsScreen);
  }

  void onAssociatedClientsTap() {
    // Get.toNamed(AppRoutes.associatedClientsScreen);
  }

  void onLogoutTap() {
    showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: ColorConstants.white,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.logout,
                size: 25.w,
                color: ColorConstants.appThemeColor,
              ),
              const SizedBox(height: 12),
              Text(
                "Are you sure you want to logout?",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.poppins,
                  color: ColorConstants.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "You will need to log in again to continue using the app.",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: AppFonts.poppins,
                  color: ColorConstants.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(color: ColorConstants.lightGrey),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontSize: 14.sp,
                          color: ColorConstants.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.appThemeColor,
                        foregroundColor: ColorConstants.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        await logoutUser();
                      },
                      child: Text(
                        "Logout",
                        style: TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
            ],
          ),
        );
      },
    );
  }

  Future<void> logoutUser() async {
    try {
      // await _googleSignIn.signOut();
      await _auth.signOut();
      await storage.erase();
      await secureStorage.deleteAll();

      // Reset all
      userName.value = '';
      userEmail.value = '';
      userNumber.value = '';
      userRole.value = '';
      userProfileImage.value = '';
      businessName.value = '';
      clientLogo.value = '';
      totalCredits.value = 0;
      tasksCompleted.value = 0;
      currentSection.value = '';
      humanAgents.clear();
      associatedClients.clear();

      final storage1 = const FlutterSecureStorage();
      await storage1.write(key: 'isLoggedIn', value: 'false');

      Get.offAllNamed(AppRoutes.loginScreen);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
