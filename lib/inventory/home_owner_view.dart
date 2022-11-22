import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_team/inventory/balance_view.dart';
import 'package:shop_team/inventory/employee_register.dart';
import 'package:shop_team/inventory/invetory_view.dart';
import 'package:shop_team/inventory/profile_owner.dart';
import 'package:shop_team/inventory/sales_products_view.dart';
import 'package:shop_team/sign-in/sign-in_view.dart';
import 'package:http/http.dart' as http;
class HomeOwnerView extends StatefulWidget {
  const HomeOwnerView({Key? key}) : super(key: key);

  @override
  State<HomeOwnerView> createState() => _HomeOwnerViewState();
}

class _HomeOwnerViewState extends State<HomeOwnerView> {

  String token = '';
  DateTime initDate= DateTime.now();
  String name = '';
String nameShop = '';



  @override
  void initState() {
    // TODO: implement initState
    getCred();
    super.initState();
  }
  void getCred() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? val = preferences.getString("token");
    var objOwner = {};
    if(val!=null) {
      Map<String, dynamic> payload = Jwt.parseJwt(val);
      final user = await http.get(Uri.parse("https://express-shopapi.herokuapp.com/api/owner/${payload["dataId"]}"));

      objOwner = jsonDecode(user.body);
    }


    setState((){
      token = preferences.getString("token")!;
      initDate = DateTime.parse(objOwner["registerDate"]);
      name = objOwner["name"];
      nameShop = objOwner["nameShop"];
    });
    print(initDate);
    print(token);
    print(name);
    print(nameShop);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("HOME"),
        backgroundColor: Colors.green[600],
      ),
      backgroundColor: Colors.green[100],
      body: SafeArea(

        child:SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(


              children: [
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white70,

                  ),
                  onPressed: ()  {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileOwner()));
                  },
                  icon:Icon(Icons.person,
                  color: Colors.black,
                  ),
                  label: Text("Hola, $name",
                    style: TextStyle(
                        color: Colors.black,
                   ),
                ),
                ),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white70,

                  ),

                  onPressed: ()  {
                  },
                  icon:Icon(Icons.shop,
                    color: Colors.black,
                  ),
                  label: Text("TIENDA: $nameShop",style: TextStyle(
                    color: Colors.black
                  ),),
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
                          builder: (context) => InventoryView(),
                        ));
                      },

                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(21.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children:
                              <Widget>[
                                Icon(Icons.inventory_rounded,
                                    size:70.0,
                                   color: Colors.black,
                                ),
                                Text("Inventario",

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
                          builder: (context) => SalesProductsView(),
                        ));
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(21.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children:
                            <Widget>[
                              Icon(Icons.wine_bar,
                                size:70.0,
                                color: Colors.deepOrangeAccent,
                              ),
                              Text("Ventas por producto",
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
                          builder: (context) => BalanceView(initDate:initDate,),
                        ));
                      },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(21.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children:
                              <Widget>[
                                Icon(Icons.monetization_on,
                                  size:70.0,
                                  color: Colors.lightGreen,
                                ),
                                Text("Balance",
                                  style: new TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.black
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )


                    ),
                    ElevatedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,

                        ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EmployeeRegister(),
                        ));
                      },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(21.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children:
                              <Widget>[
                                Icon(Icons.emoji_people_rounded,
                                  size:70.0,
                                  color: Colors.brown,
                                ),
                                Text("Agregar Trabajador",
                                  style: new TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )

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
                    color: Colors.black,),
                    label: Text("Logout",style: TextStyle(
                      color: Colors.black
                    ),),
                )
              ],
            ),
          ),
        ),),
    );
  }
}

