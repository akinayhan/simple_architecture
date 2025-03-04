import 'package:shared_preferences/shared_preferences.dart';

Future<void> clearAllSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
