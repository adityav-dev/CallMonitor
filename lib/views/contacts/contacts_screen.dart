import 'package:call_monitor/core/app-export.dart';
import 'controller/contacts_controller.dart';

class ContactsScreen extends GetView<ContactsController> {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: CustomAppBar(
        title: 'Contacts',
        centerTitle: true,
        showBackButton: false,
        onTapBack: () => Get.back(),
      ),
      body: Obx(() {
        // Loading
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: ColorConstants.appThemeColor,
            ),
          );
        }

        return Column(
          children: [
            // Search bar - always visible
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: TextField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  hintText: 'Search contacts...',
                  prefixIcon: const Icon(
                    Icons.search,
                    color: ColorConstants.appThemeColor,
                  ),
                  suffixIcon: controller.searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close, color: Colors.grey),
                          onPressed: controller.searchController.clear,
                        )
                      : null,
                  filled: true,
                  fillColor: ColorConstants.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
            ),

            // Contact list or empty state
            Expanded(
              child: controller.displayedContacts.isEmpty
                  ? Center(
                      child: Text(
                        controller.isSearchActive.value
                            ? 'No contacts match your search'
                            : 'No contacts found',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    )
                  : NotificationListener<ScrollNotification>(
                      onNotification: (scroll) {
                        if (scroll.metrics.extentAfter < 200 &&
                            !controller.isLoadingMore.value &&
                            controller.hasMoreContacts.value) {
                          controller.loadMoreContacts();
                        }
                        return false;
                      },
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount:
                            controller.displayedContacts.length +
                            (controller.hasMoreContacts.value ? 1 : 0),
                        itemBuilder: (context, index) {
                          // Loading more indicator
                          if (index == controller.displayedContacts.length &&
                              controller.hasMoreContacts.value) {
                            return const Padding(
                              padding: EdgeInsets.all(12),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: ColorConstants.appThemeColor,
                                ),
                              ),
                            );
                          }

                          final contact = controller.displayedContacts[index];
                          return _buildContactCard(contact, theme);
                        },
                      ),
                    ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildContactCard(Map<String, dynamic> contact, ThemeData theme) {
    final phone = contact['phone'] ?? 'Unknown';
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: ColorConstants.appThemeColor.withOpacity(0.15),
          child: Text(
            (contact['name'] ?? 'U')[0].toUpperCase(),
            style: TextStyle(
              color: ColorConstants.appThemeColor,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
        ),
        title: Text(
          contact['name'] ?? 'Unknown',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13.sp),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          phone,
          style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
        ),
        trailing: Icon(
          Icons.phone,
          color: ColorConstants.appThemeColor,
          size: 20.sp,
        ),
        onTap: () {
          // You can add dial logic here
        },
      ),
    );
  }
}
