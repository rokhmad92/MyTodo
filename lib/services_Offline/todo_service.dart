import '../models/todo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';

class TodoServiceOffline {
  Future<List<TodoModel>> getTodo(
      {String keyword = '', String? orderBy}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // Ambil data dari SharedPreferences
      List<String>? todoStrings = prefs.getStringList('todos');

      if (todoStrings == null) {
        return [];
      }

      // Konversi setiap string ke objek Map
      List<Map<String, dynamic>> data = todoStrings
          .map((todoString) => json.decode(todoString) as Map<String, dynamic>)
          .toList();

      // Filter data yang memiliki nilai countDone dan countTask yang tidak sama
      List<Map<String, dynamic>> notEqualData =
          data.where((todo) => todo['countDone'] != todo['countTask']).toList();
      List<Map<String, dynamic>> equalData =
          data.where((todo) => todo['countDone'] == todo['countTask']).toList();

      // Gabungkan kedua list, dengan yang != dulu, kemudian yang ==
      List<Map<String, dynamic>> responseData = [...notEqualData, ...equalData];

      // filter search data
      if (keyword.isNotEmpty) {
        responseData = responseData
            .where((data) =>
                data['name'].toLowerCase().contains(keyword.toLowerCase()))
            .toList();
      }

      // Map List<Map<String, dynamic>> to List<TodoModel>
      List<TodoModel> todos =
          responseData.map((e) => TodoModel.fromJson(e)).toList();

      return todos;
    } catch (e) {
      // print('Error: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> getCount() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? countData = prefs.getStringList('count');
      List<String>? todoStrings = prefs.getStringList('todos');

      // inisialize awal
      int total = 0;
      int done = 0;
      int proses = 0;

      if (countData == null || countData.isEmpty) {
        // Simpan string JSON ke SharedPreferences
        Map<String, dynamic> countMap = {
          'total': total,
          'done': done,
          'proses': proses,
        };
        String countDataString = jsonEncode(countMap);
        prefs.setStringList('count', [countDataString]);
        return countMap;
      } else {
        // Ambil data dari SharedPreferences jika countData tidak kosong
        if (todoStrings != null) {
          List<Map<String, dynamic>> responseData = todoStrings
              .map((todoString) =>
                  json.decode(todoString) as Map<String, dynamic>)
              .toList();

          // ubah value
          for (var todo in responseData) {
            if (todo['countTask'] == todo['countDone']) {
              done = done + 1;
            } else {
              proses = proses + 1;
            }
          }
        }

        String countDataString = countData.first;
        Map<String, dynamic> countMap = jsonDecode(countDataString);
        countMap['done'] = done;
        countMap['proses'] = proses;
        String updatedCountDataString = json.encode(countMap);
        countData[0] = updatedCountDataString;
        prefs.setStringList('count', countData);

        Map<String, dynamic> count = jsonDecode(countData.first);
        return count;
      }
    } catch (e) {
      return {'message': e.toString()};
    }
  }

  Future<String> addTodo(String name) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // get data dari local
      List<String>? todoList = prefs.getStringList('todos');
      List<String>? countData = prefs.getStringList('count');
      int id = generateId(); // create id

      // ini data yang akan di create
      Map<String, dynamic> newTodo = {
        'id': id,
        'name': name,
        'due': '',
        'countTask': 0,
        'countDone': 0,
      };

      if (todoList != null) {
        todoList.add(jsonEncode(newTodo));
      } else {
        todoList = [jsonEncode(newTodo)];
      }

      // Simpan daftar tugas yang telah diperbarui kembali ke SharedPreferences
      await prefs.setStringList('todos', todoList);

      // edit total & done agar menjadi + 1
      if (countData != null && countData.isNotEmpty) {
        String countDataString = countData.first;
        Map<String, dynamic> countMap = jsonDecode(countDataString);
        countMap['total'] = countMap['total'] + 1;

        countDataString = jsonEncode(countMap);
        prefs.setStringList('count', [countDataString]);
      }

      return 'Berhasil create data';
    } catch (e) {
      // print('Error: $e');
      return e.toString();
    }
  }

  Future<String> removeTodo(int id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // get data
      List<String>? todoList = prefs.getStringList('todos');
      List<String>? countData = prefs.getStringList('count');

      if (todoList == null) {
        return 'Tidak ada data tugas yang tersimpan.';
      }

      // Temukan dan hapus tugas dengan ID yang sesuai
      todoList.removeWhere((todo) {
        Map<String, dynamic> todoData = json.decode(todo);
        return todoData['id'] == id;
      });

      // edit total & done agar menjadi - 1
      if (countData != null && countData.isNotEmpty) {
        String countDataString = countData.first;
        Map<String, dynamic> countMap = jsonDecode(countDataString);
        countMap['total'] = countMap['total'] - 1;

        countDataString = jsonEncode(countMap);
        prefs.setStringList('count', [countDataString]);
        prefs.remove('countTask$id');
      }

      // Simpan daftar tugas yang telah diperbarui kembali ke SharedPreferences
      await prefs.setStringList('todos', todoList);

      return 'Berhasil hapus data';
    } catch (e) {
      return e.toString();
    }
  }

  int generateId() {
    // Dapatkan tahun, bulan, dan hari saat ini
    DateTime now = DateTime.now();
    int year = now.year % 100; // Ambil dua digit terakhir dari tahun
    int month = now.month;
    int day = now.day;

    // Generate empat digit angka acak
    Random random = Random();
    int randomDigits = random.nextInt(10000); // Angka acak dari 0 hingga 9999

    // Gabungkan semua komponen untuk membuat ID
    int id = year * 1000000 + month * 10000 + day * 100 + randomDigits;

    return id;
  }
}
