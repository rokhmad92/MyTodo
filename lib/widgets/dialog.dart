import 'package:flutter/material.dart';
import 'package:project1/pages/home.dart';
import '../services/todo_service.dart';

class TodoDialogHelper {
  static final TodoService _todoService = TodoService();

  static Future<String?> showTodoDialog(BuildContext context) async {
    String todoName = '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tambah To Do List'),
          content: TextField(
            onChanged: (value) {
              todoName = value;
            },
            decoration: const InputDecoration(hintText: 'Nama'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // close dialog
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                await action(todoName);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Home(),
                  ),
                );
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
    return null;
  }

  static action(String name) async {
    var message = _todoService.addTodo(name);
    return message;
  }
}
