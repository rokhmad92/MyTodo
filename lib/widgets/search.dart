import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final Function(String) orderBy;
  final Function(String) search;
  final String? token;
  const Search(
      {Key? key,
      required this.orderBy,
      required this.search,
      required this.token})
      : super(key: key);

  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> {
  String orderByValue = 'desc';
  late String searchText = '';

  @override
  void initState() {
    super.initState();
  }

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
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
                widget.search(value);
              },
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
        if (widget.token != 'Offline')
          Padding(
            padding: EdgeInsets.only(right: deviceWidth * 0.05),
            child: IconButton(
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
