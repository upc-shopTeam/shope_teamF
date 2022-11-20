import 'package:flutter/widgets.dart' show BuildContext, Container, Widget;
import 'package:shop_team/login/home_page.dart';
import 'package:shop_team/login/login_page.dart';
import 'package:shop_team/login/register_page.dart';
import 'package:shop_team/login/splash_page.dart';
import 'package:shop_team/sales/home.dart';
import 'routes.dart';

Map<String, Widget Function(BuildContext)>get appRoutes => {
  Routes.SPLASH:(_) =>const SplashPage(),
  Routes.LOGIN:(_)=>  LoginPage(),
  Routes.HOME:(_)=> const Home(),
  Routes.REGISTER:(_)=> const RegisterPage(),
};

