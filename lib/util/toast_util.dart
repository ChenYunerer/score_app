import 'package:fluttertoast/fluttertoast.dart';
import 'package:score_app/config/color_config.dart';

class ToastUtil {
  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: ColorConfig.white,
        fontSize: 14,
        textColor: ColorConfig.textBlack);
  }
}
