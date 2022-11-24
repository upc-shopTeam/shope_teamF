import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_team/sales/list_sale.dart';
import 'package:shop_team/sales/products_view.dart';
import 'package:shop_team/sales/profile_employee.dart';
import '../sign-in/sign-in_view.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'sales_view.dart';
import 'package:http/http.dart' as http;


class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String employeeId = '';
  String name = '';
  String nameShop = '';
  @override
  void initState() {
    // TODO: implement initState
    getDataId();
    super.initState();
  }

  void getDataId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? val = preferences.getString("token");
    var id = '';
    var objEmployee = {};
    if (val != null) {
      Map<String, dynamic> payload = Jwt.parseJwt(val);
      id = payload["dataId"];
      final user = await http.get(Uri.parse("https://express-shopapi.herokuapp.com/api/employee/${payload["dataId"]}"));
      objEmployee = jsonDecode(user.body);
    }
    setState(() {
      name = objEmployee["name"];
      employeeId = id;

    });
    print(name);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("TRABAJADOR"),
        backgroundColor: Colors.green[600],
      ),
      backgroundColor: Colors.green[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white70,

                ),
                onPressed: ()  {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileEmployeeView(id : employeeId)));
                },
                icon:Icon(Icons.person,
                  color: Colors.black,),
                label: Text("Hola, $name",
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
              ),

              GridView.count(
                shrinkWrap: true,

                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  ElevatedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,

                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProductView(list: const <Item>[],),
                      ));
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children:
                          <Widget>[
                            Icon(Icons.photo_size_select_large,
                              size:70.0,
                              color: Colors.blueGrey,
                            ),
                            Text("Nueva Venta",
                              style: new TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ),
                  ElevatedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,

                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SalesView(),
                      ));
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(21.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children:
                          <Widget>[
                            Icon(Icons.list_alt,
                              size:70.0,
                              color: Colors.teal,
                            ),
                            Text("Ventas",
                              style: new TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ),
                ],
              ),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white70,

                ),
                onPressed: () async {
                  SharedPreferences preferences = await SharedPreferences.getInstance();
                  await preferences.clear();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>SignInView()), (route) => false);
                },
                icon:Icon(Icons.login,
                color: Colors.black,
                ),
                label: Text("Logout",
                style: TextStyle(
                  color: Colors.black
                ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
