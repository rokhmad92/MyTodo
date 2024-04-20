import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global_variable.dart';

class AuthService {
  Future<bool> login(String email, String password) async {
    try {
      final dio = Dio();
      final response = await dio.post(
        '${baseUrl}auth/login',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {
          'email': email,
          'password': password,
        },
      );

      Map obj = response.data;
      saveToken(obj['token']);
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
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

  void logout() {}
  // void withGoogle() {}
}
