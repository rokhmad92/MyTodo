import 'package:flutter/material.dart';

class CardHome extends StatelessWidget {
  const CardHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35)),
        gradient: LinearGradient(
          colors: [
            Color(0xFF9CCC65), // Warna hijau muda 1
            Color(0xFF8BC34A), // Warna hijau muda 2
            Color(0xFF7CB342), // Warna merah Instagram
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
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  )),
              const Text(
                'To Do List',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    '5',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Total',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    '2',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Selesai',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    '3',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Proses',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w300,
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
