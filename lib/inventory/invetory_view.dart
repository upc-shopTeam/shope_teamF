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
  final url = Uri.parse("https://express-shopapi.herokuapp.com/api/products");

  final name = TextEditingController();
  final unitPrice = TextEditingController();
  final description = TextEditingController();
  final img = TextEditingController();
  final category = TextEditingController();
  final initialAmount = TextEditingController();
  final currentAmount = TextEditingController();
  final purchasePrice = TextEditingController();
  final date = DateTime.now();
  final owner = TextEditingController();


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
      floatingActionButton: FloatingActionButton(
        onPressed: (){
            showForm();
        },
        child: const Icon(Icons.add),
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
    final res = await http.get(Uri.parse("https://express-shopapi.herokuapp.com/api/owner/${idOwner}/products")); //text

    final list = List.from(jsonDecode(res.body));
    List<Product> products = [];
    for (var element in list) {
      final Product product = Product.fromJson(element);
      products.add(product);
    }
    print(products);


    return products;
  }
  void showForm() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Agregar Usuario"),

            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: name,
                    decoration: const InputDecoration(hintText: "Nombre"),
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: description,
                    decoration: const InputDecoration(hintText: "Descricion"),
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: img,
                    decoration: const InputDecoration(hintText: "Imagen"),
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: initialAmount,
                    decoration: const InputDecoration(hintText: "Cantidad de productos"),
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: purchasePrice,
                    decoration: const InputDecoration(hintText: "Precio de compra"),
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: unitPrice,
                    decoration: const InputDecoration(hintText: "Precio de venta"),
                  )
                ],


          ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancelar"),
              ),
              TextButton(
                onPressed: () {
                  createProduct();
                  Navigator.of(context).pop();
                },
                child: const Text("Guardar"),
              )
            ],
          );
        });
  }

  void createProduct () async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? val = preferences.getString("token");
    var idOwner = '';
    if(val!=null) {
      Map<String, dynamic> payload = Jwt.parseJwt(val);
      idOwner = payload["dataId"];

    }

    final product = {
      "name": name.text,
      "unitPrice": unitPrice.text,
      "description": description.text,
      "img": img.text,
      "owner": idOwner,
      "category": '6359c736b688f87b9f9987ba',
      "currentAmount": int.parse(initialAmount.text),
      "initialAmount": int.parse(initialAmount.text),
      "date": date.toString(),
      "purchasePrice": int.parse(purchasePrice.text)
    };
   final res = await http.post(url, headers: headers, body: jsonEncode(product));
    print(res.body);
    name.clear();
    description.clear();
    unitPrice.clear();
    img.clear();
    initialAmount.clear();
    currentAmount.clear();
    purchasePrice.clear();

    setState(() {
      products = getProducts();
    });
  }




}



