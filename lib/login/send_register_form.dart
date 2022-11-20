import 'package:flutter/material.dart';
import 'package:shop_team/login/sign_up.dart';
import 'package:shop_team/login/progress_dialog.dart';
import 'package:shop_team/login/routes.dart';
import 'dialogs.dart';
import 'register_page.dart' show registerProvider;
import 'package:flutter_meedu/router.dart' as router;

Future<void>sendRegisterForm(BuildContext context) async{

  final controller = registerProvider.read;
  final isValidForm= controller.formkey.currentState!.validate();

  if(isValidForm){
    ProgressDialog.show(context);
     final response =  await controller.submit();
     router.pop();

     if(response.error != null) {

       late String content ;
       switch(response.error){

         case SignUpError.emailAlreadyInUse:
           content="email ya esta en uso";
           break;
         case SignUpError.weakPassword:
           content="contrasenia debil";
           break;

         case SignUpError.unknown:
         default:
           content="error desconocido";
           break;
       }

       Dialogs.alert(
           context,
           title:"ERROR",
         content: content,
       );
     }else{
        router.pushNamedAndRemoveUntil(
            Routes.HOME,
        );

     }
  }else{
    Dialogs.alert(context,
    title:"ERROR",
      content:"Invalid fields",
    );
  }
}