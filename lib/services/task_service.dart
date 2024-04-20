import 'package:dio/dio.dart';
import 'package:project1/global_variable.dart';
import 'package:project1/models/task_model.dart';

class TaskService {
  late String? token;

  Future<DataTask?> getTask(int id) async {
    try {
      token = await getToken();
      final dio = Dio();
      final response = await dio.get('${baseUrl}task/$id',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }));

      final data = DataTask.fromJson(response.data);
      return data;
    } catch (e) {
      // print('Error Get Task: $e');
      return null;
    }
  }

  Future<String> addTask(String name, int id) async {
    try {
      token = await getToken();
      final dio = Dio();
      final response = await dio.post('${baseUrl}task/$id',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }),
          data: {'id': id, 'name': name});
      if (response.statusCode == 201) {
        // print(response.data['message']);
        return response.data['message'].toString();
      } else {
        // print('Error: ${response.statusCode}');
        return response.data['message'].toString();
      }
    } catch (e) {
      // print('Error: $e');
      return e.toString();
    }
  }

  Future<Map<String, dynamic>> changeTask(int id) async {
    try {
      token = await getToken();
      final dio = Dio();
      final response = await dio.put('${baseUrl}task/$id',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }),
          data: {'id': id});
      if (response.statusCode == 201) {
        // print(response.data['message']);
        return response.data;
      } else {
        // print('Error: ${response.statusCode}');
        return response.data;
      }
    } catch (e) {
      // print('Error: $e');
      return {'message': e};
    }
  }

  Future<Map<String, dynamic>> removeTask(int id) async {
    try {
      token = await getToken();
      final dio = Dio();
      final response = await dio.delete('${baseUrl}task/$id',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }),
          data: {'id': id});
      if (response.statusCode == 201) {
        // print(response.data['message']);
        return response.data;
      } else {
        // print('Error: ${response.statusCode}');
        return response.data;
      }
    } catch (e) {
      // print('Error: $e');
      return {'message': e};
    }
  }
}
