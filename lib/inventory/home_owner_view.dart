import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_team/inventory/balance_view.dart';
import 'package:shop_team/inventory/invetory_view.dart';
import 'package:shop_team/inventory/sales_products_view.dart';
import 'package:shop_team/sign-in/sign-in_view.dart';

class HomeOwnerView extends StatefulWidget {
  const HomeOwnerView({Key? key}) : super(key: key);

  @override
  State<HomeOwnerView> createState() => _HomeOwnerViewState();
}

class _HomeOwnerViewState extends State<HomeOwnerView> {

  String token = '';


  @override
  void initState() {
    // TODO: implement initState
    getCred();
    super.initState();
  }
  void getCred() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState((){
      token = preferences.getString("token")!;
    });
    print(token);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child:SingleChildScrollView(
          child: Column(
            children: [
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
                        builder: (context) => BalanceView(),
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



