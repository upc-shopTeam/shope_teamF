import 'package:shop_team/login/authentication_repository.dart';
import 'package:flutter_meedu/meedu.dart';
import 'routes.dart';

class SplashController extends SimpleNotifier{
 final _authRepository = Get.i.find<AuthenticationRepository>();

 String? _routeName;
 String? get routeName=> _routeName;


 SplashController(){
   _init();
 }


 void _init( ) async {
   final user = await _authRepository.user;
   _routeName = user != null ? Routes.HOME : Routes.LOGIN;
   notify();

 }



}