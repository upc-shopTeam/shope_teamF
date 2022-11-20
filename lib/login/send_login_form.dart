

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_team/login/routes.dart';
import 'authentication_repository.dart';
import 'dialogs.dart';
import 'package:shop_team/login/progress_dialog.dart';
import 'login_page.dart' show loginProvider;
import 'package:flutter_meedu/router.dart' as router;


Future<void> sendLoginForm(BuildContext context)async{
final controller = loginProvider.read;
final isValidForm= controller.formKey.currentState!.validate();
if(isValidForm){
  ProgressDialog.show(context);
 final response = await controller.submit();
 router.pop();
 if(response.error != null){
   String errorMessage="";

   switch(response.error){

     case SignInError.networkRequestFailed:
       errorMessage=" network Reques tFailed";
       break;
     case SignInError.userDisabled:
       errorMessage=" user Disabled";
       break;
     case SignInError.userNotFound:
       errorMessage=" user Not Found";
       break;
     case SignInError.wrongPassword:
       errorMessage=" wrong Password";
       break;
     case SignInError.unknown:
     default:
       errorMessage=" unknown error";
       break;
   }

   Dialogs.alert(
     context,
       title:"ERROR",
     content: errorMessage,
   );
 }else {
 router.pushReplacementNamed(
  Routes.HOME,
);
 }
 }
}
