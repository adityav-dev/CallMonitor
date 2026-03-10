// import 'package:get_storage/get_storage.dart';
//
// class LocalStorageService {
//   static final LocalStorageService _instance = LocalStorageService._internal();
//   factory LocalStorageService() => _instance;
//
//   late GetStorage _box;
//
//   static const String contactGroupsKey = 'contact_groups'; // For previous screen
//   static const String contactsKey = 'contacts'; // For AddContactScreen
//
//   LocalStorageService._internal();
//
//   Future<void> init() async {
//     _box = GetStorage();
//   }
//
//   void write(String key, dynamic value) => _box.write(key, value);
//
//   T? read<T>(String key) => _box.read<T>(key);
//
//   bool has(String key) => _box.hasData(key);
//
//   void remove(String key) => _box.remove(key);
//
//   void clear() => _box.erase();
//
//   // ====== Typed Helpers for Contact Groups (Previous Screen) ======
//   List<Map<String, dynamic>> getContactGroups() {
//     final List? list = _box.read<List>(contactGroupsKey);
//     if (list != null) {
//       return list.map((e) => Map<String, dynamic>.from(e)).toList();
//     }
//     return [];
//   }
//
//    saveContactGroups(List<Map<String, dynamic>> groups) {
//     _box.write(contactGroupsKey, groups);
//   }
//
//   // ====== Typed Helpers for Contacts (AddContactScreen) ======
//   List<Map<String, dynamic>> getContacts() {
//     final List? list = _box.read<List>(contactsKey);
//     if (list != null) {
//       return list.map((e) => Map<String, dynamic>.from(e)).toList();
//     }
//     return [];
//   }
//
//    saveContacts(List<Map<String, dynamic>> contacts) {
//     _box.write(contactsKey, contacts);
//   }
// }