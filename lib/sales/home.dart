import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:shop_team/sales/list_sale.dart';
import 'package:shop_team/sales/products_view.dart';
import '../login/authentication_repository.dart';
import 'package:flutter_meedu/router.dart' as router;
import '../login/routes.dart';
import 'sales_view.dart';
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

        body: SafeArea(
          child:GridView.count(
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
    );
  }
}
