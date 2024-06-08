import 'package:dio/dio.dart';
import '../models/todo_model.dart';
import '../global_variable.dart';

class TodoService {
  late String? token;

  Future<List<TodoModel>> getTodo(
      {String keyword = '', String? orderBy}) async {
    try {
      token = await getToken();
      final dio = Dio();
      final response = await dio.get('${baseUrl}todos',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }));
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> responseData =
            List<Map<String, dynamic>>.from(response.data['data']);

        // filter
        if (orderBy == 'asc') {
          responseData.sort((a, b) => a['countDone']
              .compareTo(b['countDone'])); // dari terkecil ke terbesar
        } else if (orderBy == 'desc') {
          responseData.sort((a, b) => b['countDone']
              .compareTo(a['countDone'])); // dari terbesar ke terkecil
        }

        // filter serach data
        if (keyword.isNotEmpty) {
          responseData = responseData
              .where((data) =>
                  data['name'].toLowerCase().contains(keyword.toLowerCase()))
              .toList();
        }

        List<TodoModel> todos =
            responseData.map((e) => TodoModel.fromJson(e)).toList();

        return todos;
      } else {
        // print('Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // print('Error: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> getCount() async {
    try {
      token = await getToken();
      final dio = Dio();
      final response = await dio.get('${baseUrl}count',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }));
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data['data'];
        return responseData;
      } else {
        // print('Error: ${response.statusCode}');
        return {'message': 'Error 500'};
      }
    } catch (e) {
      // print('Error: $e');
      return {'message': e.toString()};
    }
  }

  Future<String> addTodo(String name) async {
    try {
      token = await getToken();
      final dio = Dio();
      final response = await dio.post('${baseUrl}todos',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }),
          data: {'name': name});
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

  Future<String> removeTodo(int id) async {
    try {
      token = await getToken();
      final dio = Dio();
      final response = await dio.delete('${baseUrl}todos/$id',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }),
          data: {'id': id});
      if (response.statusCode == 201) {
        return response.data['message'].toString();
      } else {
        return response.data['message'].toString();
      }
    } catch (e) {
      return e.toString();
    }
  }
}
