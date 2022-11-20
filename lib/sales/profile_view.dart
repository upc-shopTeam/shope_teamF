import 'package:flutter/material.dart';
import 'dart:convert';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.lightBlue,
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
                backgroundImage: AssetImage(''),
                radius: 100,
              ),
              SizedBox(
                height: 10,
              ),
              Text('Luis ',
                style: TextStyle(
                  color: Colors.indigoAccent,
                  fontSize: 30,
                  fontWeight:  FontWeight.bold,
                ),
              ),

              Text('Gutierrez',
                style: TextStyle(
                  color: Colors.indigoAccent,
                  fontSize: 30,
                  fontWeight:  FontWeight.bold,
                ),
              ),

              SizedBox(
                height: 20,
              ),
//FILA 1
              Row(
                children: [
                  Container(
                    width: 100,
                    child: Text('Rol: ', style: TextStyle(color: Colors.lightBlue,
                        fontSize: 20, fontWeight: FontWeight.bold),),
                  ),

                  Text('AQUI VA LA INFORMACION', style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),)

                ],
              ),
              SizedBox(
                height: 5,
              ),
              //FILA 2


              Row(
                children: [
                  Container(
                    width: 100,
                    child: Text('Email: ', style: TextStyle(color: Colors.lightBlue,
                        fontSize: 20, fontWeight: FontWeight.bold),),
                  ),

                  Text('AQUI VA LA INFORMACION', style: TextStyle(
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
                    child: Text('Telefono: ', style: TextStyle(color: Colors.lightBlue,
                        fontSize: 20, fontWeight: FontWeight.bold),),
                  ),

                  Text('AQUI VA LA INFORMACION', style: TextStyle(
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
                    child: Text('DNI: ', style: TextStyle(color: Colors.lightBlue,
                        fontSize: 20, fontWeight: FontWeight.bold),),
                  ),

                  Text('AQUI VA LA INFORMACION', style: TextStyle(
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
                    child: Text('Date: ', style: TextStyle(color: Colors.lightBlue,
                        fontSize: 20, fontWeight: FontWeight.bold),),
                  ),

                  Text('AQUI VA LA INFORMACION', style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),)

                ],
              ),






            ]

        ),
      ),



    );
  }
}
