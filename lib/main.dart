import 'package:flutter/material.dart';
import 'package:shop_app/Pages/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'Home',
      routes: {
        'Home': (context) => const HomePage(),
      },
    );
  }
}
