import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global_variable.dart';

class AuthService {
  late String? token;

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
      // print('Error: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>> logout() async {
    try {
      token = await getToken();
      final dio = Dio();
      final response = await dio.post(
        '${baseUrl}auth/logout',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }),
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.remove('token');
      prefs.remove('expiryDate');
      return response.data;
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
