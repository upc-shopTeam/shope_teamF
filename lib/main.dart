import 'package:flutter/material.dart';
import 'package:shop_team/inventory/invetory_view.dart';
import 'package:shop_team/sign-in/sign-in_view.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: {
        '/inventory':(context) => const InventoryView(),


    },
        home: SignInView()

//      home: Home()


    );
  }
}



