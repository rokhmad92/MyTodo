import 'package:project1/models/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';

class TaskServiceOffline {
  late String? token;

  Future<List<TaskModel>> getTask(int id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? taskStrings = prefs.getStringList('task');

      if (taskStrings == null) {
        return [];
      }

      List<TaskModel> data = taskStrings
          .map((taskString) => TaskModel.fromModel(jsonDecode(taskString)))
          .where((task) => task.titleId == id)
          .toList();

      return data;
    } catch (e) {
      // print('Error Get Task: $e');
      return [];
    }
  }

  Future<String> addTask(String name, int id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // get data dari local
      List<String>? taskList = prefs.getStringList('task');
      int? countDataTask = prefs.getInt('countTask$id');
      int newId = generateId(); // create id

      // ini data yang akan di create
      Map<String, dynamic> newTask = {
        'id': newId,
        'title_id': id,
        'name': name,
        'done': 0
      };

      if (taskList != null) {
        taskList.add(jsonEncode(newTask));
      } else {
        taskList = [jsonEncode(newTask)];
      }

      // rubah value count Task dan Count done di todo
      List<String>? todoStrings = prefs.getStringList('todos');

      if (todoStrings != null) {
        void updateTodo(Map<String, dynamic> todo, String key, dynamic value) {
          todo[key] = value;
        }

        List<Map<String, dynamic>> responseData = todoStrings
            .map(
                (todoString) => json.decode(todoString) as Map<String, dynamic>)
            .toList();

        // ubah value
        for (var todo in responseData) {
          if (todo['id'] == id) {
            updateTodo(todo, 'countTask',
                countDataTask != null ? countDataTask + 1 : 1);
          }
        }

        // Mengubah kembali list map menjadi list string JSON
        List<String> updatedTodoStrings =
            responseData.map((todoMap) => json.encode(todoMap)).toList();

        // Menyimpan kembali ke SharedPreferences
        await prefs.setStringList('todos', updatedTodoStrings);
      }

      // Simpan daftar tugas yang telah diperbarui kembali ke SharedPreferences
      await prefs.setStringList('task', taskList);
      await prefs.setInt(
          'countTask$id', countDataTask != null ? countDataTask + 1 : 1);

      return 'Berhasil create data';
    } catch (e) {
      // print('Error: $e');
      return e.toString();
    }
  }

  Future<Map<String, dynamic>> changeTask(int id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // get data dari local
      List<String>? taskStrings = prefs.getStringList('task');

      if (taskStrings == null) {
        return {'message': 'Error 500 Server Error'};
      }

      List<TaskModel> data = taskStrings
          .map((taskString) => TaskModel.fromModel(jsonDecode(taskString)))
          .toList();

      for (int i = 0; i < data.length; i++) {
        if (data[i].id == id) {
          data[i] = TaskModel(
            id: data[i].id,
            titleId: data[i].titleId,
            name: data[i].name,
            done: data[i].done == 0 ? 1 : 0,
          );

          // rubah value count Task dan Count done di todo
          List<String>? todoStrings = prefs.getStringList('todos');
          if (todoStrings != null) {
            void updateTodo(
                Map<String, dynamic> todo, String key, dynamic value) {
              todo[key] = value;
            }

            List<Map<String, dynamic>> responseData = todoStrings
                .map((todoString) =>
                    json.decode(todoString) as Map<String, dynamic>)
                .toList();

            // ubah value
            for (var todo in responseData) {
              if (todo['id'] == data[i].titleId) {
                updateTodo(
                    todo,
                    'countDone',
                    data[i].done == 1
                        ? todo['countDone'] + 1
                        : todo['countDone'] - 1);
              }
            }

            // Mengubah kembali list map menjadi list string JSON
            List<String> updatedTodoStrings =
                responseData.map((todoMap) => json.encode(todoMap)).toList();

            // Menyimpan kembali ke SharedPreferences
            await prefs.setStringList('todos', updatedTodoStrings);
          }
        } else {
          data[i] = TaskModel(
            id: data[i].id,
            titleId: data[i].titleId,
            name: data[i].name,
            done: data[i].done,
          );
        }
      }

      // Simpan daftar tugas yang telah diperbarui kembali ke SharedPreferences
      List<String> updatedTaskStrings =
          data.map((item) => jsonEncode(item.toModel())).toList();
      await prefs.setStringList('task', updatedTaskStrings);

      return {'message': 'Berhasil merubah task'};
    } catch (e) {
      // print('Error: $e');
      return {'message': e};
    }
  }

  Future<Map<String, dynamic>> removeTask(int id, int titleId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // get data
      List<String>? taskList = prefs.getStringList('task');
      int? countDataTask = prefs.getInt('countTask$titleId');

      if (taskList != null) {
        // rubah value count Task dan Count done di todo
        List<String>? todoStrings = prefs.getStringList('todos');

        if (todoStrings != null) {
          void updateTodo(
              Map<String, dynamic> todo, String key, dynamic value) {
            todo[key] = value;
          }

          List<Map<String, dynamic>> responseData = todoStrings
              .map((todoString) =>
                  json.decode(todoString) as Map<String, dynamic>)
              .toList();

          // Temukan dan hapus tugas dengan ID yang sesuai
          taskList.removeWhere((task) {
            Map<String, dynamic> taskData = json.decode(task);

            // ubah value di todo
            for (var todo in responseData) {
              if (todo['id'] == taskData['title_id'] && taskData['id'] == id) {
                if (taskData['done'] == 1) {
                  updateTodo(todo, 'countDone', todo['countDone'] - 1);
                }

                updateTodo(todo, 'countTask', todo['countTask'] - 1);
              }
            }
            return taskData['id'] == id;
          });

          // Mengubah kembali list map menjadi list string JSON
          List<String> updatedTodoStrings =
              responseData.map((todoMap) => json.encode(todoMap)).toList();

          // Menyimpan kembali ke SharedPreferences
          await prefs.setStringList('todos', updatedTodoStrings);
        }

        // Simpan daftar tugas yang telah diperbarui kembali ke SharedPreferences
        await prefs.setStringList('task', taskList);
        await prefs.setInt(
            'countTask$titleId', countDataTask == null ? 0 : countDataTask - 1);
      }

      return {'message': 'Berhasil hapus data'};
    } catch (e) {
      // print('Error: $e');
      return {'message': e};
    }
  }

  Future<int> getTotal(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? countDataTask = prefs.getInt('countTask$id');

    return countDataTask ?? 0;
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
