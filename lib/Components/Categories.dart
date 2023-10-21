import 'package:flutter/material.dart';

class Filters extends StatelessWidget {
  final String category;
  final int categoryId;
  const Filters({Key? key, required this.category, required this.categoryId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Colors.black12)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              category,
              style: TextStyle(fontFamily: "Comfortaa", color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
