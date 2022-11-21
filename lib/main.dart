import 'package:flutter/material.dart';
import 'package:shop_team/inventory/home_owner_view.dart';
import 'package:shop_team/inventory/invetory_view.dart';

import 'package:shop_team/sign-in/sign-in_view.dart';
import 'package:shop_team/sign-up/sign-up_view.dart';

import 'package:shop_team/login/inject_dependencies.dart';
import 'my_app.dart';
import 'sales/home.dart';
import 'package:firebase_core/firebase_core.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/inventory':(context) => const InventoryView(),


    },
        home: SignInView()

//      home: Home()


    );
  }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  injectDependecies();
  runApp(
      const MyApp()
  );
}

