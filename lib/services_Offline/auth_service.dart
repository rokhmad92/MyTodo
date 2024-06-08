import 'package:shared_preferences/shared_preferences.dart';
import '../global_variable.dart';

class AuthServiceOffline {
  late String? token;

  Future<bool> login() async {
    try {
      saveToken('Offline');
      return true;
    } catch (e) {
      // print('Error: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>> logout() async {
    try {
      token = await getToken();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.remove('token');
      prefs.remove('expiryDate');
      return {'message': 'Successfully Logout!'};
    } catch (e) {
      // print('Error: $e');
      return {'message': e};
    }
  }

  void saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);

    // Atur expiry date 1 minggu dari sekarang
    DateTime now = DateTime.now();
    DateTime expiryDate = now.add(const Duration(days: 7));
    prefs.setString('expiryDate', expiryDate.toIso8601String());
  }
}
