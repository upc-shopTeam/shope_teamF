
import 'package:shop_team/login/sign_up.dart';

import 'package:shop_team/login/sign_up_repository.dart';
import 'package:shop_team/login/register_state.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter/widgets.dart';

class RegisterController extends  StateNotifier<RegisterState>{
  RegisterController() : super(RegisterState.initialState);
  final GlobalKey<FormState> formkey = GlobalKey();
 final _signUpRepository = Get.i.find<SignUpRepository>();

  Future<SignUpResponse> submit(){
  return _signUpRepository.register(
     SignUpData(
     name:state.name,
     lastname:state.lastname,
     email:state.email,
     password:state.password
   ),
   );
  }

  void onNameChanged(String text){
    state = state.copyWith(name: text);
  }

  void onLastNameChanged(String text){
    state = state.copyWith(lastname: text);
  }

  void onEmailChanged(String text){
    state = state.copyWith(email: text);
  }

  void onPasswordChanged(String text){
    state = state.copyWith(password: text);
  }

  void onVPasswordChanged(String text){
    state = state.copyWith(vPassword: text);
  }


}