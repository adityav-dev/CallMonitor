import '../../../core/app-export.dart';

class CallStatsModel {
  final String name;
  final String phoneNumber;
  final String? profileImage;
  final List<CallStatItem> stats;

  CallStatsModel({
    required this.name,
    required this.phoneNumber,
    this.profileImage,
    required this.stats,
  });
}

class CallStatItem {
  final IconData icon;
  final String label;
  final String value;
  final Color? iconColor;

  CallStatItem({
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor,
  });
}
