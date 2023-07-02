import 'package:intl/intl.dart';

class Utils {
  // static String url = "http://localhost:8000"; // endereço padrao
  static String url =
      "http://10.0.2.2:8000"; // endereço especifico do emulador de android
  static String userKey = "userKey";
  static String isNotificationEnabled = "isNotificationEnabled";
  static int defaultTimeout = 10;

  static String formatData(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formatedDate = DateFormat('dd/MM/yyyy').format(dateTime);

    return formatedDate;
  }
}
