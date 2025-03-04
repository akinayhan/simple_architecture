import 'package:url_launcher/url_launcher.dart';

Future<void> whatsappLaunchUrl() async {
  final Uri url = Uri.parse('https://wa.me/+90 123 456 78 90');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}