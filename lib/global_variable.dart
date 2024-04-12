import 'package:shared_preferences/shared_preferences.dart';

// base URL
const String baseUrl = 'http://127.0.0.1:8000/api/';

// get Token
Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}