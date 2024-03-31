import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoModel {
  String? token;

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
  }

  Future<List<dynamic>> getTodos() async {
    await getToken();
    try {
      final dio = Dio();
      final response = await dio.get(
        'http://127.0.0.1:8000/api/todo',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }),
      );

      print(response.data['data']);
      return response.data['data'];
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
