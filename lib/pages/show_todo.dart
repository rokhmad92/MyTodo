import 'package:flutter/material.dart';
import 'package:project1/models/task_model.dart';
import 'package:project1/services/task_service.dart';
import 'package:project1/widgets/dialog_create.dart';
import 'package:project1/widgets/list_task.dart';

class ShowTodo extends StatefulWidget {
  final int id;
  const ShowTodo({Key? key, required this.id}) : super(key: key);

  @override
  State<ShowTodo> createState() => _ShowTodoState();
}

class _ShowTodoState extends State<ShowTodo> {
  final TaskService taskService = TaskService();
  List<TaskModel> _task = [];
  int _id = 0;
  String _name = '';
  int _total = 0;
  bool _isLoading = false;

  Future<void> getData() async {
    setState(() {
      _task.clear();
      _isLoading = true;
    });
    DataTask? dataTask = await taskService.getTask(widget.id);
    if (dataTask != null) {
      setState(() {
        _name = dataTask.name;
        _total = dataTask.total;
        _task = dataTask.data;
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    _id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 71, 184, 77),
        leading: IconButton(
            onPressed: () => {Navigator.pop(context, true)},
            icon: const Icon(Icons.arrow_back)),
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
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _task.length,
                itemBuilder: (context, index) {
                  return ListTask(task: _task[index], getData: getData);
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.blueGrey,
        onPressed: () async {
          String? result = await TodoDialogHelper.showTodoDialog(context, _id);
          if (result == 'yes') {
            getData();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
