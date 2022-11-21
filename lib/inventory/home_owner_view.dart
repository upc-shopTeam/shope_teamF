import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_team/inventory/balance_view.dart';
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
    });
    print(initDate);
    print(token);
    print(name);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child:SingleChildScrollView(
          child: Column(
            children: [
              OutlinedButton.icon(
                onPressed: ()  {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileOwner()));
                },
                icon:Icon(Icons.person),
                label: Text("Hola: $name"),
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
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => InventoryView(),
                      ));
                    },
                    child: Text("Inventario"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SalesProductsView(),
                      ));
                    },
                    child: Text("Ventas por producto"),),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BalanceView(initDate:initDate,),
                      ));
                    },
                    child: Text("Balance"),),
                ],
              ),
              OutlinedButton.icon(
                  onPressed: () async {
                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      await preferences.clear();
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>SignInView()), (route) => false);
                  },
                  icon:Icon(Icons.login),
                  label: Text("Logout"),
              )
            ],
          ),
        ),),
    );
  }
}



