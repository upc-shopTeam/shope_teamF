
import 'package:flutter/widgets.dart' show FormState,GlobalKey;
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:shop_team/login/authentication_repository.dart';

class LoginController extends SimpleNotifier{
  String _email='',_password='';
  final _authenticationRepository= Get.i.find<AuthenticationRepository>();

  final GlobalKey<FormState> formKey=GlobalKey();

  void onEmailChanged(String text){
    _email=text;
  }

  void onPasswordChanged(String text){
    _password= text;
  }

  Future<SignInResponse> submit(){
   return _authenticationRepository.signInWithEmailAndPassword(
       _email,
       _password,
   );
  }



}