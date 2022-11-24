import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shop_team/inventory/home_owner_view.dart';
import 'package:shop_team/sign-up/sign-up_view.dart';

import '../sales/home.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final txtEmail = TextEditingController();
  final txtPassword = TextEditingController();
  String email = '';
  String password = '';

String userInfo = '';
  String role = '';
  String dataId = '';
  @override
  void initState() {
    // TODO: implement initState
    checkLogin();
    super.initState();
  }

void checkLogin() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? val = preferences.getString("token");
  if(val!=null){
    Map<String, dynamic> payload = Jwt.parseJwt(val);
    if(payload["role"]=='owner'){
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context)=>HomeOwnerView()),
              (route) => false);
    }
    if(payload["role"]=='employee'){
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context)=>HomeView()),
              (route) => false);
    }


  }
}
  void login() async{
    if( txtEmail.text.isNotEmpty && txtPassword.text.isNotEmpty){
      final headers = {"Content-Type": "application/json;charset=UTF-8"};
      final data = {
        "email": txtEmail.text,
        "password": txtPassword.text
      };
      final res = await http.post(Uri.parse("https://express-shopapi.herokuapp.com/api/auth/sign-in"),
          headers: headers, body: jsonEncode(data));
      if(res.statusCode==200){
        final body = jsonDecode(res.body);
        print("Token "+body["token"]);
        pageRute(body["token"]);
       /* SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString("token", body["token"]);
*/
      }else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(
            content:
            Text("Correo o Contraseña incorrectos")));
      }

    }else{
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
          content:
          Text('Valores incompletos')));
    }
  }
  void pageRute(String token) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("token",token );

    Map<String, dynamic> payload = Jwt.parseJwt(token);

    if(payload["role"] == 'owner'){
      Navigator.push(
          context,MaterialPageRoute(builder: (context) => HomeOwnerView()));

    }
    if(payload["role"] == 'employee'){
      Navigator.push(
          context,MaterialPageRoute(builder: (context) => HomeView()));
    }
    }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.green[100],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text('SHOP TEAM',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.green[700]
                    ),),
                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 170,
                            width: 170,
                            child: Image.asset('images/logo.png'),
                          )
                        ],
                      )
                    ),


                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: txtEmail,
                            obscureText: false,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Nombre',
                            ),
                          ),
                          TextField(
                            controller: txtPassword,
                            obscureText: true,
                              decoration: const InputDecoration(

                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red
                                  )
                                ),
                                labelText: 'Contraseña',
                              )
                            ),
                        ],
                      ),
                    ),


                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.green[700],

                    ),onPressed: (){
                      login();
                      /*setState(() {
                        email = txtEmail.text;
                        password = txtPassword.text;
                        //login();
                       print(userInfo);
                        var obj = jsonDecode(userInfo);
                        role = obj["user"]["role"];
                        dataId = obj["user"]["dataId"];
                        if(role == 'owner'){
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomeOwnerView(role: role, dataId: dataId),
                          ));
                        }
                        if (role == 'employee'){
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Home(role: role, dataId: dataId),
                          ));
                        }
                      });*/

                      //txtPassword.clear();
                     // txtEmail.clear();



                    }, child: Text('Iniciar Sesión')),

                    SizedBox(
                      height: 10,
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color:   Color.fromARGB(100, 22, 44, 33),

                      ),

                      child: Column(

                        children: [Text(
                          '¿Todavía no tienes una cuenta?',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                          TextButton(
                              onPressed: (){
                                Navigator.push(
                                    context,MaterialPageRoute(builder: (context) => SignUpView()));
                              },
                              child: Text('Regístrate',style: TextStyle(
                                  color: Colors.green[700],
                                  fontWeight: FontWeight.bold
                              ),)),

                        ],
                      ),
                    ),
                  ],
              ),
            ),

          ),
        ),
    );
  }
}
