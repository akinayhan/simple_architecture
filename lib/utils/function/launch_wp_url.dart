import 'package:url_launcher/url_launcher.dart';

Future<void> launchWPUrl() async {
  final Uri url = Uri.parse('https://wa.me/+908505506226');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}