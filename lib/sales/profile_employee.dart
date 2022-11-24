import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class ProfileEmployeeView extends StatefulWidget {
  String id;
  ProfileEmployeeView({required this.id});
  @override
  State<ProfileEmployeeView> createState() => _ProfileEmployeeViewState();
}

class _ProfileEmployeeViewState extends State<ProfileEmployeeView> {
  String name = '';
  String email = '';
  String photo = '';
  String hireDate = '';
  String DNI = '';
  String phoneNumber = '';
  @override
  void initState() {
    // TODO: implement initState
    getDataEmployee();
    super.initState();
  }
  void getDataEmployee() async{
    final res = await http.get(Uri.parse("https://express-shopapi.herokuapp.com/api/employee/${widget.id}")); //text
    var obj = jsonDecode(res.body);
    setState(() {
      name = obj["name"];
      email = obj["email"];
      photo = obj["photo"];
      hireDate = obj["hireDate"];
      DNI = obj["dni"];
      phoneNumber = obj["phoneNumber"];
    });
    print(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage('$photo'),
                radius: 100,
              ),
              SizedBox(
                height: 10,
              ),
              Text('${name}',
                style: TextStyle(

                  fontSize: 30,
                  fontWeight:  FontWeight.bold,
                ),
              ),

             
              SizedBox(
                height: 5,
              ),
              //FILA 2



                  Row(

                    children: [
                      Container(
                        width: 100,
                        child: Text('Email: ', style: TextStyle(color: Colors.green,
                            fontSize: 20, fontWeight: FontWeight.bold),),
                      ),

                      Text('$email', style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),)

                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
//FILA 3
                  Row(
                    children: [
                      Container(
                        width: 100,
                        child: Text('Celular: ', style: TextStyle(color: Colors.green,
                            fontSize: 20, fontWeight: FontWeight.bold),),
                      ),

                      Text('$phoneNumber', style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),)

                    ],
                  ),

                  SizedBox(
                    height: 5,
                  ),
//FILA 4
                  Row(
                    children: [
                      Container(
                        width: 100,
                        child: Text('DNI: ', style: TextStyle(color: Colors.green,
                            fontSize: 20, fontWeight: FontWeight.bold),),
                      ),

                      Text('$DNI', style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),)

                    ],
                  ),

                  SizedBox(
                    height: 5,
                  ),
                  //FILA 5
                  Row(
                    children: [
                      Container(
                        width: 100,
                        child: Text('Fecha de contrato: ', style: TextStyle(color: Colors.green,
                            fontSize: 20, fontWeight: FontWeight.bold),),
                      ),

                      Text('${hireDate}', style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),)

                    ],
                  ),
                ],
              ),

      ),

    );
  }
}

