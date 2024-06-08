import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/intro.dart';
import 'global_variable.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  String? token = await getToken();

  // splah screen
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(seconds: 4));
  FlutterNativeSplash.remove();

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
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(76, 175, 80, 1)),
      ),
      home: token != null ? const Home() : const Intro(),
    );
  }
}
