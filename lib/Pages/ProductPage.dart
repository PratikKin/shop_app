import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final int id;
  final dynamic data;

  ProductPage(this.id, this.data, {Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<String> images = [];
  String description = "";
  String title = "";
  int price = 0; // Changed to int
  int _currentIndex = 0;
  bool isClicked = false;
  CarouselController buttonCarouselController = CarouselController();

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    setState(() {
      _currentIndex = index;
    });
  }

  void getData() {
    if (widget.data != null) {
      images =
          widget.data[widget.id]['images'].cast<String>(); // Cast to String
      title = widget.data[widget.id]['title'];
      description = widget.data[widget.id]['description'].toString();
      price = widget.data[widget.id]['price'];
    } else {
      print('data is empty');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
        ),
        title: Center(
            child: Text(
          "Details",
          style: TextStyle(
              color: Colors.black,
              fontFamily: "Comfortaa",
              fontWeight: FontWeight.bold),
        )),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isClicked = !isClicked;
              });
            },
            icon: Icon(
              isClicked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
              color: isClicked ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 400,
                aspectRatio: 60 / 21,
                viewportFraction: 0.9,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                onPageChanged: onPageChanged,
                scrollDirection: Axis.horizontal, // Change to horizontal
              ),
              items: images.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.amber,
                        image: DecorationImage(
                          image: NetworkImage(i), // Load image from URL
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            // Display other details like title, description, and price here
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: "Comfortaa",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$ $price',
                  style: TextStyle(
                    fontFamily: "Comfortaa",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              description,
              style: TextStyle(
                fontFamily: "Comfortaa",
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
