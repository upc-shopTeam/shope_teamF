import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_team/login/register_controller.dart';
import 'package:shop_team/login/send_register_form.dart';
import 'package:shop_team/login/email_validator.dart';
import 'package:shop_team/login/name_validator.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'custom_input_field.dart';
import 'register_state.dart';

final registerProvider = StateProvider<RegisterController,RegisterState>(
    (_)=> RegisterController(),
);




class RegisterPage extends StatelessWidget {
   const RegisterPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
   return ProviderListener<RegisterController>(
      provider: registerProvider,
      builder: (_,controller){
        return Scaffold(
          appBar: AppBar(),
          body: GestureDetector(
            onTap: ()=>FocusScope.of(context).unfocus(),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,


                child: Form(
                  key: controller.formkey ,
                  child:ListView(
                    padding: const EdgeInsets.all(12),
                    children: [
                      CustomInputField(
                        label: "Name",
                        onChanged: controller.onNameChanged,
                        validator: (text){

                          return isValidName(text!)?null: "invalid name";                      return "invalid email";
                        },
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      CustomInputField(
                        label: "Last Name",
                        onChanged: controller.onLastNameChanged,
                        validator: (text){

                          return isValidName(text!)?null: "invalid lastname";                      return "invalid email";
                        },
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      CustomInputField(
                        label: "E-mail",
                        inputType: TextInputType.emailAddress,
                        onChanged: controller.onEmailChanged,
                        validator: (text){


                          return isValidEmail(text!)?null: "invalid email";                      return "invalid email";
                        },
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      CustomInputField(
                        label: "Password",
                        onChanged: controller.onPasswordChanged,
                        isPassword: true,
                        validator: (text){

                          if(text!.trim().length>=6){
                            return null;
                          }
                          return "invalid password";
                        },
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      Consumer(
                        builder: (_,watch,__){
                         // watch(registerProvider.select((_) => _.password));


                          return CustomInputField(
                            label: "Verification Password",
                            onChanged: controller.onVPasswordChanged,
                            isPassword: true,
                            validator: (text){

                              if(controller.state.password!=text){
                                return "Passwors dont match";
                              }
                              if(text!.trim().length>=6){
                                return null;
                              }
                              return "invalid password";
                            },
                          );
                        },
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      CupertinoButton(
                        child: Text("REGISTER"),
                        color: Colors.blue,
                        onPressed: () => sendRegisterForm(context),
                      ),

                    ],
                  ),
                  ) ,


            ),
          ),
        );
      } ,
    );
  }
}
