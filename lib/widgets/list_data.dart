import 'package:flutter/material.dart';
import 'package:project1/models/todo_model.dart';

class ListData extends StatelessWidget {
  final TodoModel todo;
  const ListData({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 14),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
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
                    todo.countDone != 0
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
                        decoration: todo.countDone != 0
                            ? null
                            : TextDecoration.lineThrough,
                      ))
                ],
              ),
              Text(
                '${todo.countTask} Task',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w100,
                    color: Colors.grey[400]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
