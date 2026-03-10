import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/app-export.dart';
import '../../../../core/services/api_services.dart';
import '../../../../core/services/dio_client.dart';
import '../../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ApiService apiService = ApiService(dio: DioClient().dio);
  final GetStorage storage = GetStorage();

  final RxBool isLoading = false.obs;

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;

      // await _googleSignIn.signOut();

      // final googleUser = await _googleSignIn.signIn();
      // if (googleUser == null) {
      //   _showSnackBar("Cancelled", "You cancelled the sign-in.");
      //   return;
      // }

      // final googleAuth = await googleUser.authentication;
      // if (googleAuth.idToken == null) {
      //   throw Exception("Google token missing");
      // }

      // // Optional Firebase
      // final credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken);
      // await _auth.signInWithCredential(credential);

      // // Call backend
      // final loginModel = await apiService.googleLogin(googleAuth.idToken!);
      // print("LogiRese:${loginModel.toJson().toString()}");

      // if (loginModel.success == true && loginModel.token != null) {
      //   await secureStorage.write(key: Constants.token, value: loginModel.token!);
      //   await storage.write('userId', loginModel.id);
      //   await storage.write('profileId', loginModel.profileId);
      //   await storage.write('userType', loginModel.userType);
      //   await storage.write('isProfileCompleted', loginModel.isprofileCompleted);
      //   await storage.write('isApproved', loginModel.isApproved);
      //   await storage.write('email', loginModel.email);
      //   await storage.write('name', loginModel.name);

        Get.offAllNamed(AppRoutes.bottomBarScreen);
      // } else {
      //   // throw Exception(loginModel.message ?? "Login failed");
      // }
    } on DioException catch (e) {
       throw Exception(e.toString());
    } catch (e) {
        throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void _showSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF333333).withOpacity(0.9),
      colorText: Colors.white,
      margin: EdgeInsets.all(16.w),
      borderRadius: 12.r,
      duration: const Duration(seconds: 4),
    );
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    await secureStorage.deleteAll();
    await storage.erase();
    Get.offAllNamed(AppRoutes.loginScreen);
  }
}