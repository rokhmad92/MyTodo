import 'package:flutter/material.dart';
import '../global_variable.dart';
import '../models/todo_model.dart';
import '../pages/login.dart';
import '../services_Offline/todo_service.dart';
import '../services_Online/todo_service.dart';
import '../widgets/card_home.dart';
import '../widgets/dialog_create.dart';
import '../widgets/list_todo.dart';
import '../widgets/search.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<TodoModel> _todos = [];
  Map<String, dynamic> _count = {};
  final TodoService _todoServiceOnline = TodoService();
  final TodoServiceOffline _todoServiceOffline = TodoServiceOffline();
  bool _isLoading = false;
  late String? token = '';

  void getData({String keyword = '', String? orderByCountDone}) async {
    token = await getToken();

    setState(() {
      _todos.clear();
      _count.clear();
      _isLoading = true;
    });

    try {
      if (token == null) {
        Navigator.push(context,MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => );
      } else if (token != 'Offline') {
        _todos = await _todoServiceOnline.getTodo(
            keyword: keyword, orderBy: orderByCountDone);
        _count = await _todoServiceOnline.getCount();
      } else {
        await Future.delayed(const Duration(milliseconds: 100));
        _todos = await _todoServiceOffline.getTodo(
            keyword: keyword, orderBy: orderByCountDone);
        _count = await _todoServiceOffline.getCount();
        // print(_count);
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CardHome(data: _count, token: token),
            const SizedBox(height: 20),
            Search(
              orderBy: _handleOrderByChanged,
              search: (keyword) => getData(keyword: keyword),
              token: token,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _todos.isEmpty
                    ? const Center(
                        child: Text(
                          'Data Kosong',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _todos.length,
                        itemBuilder: (context, index) {
                          return ListTodo(
                            todo: _todos[index],
                            getData: getData,
                            token: token,
                          );
                        },
                      ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.blueGrey[100],
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
