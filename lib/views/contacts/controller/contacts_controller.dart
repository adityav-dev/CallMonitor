import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/app-export.dart';
import '../../bottom_bar/controller/bottom_bar_controller.dart';

class ContactsController extends GetxController {
  final RxList<Map<String, dynamic>> _allContacts =
      <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> displayedContacts =
      <Map<String, dynamic>>[].obs;

  final RxBool isLoading = true.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool hasMoreContacts = false.obs;
  final RxBool isSearchActive = false.obs;
  final RxBool hasInitialized = false.obs; // Track if we've initialized

  final TextEditingController searchController = TextEditingController();

  static const int _pageSize = 20;
  int _currentPage = 0;

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(_onSearchChanged);
    // Don't request permissions here - wait until tab is viewed
  }

  @override
  void onReady() {
    super.onReady();
    // Don't request permissions here - wait until tab is viewed
    _watchTabChanges();
  }

  @override
  void onClose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.onClose();
  }

  // Watch for tab changes and initialize when contacts tab is selected
  void _watchTabChanges() {
    try {
      final bottomBarController = Get.find<BottomBarController>();
      ever(bottomBarController.currentIndex, (index) {
        if (index == 2 && !hasInitialized.value) { // 2 is contacts tab index
          _initializeContacts();
        }
      });
      
      // Also check immediately if contacts tab is already selected
      if (bottomBarController.currentIndex.value == 2 && !hasInitialized.value) {
        _initializeContacts();
      }
    } catch (e) {
      // BottomBarController might not be available yet, try again later
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!hasInitialized.value) {
          _watchTabChanges();
        }
      });
    }
  }

  // Initialize contacts only when tab is viewed
  Future<void> _initializeContacts() async {
    if (hasInitialized.value) return; // Already initialized
    
    hasInitialized.value = true;
    await _requestPermissionAndLoad();
  }

  Future<void> _requestPermissionAndLoad() async {
    final granted = await FlutterContacts.requestPermission();
    if (granted) {
      await _fetchAllContacts();
    } else {
      _showPermissionDialog();
    }
  }

  Future<void> _checkPermissionAndLoad() async {
    final granted = await FlutterContacts.requestPermission();
    if (granted && _allContacts.isEmpty) {
      await _fetchAllContacts();
    } else if (!granted) {
      _showPermissionDialog();
    }
  }

  void _showPermissionDialog() {
    if (Get.isDialogOpen ?? false) return;

    Get.dialog(
      Dialog(
        backgroundColor: ColorConstants.white, // Add white background
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.contacts_rounded,
                size: 56.sp,
                color: ColorConstants.appThemeColor,
              ),
              SizedBox(height: 16.h),
              Text(
                'Contacts Permission Required',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.black,
                  fontFamily: AppFonts.poppins,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'To display your contacts, please allow access in the app settings.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: ColorConstants.grey,
                  fontFamily: AppFonts.poppins,
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    style: TextButton.styleFrom(
                      foregroundColor: ColorConstants.black,
                      textStyle: TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _openAppSettings,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.appThemeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                    ),
                    child: Text(
                      'Open Settings',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: ColorConstants.white,
                        fontFamily: AppFonts.poppins,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future<void> _openAppSettings() async {
    if (Get.isDialogOpen ?? false) Get.back();

    final uri = Uri.parse('app-settings:');

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        Get.snackbar('Error', 'Could not open app settings');
      }
    } catch (e) {
      Get.snackbar('Error', 'Unable to open settings');
    }
  }

  Future<void> _fetchAllContacts() async {
    isLoading.value = true;
    try {
      final contacts = await FlutterContacts.getContacts(withProperties: true);
      _allContacts.assignAll(
        contacts.map((c) {
          final phone = c.phones.isNotEmpty ? c.phones.first.number : '';
          return {'name': c.displayName ?? 'Unknown', 'phone': phone};
        }),
      );

      _currentPage = 0;
      _applyPagination();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load contacts');
    } finally {
      isLoading.value = false;
    }
  }

  void _applyPagination() {
    final start = _currentPage * _pageSize;
    final end = (_currentPage + 1) * _pageSize;
    final pageItems = _allContacts.sublist(
      start,
      end.clamp(0, _allContacts.length),
    );

    if (_currentPage == 0) {
      displayedContacts.assignAll(pageItems);
    } else {
      displayedContacts.addAll(pageItems);
    }

    hasMoreContacts.value = end < _allContacts.length;
  }

  Future<void> loadMoreContacts() async {
    if (isSearchActive.value || isLoadingMore.value || !hasMoreContacts.value)
      return;

    isLoadingMore.value = true;
    _currentPage++;
    await Future.delayed(const Duration(milliseconds: 300));
    _applyPagination();
    isLoadingMore.value = false;
  }

  void _onSearchChanged() {
    final query = searchController.text.trim().toLowerCase();
    isSearchActive.value = query.isNotEmpty;

    if (query.isEmpty) {
      _currentPage = 0;
      displayedContacts.clear();
      _applyPagination();
      return;
    }

    final filtered = _allContacts.where((c) {
      final name = (c['name'] as String).toLowerCase();
      final phone = (c['phone'] as String).toLowerCase();
      return name.contains(query) || phone.contains(query);
    }).toList();

    displayedContacts.assignAll(filtered);
    hasMoreContacts.value = false;
  }

  Future<void> refreshContacts() async {
    await _fetchAllContacts();
  }
}
