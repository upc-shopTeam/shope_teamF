import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_team/inventory/home_owner_view.dart';
class EmployeeRegister extends StatefulWidget {
  const EmployeeRegister({Key? key}) : super(key: key);

  @override
  State<EmployeeRegister> createState() => _EmployeeRegisterState();
}

class _EmployeeRegisterState extends State<EmployeeRegister> {

  final txtName = TextEditingController();
  final txtHireDate = TextEditingController();
  final txtDNI = TextEditingController();
  final txtPhoneNumber = TextEditingController();
  final txtPhoto = TextEditingController();
  final txtEmail = TextEditingController();
  final txtPassword = TextEditingController();

  String name = '';
  String DNI ='';
  String phoneNumber = '';
  String photo ='';
  String email ='';
  String password ='';
  DateTime hireDate = DateTime.now();
String owner = '';
  void register() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? val = preferences.getString("token");
    var ownerId = '';
    if(val!=null) {
      Map<String, dynamic> payload = Jwt.parseJwt(val);
      ownerId=payload["dataId"];
    }
    setState(() {
      owner = ownerId;
    });
    print(owner);
    final user = {
      "name": name,
      "dni": DNI,
      "phoneNumber": phoneNumber,
      "photo": photo,
      "email": email,
      "password": password,
      "hireDate": hireDate.toString(),
      "owner":owner
    };

    final headers = {"Content-Type": "application/json;charset=UTF-8"};

    final res = await http.post(Uri.parse("https://express-shopapi.herokuapp.com/api/employee/sign-up"),
        headers: headers, body: jsonEncode(user));
    print(res);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro')
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(

            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: txtName,
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Nombre',
                    ),
                  ),
                  TextField(
                    controller: txtDNI,
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'DNI',
                    ),
                  ),
                  TextField(
                    controller: txtPhoneNumber,
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Numero de celular',
                    ),
                  ),

                  TextField(
                    controller: txtPhoto,
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Foto',

                    ),
                  ),
                  TextField(
                    controller: txtEmail,
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Correo',

                    ),
                  ),
                  TextField(
                    controller: txtPassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
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
                          photo=txtPhoto.text;
                          email= txtEmail.text;
                          password=txtPassword.text;
                        });
                        register();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                            content:
                            Text("Vendedor Registrado")));
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>HomeOwnerView()), (route) => false);

                      },
                      child: Text('Registrar vendedor'))
                ],
              ),
            )

        ),
      ),
    );
  }
}
