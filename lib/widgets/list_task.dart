import 'package:flutter/material.dart';
import 'package:project1/models/task_model.dart';

class ListTask extends StatelessWidget {
  final TaskModel task;
  const ListTask({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double deviceHeight = MediaQuery.of(context).size.height;
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
          padding: const EdgeInsets.all(20),
          width: deviceWidth * 0.9,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    task.done != 0 ? Icons.circle_outlined : Icons.check_circle,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(task.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        decoration:
                            task.done != 0 ? null : TextDecoration.lineThrough,
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
