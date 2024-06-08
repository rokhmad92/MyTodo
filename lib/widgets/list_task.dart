import 'package:flutter/material.dart';
import '../global_variable.dart';
import '../models/task_model.dart';
import '../services_Offline/task_service.dart';
import '../services_Online/task_service.dart';

class ListTask extends StatefulWidget {
  final TaskModel task;
  final Function() getData;
  const ListTask({super.key, required this.task, required this.getData});

  @override
  State<ListTask> createState() => _ListTaskState();
}

class _ListTaskState extends State<ListTask> {
  late final TaskModel task;
  final TaskService taskService = TaskService();
  final TaskServiceOffline taskServiceOffline = TaskServiceOffline();
  late String? token = '';

  Future<void> done(id) async {
    token = await getToken();
    Map<String, dynamic> result = token == 'Offline'
        ? await taskServiceOffline.changeTask(id)
        : await taskService.changeTask(id);
    widget.getData();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result['message'].toString()),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> remove(id, titleId) async {
    token = await getToken();
    Map<String, dynamic> result = token == 'Offline'
        ? await taskServiceOffline.removeTask(id, titleId)
        : await taskService.removeTask(id);
    await Future.delayed(const Duration(milliseconds: 100));
    widget.getData();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result['message'].toString()),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    task = widget.task;
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          width: deviceWidth * 0.9,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    splashRadius: 20,
                    icon: Icon(task.done == 0
                        ? Icons.circle_outlined
                        : Icons.check_circle),
                    color: Colors.blue,
                    onPressed: () {
                      done(task.id);
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(task.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        decoration:
                            task.done == 0 ? null : TextDecoration.lineThrough,
                      )),
                ],
              ),
              IconButton(
                splashRadius: 20,
                icon: const Icon(Icons.remove),
                onPressed: () => {remove(task.id, task.titleId)},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
