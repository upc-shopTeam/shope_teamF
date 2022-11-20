import 'package:flutter/material.dart';
import 'package:shop_team/login/inject_dependencies.dart';

import 'my_app.dart';
import 'sales/home.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  injectDependecies();
  runApp(
      const MyApp()
  );
}

