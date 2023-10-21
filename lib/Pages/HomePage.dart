import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Backend/ShopData.dart';
import 'package:shop_app/Components/Categories.dart';

import '../Components/ProductCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

List<Widget> AvailableProductList = [];
Map<String, int> Categories = {};
List<Widget> CategoryList = [];

class _HomePageState extends State<HomePage> {
  void getProduct(BuildContext context) async {
    var dataDecoded = await ShopData().getAvailableProducts();
    CreateCard(dataDecoded);
  }

  @override
  void initState() {
    super.initState();
    getProduct(context);
  }

  void initializeCategoryList() {
    CategoryList = Categories.keys.map((categoryName) {
      return Filters(
        category: categoryName,
        categoryId: Categories[categoryName]!,
      );
    }).toList();
  }

  void CreateCard(dynamic data) {
    if (data != null) {
      List<Widget> productList = [];
      Categories = {'All Categories': 0}; // Initialize with 'All Categories'

      for (var listing in data) {
        var id = listing['id'];
        var picUrl = listing['images'][0];
        var description = listing['description'];
        var price = listing['price'].toInt();
        var title = listing['title'];
        var category = listing['category']['name'];
        var categoryId = listing['category']['id'];

        // Add the category if it doesn't exist in the map
        if (!Categories.containsKey(category)) {
          Categories[category] = categoryId;
        }

        productList.add(
          Product(
            id: id,
            picUrl: picUrl,
            desctiption: description,
            price: price,
            title: title,
            data: data,
          ),
        );
      }

      setState(() {
        AvailableProductList = productList;
      });

      initializeCategoryList();
    } else {
      print('data is empty');
    }
  }

  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120.0,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: CircleAvatar(
          minRadius: 10.0,
          maxRadius: 10.0,
          child: Image.asset(
            'assets/user_male.png',
            height: 40.0,
            width: 40.0,
          ),
          backgroundColor: Colors.transparent,
        ),
        title: Column(
          children: [
            Text(
              "Hey,",
              style: TextStyle(color: Colors.black38, fontFamily: "Comfortaa,"),
            ),
            Text(
              "User",
              style: TextStyle(color: Colors.black, fontFamily: "Comfortaa,"),
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              CupertinoIcons.bell_fill,
              size: 20.0,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.menu_rounded,
              size: 25.0,
              color: Colors.black,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.square(5.0),
          child: Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Center(
              // Wrap the TextFormField in a Center widget
              child: Container(
                height: 40.0,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.black12,
                ),
                child: TextFormField(
                  controller: search,
                  onTap: () {},
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefix: SizedBox(
                      width: 10.0,
                    ),
                    icon: Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                      ),
                      child: Icon(
                        CupertinoIcons.search,
                        size: 20.0,
                      ),
                    ),

                    hintText: "Search for brand",
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontFamily: "Comfortaa",
                    ),
                    // Center-align the text within the input field
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        // Changed SingleChildScrollView to Column
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 18.0, top: 15.0),
            child: Text(
              "Buy Top Brands",
              style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: "Comfortaa",
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            height: 55.0,
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: CategoryList,
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 18.0, right: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "New Arrivals",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Comfortaa",
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Show all",
                    style: TextStyle(
                      fontFamily: "Comfortaa",
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: GridView.count(
                crossAxisCount: 2,
                children: AvailableProductList,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
