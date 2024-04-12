import 'package:dio/dio.dart';
import 'package:project1/models/todo_model.dart';
import '../global_variable.dart';

class TodoService {
  late String? token;

  Future getTodo({String? orderBy}) async {
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

        List<TodoModel> todos =
            responseData.map((e) => TodoModel.fromJson(e)).toList();
        return todos;
      } else {
        print('Error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future getCount() async {
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
        return false;
      }
    } catch (e) {
      // print('Error: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>> addTodo(String name) async {
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
        return response.data;
      } else {
        // print('Error: ${response.statusCode}');
        return {'message': response.data['message']};
      }
    } catch (e) {
      // print('Error: $e');
      return {'message': e};
    }
  }
}
