import 'package:flutter/material.dart';
import 'package:project1/pages/login.dart';
import 'package:project1/services_Offline/auth_service.dart';
import 'package:project1/services_Online/auth_service.dart';

class CardHome extends StatefulWidget {
  const CardHome({Key? key, required this.data, required this.token})
      : super(key: key);
  final Map<String, dynamic> data;
  final String? token;

  @override
  State<CardHome> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CardHome> {
  final AuthService authService = AuthService();
  final AuthServiceOffline authServiceOffline = AuthServiceOffline();

  void logOut() async {
    var logout = widget.token == 'Offline'
        ? await authServiceOffline.logout()
        : await authService.logout();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(logout['message'].toString()),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35)),
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(56, 142, 60, 1), // Warna hijau tua
            Color.fromRGBO(76, 175, 80, 1), // Warna hijau yang lebih terang
            Color.fromRGBO(98, 226, 105, 1), // Warna hijau muda
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.5, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // IconButton(
              //   onPressed: () {},
              //   icon: const Icon(
              //     Icons.calendar_month,
              //     color: Colors.white,
              //   ),
              // ),
              const SizedBox(width: 20),
              const Text(
                'To Do List',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
              IconButton(
                onPressed: () async {
                  logOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                splashRadius: 25,
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
              // SizedBox(width: 48),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    widget.data['total'] != null
                        ? widget.data['total'].toString()
                        : '0',
                    style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text(
                    'Total',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    widget.data['done'] != null
                        ? widget.data['done'].toString()
                        : '0',
                    style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text(
                    'Selesai',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    widget.data['proses'] != null
                        ? widget.data['proses'].toString()
                        : '0',
                    style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text(
                    'Proses',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
