import 'package:url_launcher/url_launcher.dart';

void navigateToWebSide() async {
  const privacyPolicyUrl = 'https://google.com.tr/';

    await launchUrl(
      Uri.parse(privacyPolicyUrl),
      mode: LaunchMode.inAppWebView,
    );
}