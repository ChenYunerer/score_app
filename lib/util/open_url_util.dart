import 'package:url_launcher/url_launcher.dart';

/// 打开一个网站
launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
