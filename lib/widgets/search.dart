import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final Function(String) orderBy;
  const Search({Key? key, required this.orderBy}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String orderByValue = 'desc';

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: deviceWidth * 0.05,
              right: deviceWidth * 0.03,
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Search',
                hintText: 'Ketik apa yang anda cari',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 15,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: deviceWidth * 0.05),
          child: IconButton(
            hoverColor: Colors.white,
            splashRadius: 25,
            onPressed: () {
              setState(() {
                orderByValue = orderByValue == 'asc' ? 'desc' : 'asc';
              });
              // panggil atau beritahu ke parent bahwa ada perubahan di onOrderByChanged
              widget.orderBy(orderByValue);
            },
            icon: const Icon(Icons.filter_list),
          ),
        ),
      ],
    );
  }
}
