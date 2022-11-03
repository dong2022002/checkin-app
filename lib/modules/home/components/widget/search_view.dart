import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({
    Key? key,
    required this.onPress,
  }) : super(key: key);

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.05,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
          )
        ],
      ),
      child: Row(
        children: [
          IconButton(onPressed: onPress, icon: const Icon(Icons.search)),
          SizedBox(
            width: size.width * 0.5,
            child: const TextField(
              decoration: InputDecoration(
                  hintText: "Tìm kiếm", border: InputBorder.none),
            ),
          )
        ],
      ),
    );
  }
}
