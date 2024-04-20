import 'package:flutter/material.dart';
import 'package:project1/services/task_service.dart';
import '../services/todo_service.dart';

class TodoDialogHelper {
  static final TodoService _todoService = TodoService();
  static final TaskService _taskService = TaskService();

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
    if (tipe == 'home') {
      return _todoService.addTodo(name);
    } else {
      return _taskService.addTask(name, tipe);
    }
  }
}
