import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_team/sales/list_sale.dart';
import 'package:shop_team/sales/products_view.dart';
import '../sign-in/sign-in_view.dart';

import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:shop_team/sales/list_sale.dart';
import 'package:shop_team/sales/products_view.dart';
import '../login/authentication_repository.dart';
import 'package:flutter_meedu/router.dart' as router;
import '../login/routes.dart';
import 'sales_view.dart';
class Home extends StatelessWidget {
//String dataId;
//String role;
Home();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

        body: Column(
          children: [
            SafeArea(
              child:GridView.count(
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
                builder: (context) => ProductView(list: const <Item>[],),
              ));
            },
            child: Text("Nueva venta"),
      ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SalesView(),
                ));
              },
              child: Text("Ventas"),),

        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SalesView(),
            ));
          },
          child: Text("Ventas"),),

      CupertinoButton(
        color: Colors.blue,
        child: Text("sign out"),
        onPressed: () async{
          await  Get.i.find<AuthenticationRepository>().signOut();
          router.pushNamedAndRemoveUntil(Routes.LOGIN);
        },
      ),
    ],
    ),),
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
    );
  }
}
