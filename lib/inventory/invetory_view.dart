import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_team/api/sale.dart';

import 'package:flutter/material.dart';
import 'package:shop_team/api/product.dart';
import 'package:shop_team/inventory/product_detail_view.dart';

class InventoryView extends StatefulWidget {
  const InventoryView({Key? key}) : super(key: key);

  @override
  State<InventoryView> createState() => _InventoryViewState();


}

int totalVendido = 0;

class _InventoryViewState extends State<InventoryView> {
  static late Future<List<Product>> products;
  static late Future<List<Sale>> sales;

  final headers = {"Content-Type": "application/json;charset=UTF-8"};
  //final url = Uri.parse("https://express-shopapi.herokuapp.com/api/products");


  @override
  void initState() {
    // TODO: implement initState
        products = getProducts();
       // sales = getSales();

        totalVendido = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario'),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Product>>(
            future: products,
            builder: (context, snap) {

              if (snap.hasData) {

                return ListView.builder(

                    itemCount: snap.data!.length,
                    itemBuilder: (context, index) {

                      var product = snap.data![index];
                      var icon = const Icon(Icons.sentiment_very_satisfied_rounded,size: 30,);
                      if(product.currentAmount>product.initialAmount*50/100){
                        icon =  const Icon(Icons.sentiment_very_satisfied_rounded,size: 30,color: Colors.green,);
                      }
                      else if(product.currentAmount<product.initialAmount*50/100&&product.currentAmount>product.initialAmount*25/100){
                        icon = const Icon(Icons.sentiment_neutral_rounded  ,size: 30,color: Colors.orange,);
                      }
                      else if(product.currentAmount<product.initialAmount*25/100){
                        icon = const Icon(Icons.sentiment_dissatisfied_rounded ,size: 30,color: Colors.red,);
                      }
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          child: ListTile(
                            leading: icon,
                            title: Text('${product.name}',style: TextStyle(fontWeight: FontWeight.bold),),
                            trailing: Text("Stock: ${product.currentAmount.toString()} und. \nPrecio: S/${product.unitPrice.toString()} "),
                            onTap: (){

                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProductDetailView(p: product),
                              ));
                            },
                          ),
                        ),
                      );

                    });
              } else if (snap.hasError) {
                return Center(
                  child: Text("error ${snap.error}"),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ),
    ) ;
  }

  Future<List<Product>> getProducts() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? val = preferences.getString("token");
    var idOwner = '';
    if(val!=null) {
      Map<String, dynamic> payload = Jwt.parseJwt(val);
      idOwner = payload["dataId"];
    }
    final res = await http.get(Uri.parse("http://10.0.2.2:9000/api/owner/${idOwner}/products")); //text

    final list = List.from(jsonDecode(res.body));
    List<Product> products = [];
    for (var element in list) {
      final Product product = Product.fromJson(element);
      products.add(product);
    }
    print(products);


    return products;
  }





}



