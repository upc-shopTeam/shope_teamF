import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../sign-in/sign-in_view.dart';
class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {

    final txtName = TextEditingController();
   final txtDNI = TextEditingController();
   final txtPhoneNumber = TextEditingController();
   final txtNameShop = TextEditingController();
   final txtPhoto = TextEditingController();
   final txtEmail = TextEditingController();
   final txtPassword = TextEditingController();
   final txtConfirmPassword = TextEditingController();


    String name = '';
    String DNI ='';
    String phoneNumber = '';
    String nameShop ='';
    String photo ='';
    String email ='';
    String password ='';
    String confirmPassword = '';
    DateTime date = DateTime.now();

    void register() async {
      final user = {
        "name": name,
        "dni": DNI,
        "phoneNumber": phoneNumber,
        "nameShop": nameShop,
        "photo": photo,
        "email": email,
        "password": password,
        "registerDate": date.toString()
      };

      final headers = {"Content-Type": "application/json;charset=UTF-8"};

      final res = await http.post(Uri.parse("https://express-shopapi.herokuapp.com/api/owner/sign-up"),
          headers: headers, body: jsonEncode(user));
      print(res);

    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true ,
        title:  Text('Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(

            child: SingleChildScrollView(

                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),


                    TextField(
                      controller: txtName,
                      obscureText: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nombre',
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    TextField(
                      controller: txtDNI,
                      obscureText: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'DNI',
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    TextField(
                      controller: txtPhoneNumber,
                      obscureText: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Numero de Celular',
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    TextField(
                      controller: txtNameShop,
                      obscureText: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nombre de Tienda',
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    TextField(
                      controller: txtPhoto,
                      obscureText: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Foto',

                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    TextField(
                      controller: txtEmail,
                      obscureText: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Correo',

                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    TextField(
                      controller: txtPassword,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Contraseña',
                      ),
                    ),

                    SizedBox(
                      height: 35,
                    ),
                    ElevatedButton(
                        onPressed: (){
                          setState(() {
                            name = txtName.text;
                             DNI=txtDNI.text ;
                            phoneNumber=txtPhoneNumber.text;
                            nameShop = txtNameShop.text;
                            photo=txtPhoto.text;
                            email= txtEmail.text;
                            password=txtPassword.text;
                          });
                          register();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                              content:
                              Text("Registrado")));
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>SignInView()), (route) => false);

                        },
                        child: Text('Registrarse'))
                  ],
                ),

            )

        ),
      ),
    );
  }
}



