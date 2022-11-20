import 'package:flutter/material.dart';
import 'package:shop_team/inventory/balance_view.dart';
import 'package:shop_team/inventory/invetory_view.dart';
import 'package:shop_team/inventory/sales_products_view.dart';
class HomeOwnerView extends StatelessWidget {
  const HomeOwnerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
                  builder: (context) => BalanceView(),
                ));
              },
              child: Text("Balance"),),
          ],
        ),),
    );
  }
}
