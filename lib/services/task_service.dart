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
      print('Error Get Task: $e');
      return null;
    }
  }
}
