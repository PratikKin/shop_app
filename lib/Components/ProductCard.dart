import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Pages/ProductPage.dart';

class Product extends StatelessWidget {
  final int id;
  final String picUrl;
  final String desctiption;
  final int price;
  final String title;
  final dynamic data;

  Product({
    required this.id,
    required this.picUrl,
    required this.desctiption,
    required this.price,
    required this.title,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProductPage(id, data)));
      },
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            15.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Container(
                  height: 110.0,
                  width: 140.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                        image: NetworkImage(
                          picUrl,
                        ),
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              Text(
                title,
                style: TextStyle(
                    fontFamily: "Comfortaa", fontWeight: FontWeight.w800),
              ),
              Text(
                desctiption.length > 25
                    ? '${desctiption.substring(0, 25)}...'
                    : desctiption,
                style: TextStyle(fontSize: 10.0, fontFamily: "Comfortaa"),
                maxLines: 1, // Limit the text to a single line
                overflow:
                    TextOverflow.ellipsis, // Show ellipsis (...) for overflow
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$ $price',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: "Comfortaa"),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.plus_app_fill,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
