import 'package:flutter/material.dart';
import 'package:project1/models/task_model.dart';
import 'package:project1/services/task_service.dart';
import 'package:project1/widgets/list_task.dart';

class ShowTodo extends StatefulWidget {
  final int id;
  const ShowTodo({Key? key, required this.id}) : super(key: key);

  @override
  State<ShowTodo> createState() => _ShowTodoState();
}

class _ShowTodoState extends State<ShowTodo> {
  final TaskService task_service = TaskService();
  List<TaskModel> _task = [];
  String _name = '';
  int _total = 0;

  getData() async {
    DataTask? dataTask = await task_service.getTask(widget.id);
    if (dataTask != null) {
      setState(() {
        _name = dataTask.name;
        _total = dataTask.total;
        _task = dataTask.data;
      });
    } else {
      // Handle null dataTask
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8BC34A),
        title: Text(_name),
        actions: [
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$_total Task',
              style: const TextStyle(fontSize: 18),
            ),
          ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          itemCount: _task.length,
          itemBuilder: (context, index) {
            return ListTask(task: _task[index]);
          },
        ),
      ),
    );
  }
}
