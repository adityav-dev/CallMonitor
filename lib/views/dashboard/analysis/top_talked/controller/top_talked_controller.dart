import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactCall {
  final String name;
  final String phoneNumber;
  final int callCount;
  final String totalDuration;

  ContactCall({
    required this.name,
    required this.phoneNumber,
    this.callCount = 0,
    this.totalDuration = '0s',
  });
}

class TopTalkedController extends GetxController {
  final selectedTab = 0.obs;
  final type = 'frequently'.obs;

  void initType(String t) {
    type.value = t;
  }

  // Sample Data for "Frequently Talked"
  final List<ContactCall> allCalls = [
    ContactCall(
      name: 'Ankur Bhaii',
      phoneNumber: '+918604579654',
      callCount: 6,
      totalDuration: '1h 04m 10s',
    ),
    ContactCall(
      name: 'Rishabh Maurya SMS',
      phoneNumber: '+919161342857',
      callCount: 3,
      totalDuration: '54m 22s',
    ),
    ContactCall(
      name: 'Brijendra CS',
      phoneNumber: '+917785889485',
      callCount: 3,
      totalDuration: '38m 05s',
    ),
    ContactCall(
      name: 'Jija',
      phoneNumber: '+918318747499',
      callCount: 2,
      totalDuration: '22m 40s',
    ),
  ];

  final List<ContactCall> incomingCalls = [
    ContactCall(
      name: 'Ankur Bhaii',
      phoneNumber: '+918604579654',
      callCount: 4,
      totalDuration: '42m 12s',
    ),
    ContactCall(
      name: 'Rishabh Maurya SMS',
      phoneNumber: '+919161342857',
      callCount: 2,
      totalDuration: '31m 04s',
    ),
  ];

  final List<ContactCall> outgoingCalls = [
    ContactCall(
      name: 'Brijendra CS',
      phoneNumber: '+917785889485',
      callCount: 3,
      totalDuration: '38m 05s',
    ),
    ContactCall(
      name: 'Jija',
      phoneNumber: '+918318747499',
      callCount: 2,
      totalDuration: '22m 40s',
    ),
  ];

  void changeTab(int index) {
    selectedTab.value = index;
  }

  List<ContactCall> getCurrentTabData() {
    switch (selectedTab.value) {
      case 1:
        return incomingCalls;
      case 2:
        return outgoingCalls;
      default:
        return allCalls;
    }
  }
}
