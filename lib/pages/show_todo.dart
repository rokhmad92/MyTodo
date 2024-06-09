import 'package:flutter/material.dart';
import 'package:project1/global_variable.dart';
import 'package:project1/models/task_model.dart';
import 'package:project1/services_Offline/task_service.dart';
import 'package:project1/services_Online/task_service.dart';
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
  final TaskServiceOffline taskServiceOffline = TaskServiceOffline();
  List<TaskModel> _task = [];
  int _id = 0;
  String _name = '';
  int _total = 0;
  bool _isLoading = false;
  late String? token = '';

  Future<void> getData() async {
    token = await getToken();
    setState(() {
      _task.clear();
      _isLoading = true;
    });

    if (token == 'Offline') {
      await Future.delayed(const Duration(milliseconds: 100));
      List<TaskModel> dataTask = await taskServiceOffline.getTask(widget.id);
      int total = await taskServiceOffline.getTotal(widget.id);
      setState(() {
        _task = dataTask;
        _total = total;
        _isLoading = false;
      });
    } else {
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

    setState(() {
      _isLoading = false;
    });
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
          child: WidgetTask(
            isLoading: _isLoading,
            task: _task,
            getData: getData,
          )),
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

class WidgetTask extends StatelessWidget {
  final bool isLoading;
  final List<TaskModel> task;
  final Function() getData;

  const WidgetTask({
    Key? key,
    required this.isLoading,
    required this.task,
    required this.getData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (task.isEmpty) {
      return const Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              'Data Kosong',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      );
    } else {
      return ListView.builder(
        itemCount: task.length,
        itemBuilder: (context, index) {
          return ListTask(task: task[index], getData: getData);
        },
      );
    }
  }
}
