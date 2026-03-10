import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/app-export.dart';

class HelpSupportController extends GetxController {
  void sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@aitotabusiness.com',
      query: 'subject=Help Request',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      Get.snackbar('Error', 'Could not launch email client');
    }
  }

  void makeCall() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '+1-800-123-4567');
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      Get.snackbar('Error', 'Could not launch phone dialer');
    }
  }
}
