import 'package:flutter/material.dart';
import 'package:project1/models/todo_model.dart';
import 'package:project1/widgets/card_home.dart';
import 'package:project1/widgets/list_data.dart';
import 'package:project1/widgets/serach.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TodoModel _todos = TodoModel();

  @override
  void initState() {
    _todos.getTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardHome(),
            SizedBox(
              height: 20,
            ),
            Search(),
            SizedBox(
              height: 20,
            ),
            ListData()
          ],
        ),
      ),
    );
  }
}
