import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
                left: deviceWidth * 0.05, right: deviceWidth * 0.03),
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
                onPressed: () {},
                icon: const Icon(Icons.filter_list)))
      ],
    );
  }
}
