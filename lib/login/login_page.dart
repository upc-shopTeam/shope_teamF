import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:shop_team/login/login_controller.dart';
import 'package:shop_team/login/send_login_form.dart';
import 'custom_input_field.dart';
import 'email_validator.dart';
import 'routes.dart';

final loginProvider = SimpleProvider(
    (_)=> LoginController(),
);


class LoginPage extends StatelessWidget {
    LoginPage({Key? key}) : super(key: key);

  final _controller = loginProvider.read;

  @override
  Widget build(BuildContext context) {
   return  ProviderListener<LoginController>(
      provider: loginProvider,
      builder: (_, controller){

        return Scaffold(
          body: SafeArea(
            child: GestureDetector(
              onTap: ()=>FocusScope.of(context).unfocus(),
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomInputField(label:"Email",
                        onChanged: controller.onEmailChanged,
                        inputType: TextInputType.emailAddress,
                        validator: (text){
                         if(isValidEmail(text!)){
                            return null;
                          }
                         return "Invalid email";
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomInputField(label:"Password",
                        onChanged: _controller.onPasswordChanged,
                        isPassword: true,
                        validator: (text){
                        if(text!.trim().length>=6){
                          return null;
                        }
                        return "Invalid Password";
                        },
                      ),

                      const SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: ()=> sendLoginForm(context),
                        child: const Text("Sign In"),
                      ),
                      const SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: () => router.pushNamed(
                          Routes.REGISTER,
                        ),
                        child: const Text("Sign Up"),
                      )
                    ],
                  ),
                ),

              ),
            ),
          ),
        );
      },
    );


  }
}
