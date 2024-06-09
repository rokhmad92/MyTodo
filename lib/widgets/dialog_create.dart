import 'package:flutter/material.dart';
import 'package:project1/services_Offline/task_service.dart';
import 'package:project1/services_Offline/todo_service.dart';
import 'package:project1/services_Online/task_service.dart';
import '../services_Online/todo_service.dart';
import '../global_variable.dart';

class TodoDialogHelper {
  static final TodoService _todoService = TodoService();
  static final TodoServiceOffline _todoServiceOffline = TodoServiceOffline();
  static final TaskService _taskService = TaskService();
  static final TaskServiceOffline _taskServiceOffline = TaskServiceOffline();

  static Future<String?> showTodoDialog(BuildContext context, tipe) async {
    String name = '';

    String nice = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tambah Data'),
          content: TextField(
            onChanged: (value) {
              name = value;
            },
            decoration: const InputDecoration(hintText: 'Nama'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // close dialog
                Navigator.pop(context, 'no');
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                String result = await action(name, tipe);
                Navigator.pop(context, 'yes');

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(result.toString()),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
    return nice;
  }

  static action(String name, tipe) async {
    String? token = await getToken();
    if (token == 'Offline') {
      if (tipe == 'home') {
        return _todoServiceOffline.addTodo(name);
      } else {
        return _taskServiceOffline.addTask(name, tipe);
      }
    } else {
      if (tipe == 'home') {
        return _todoService.addTodo(name);
      } else {
        return _taskService.addTask(name, tipe);
      }
    }
  }
}
