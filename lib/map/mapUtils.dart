import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double x, double y) async {

    String url = "https://www.google.com/maps/search/?api=1&query=$x,$y";

    if(await canLaunch(url)) {
      await launch(url);

    }else {
      throw 'Konum bulunamadı' ;
    }
  }
}
