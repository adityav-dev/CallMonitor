import '../app-export.dart';

void customSnackBar({
  required String message,
  String type = 'I', // I = Info, S = Success, E = Error
  SnackPosition position = SnackPosition.TOP,
  VoidCallback? onTap, // Optional tap callback
}) {
  Color backgroundColor;
  Color iconColor;
  IconData icon;

  switch (type) {
    case 'S':
      backgroundColor = ColorConstants.appThemeColor;
      iconColor = Colors.white;
      icon = Icons.check_circle;
      break;
    case 'E':
      backgroundColor = ColorConstants.error;
      iconColor = Colors.white;
      icon = Icons.error;
      break;
    case 'I':
    default:
      backgroundColor = ColorConstants.warningGradient1;
      iconColor = Colors.green;
      icon = Icons.check_circle_outline;
  }

  Get.snackbar(
    '',
    '',
    titleText: const SizedBox.shrink(),
    messageText: GestureDetector(
      onTap: onTap, // tap functionality added here
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: ColorConstants.white,
                fontFamily: AppFonts.poppins,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    ),
    snackPosition: position,
    backgroundColor: backgroundColor,
    borderRadius: 8,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    duration: const Duration(seconds: 3),
  );
}
