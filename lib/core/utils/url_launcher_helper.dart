import 'package:url_launcher/url_launcher.dart';

Future<bool> executeOpenUrl(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await canLaunchUrl(uri)) {
    return false;
  }
  return launchUrl(uri, webOnlyWindowName: '_blank');
}
