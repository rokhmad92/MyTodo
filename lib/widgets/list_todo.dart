import 'package:flutter/material.dart';
import '../models/todo_model.dart';
import '../pages/show_todo.dart';
import '../services_Offline/todo_service.dart';
import '../services_Online/todo_service.dart';

class ListTodo extends StatefulWidget {
  final TodoModel todo;
  final Function() getData;
  final String? token;
  const ListTodo(
      {Key? key,
      required this.todo,
      required this.getData,
      required this.token})
      : super(key: key);

  @override
  State<ListTodo> createState() => _ListTodoState();
}

class _ListTodoState extends State<ListTodo> {
  late final TodoModel todo;
  final TodoService todoService = TodoService();
  final TodoServiceOffline todoServiceOffline = TodoServiceOffline();

  Future<void> removeTodo(id) async {
    String result = widget.token == 'Offline'
        ? await todoServiceOffline.removeTodo(id)
        : await todoService.removeTodo(id);

    widget.getData();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void initState() {
    todo = widget.todo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 14),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () async {
          final showData = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => ShowTodo(id: todo.id)));
          if (showData == true) {
            widget.getData();
          }
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          width: deviceWidth * 0.9,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    todo.countTask != todo.countDone
                        ? Icons.circle_outlined
                        : Icons.check_circle,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(todo.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        decoration: todo.countTask != todo.countDone
                            ? null
                            : TextDecoration.lineThrough,
                      ))
                ],
              ),
              Row(
                children: [
                  Text(
                    '${todo.countTask} Task',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                        color: Colors.grey[400]),
                  ),
                  IconButton(
                    splashRadius: 20,
                    icon: const Icon(Icons.remove),
                    onPressed: () => {removeTodo(todo.id)},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
