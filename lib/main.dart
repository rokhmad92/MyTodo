import 'package:flutter/material.dart';
import 'package:project1/pages/home.dart';
import 'pages/intro.dart';
import 'global_variable.dart';

void main() async {
  String? token = await getToken();
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({Key? key, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
      ),
      home: token != null ? const Home() : const Intro(),
    );
  }
}
