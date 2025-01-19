import 'package:flutter/material.dart';
import 'package:myfirstapp/models/category_model.dart';
import 'package:provider/provider.dart';
import 'package:myfirstapp/page/welcome_page.dart';
import 'package:myfirstapp/models/stock.dart';
import 'package:myfirstapp/models/cart.dart';
import 'package:myfirstapp/models/favorite_manager.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryModel()),
        ChangeNotifierProvider(create: (_) => Stock()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => FavoriteManager()), // เพิ่ม FavoriteManager
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WelcomePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
    );
  }
}