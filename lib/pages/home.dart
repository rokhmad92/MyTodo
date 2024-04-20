import 'package:flutter/material.dart';
import 'package:project1/models/todo_model.dart';
import 'package:project1/services/todo_service.dart';
import 'package:project1/widgets/card_home.dart';
import 'package:project1/widgets/dialog_create.dart';
import 'package:project1/widgets/list_todo.dart';
import '../widgets/search.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<TodoModel> _todos = [];
  Map<String, dynamic> _count = {};
  final TodoService _todoService = TodoService();
  bool _isLoading = false;

  Future<void> getData({String? orderByCountDone}) async {
    setState(() {
      _todos.clear();
      _isLoading = true;
    });
    _todos = await _todoService.getTodo(orderBy: orderByCountDone);
    _count = await _todoService.getCount();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  void _handleOrderByChanged(String orderBy) {
    setState(() {
      _todos.clear();
    });
    getData(orderByCountDone: orderBy);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardHome(data: _count),
            const SizedBox(
              height: 20,
            ),
            Search(orderBy: _handleOrderByChanged),
            const SizedBox(
              height: 20,
            ),
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    shrinkWrap: true,
                    itemCount: _todos.length,
                    itemBuilder: (context, index) {
                      if (_todos.isEmpty) {
                        return const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Data Kosong',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return ListTodo(todo: _todos[index], getData: getData);
                      }
                    },
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.blueGrey,
        onPressed: () async {
          String? result =
              await TodoDialogHelper.showTodoDialog(context, 'home');
          if (result == 'yes') {
            getData();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
