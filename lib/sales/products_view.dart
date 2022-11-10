import 'dart:convert';
import 'package:shop_team/sales/list_sale.dart';
import 'package:flutter/material.dart';
import 'package:shop_team/api/Product.dart';
import 'package:http/http.dart' as http;
import 'package:shop_team/sales/detail_view.dart';
import 'package:shop_team/sales/sale_view.dart';

class ProductView extends StatefulWidget {
List<Item> list;
ProductView({super.key, required this.list});
  @override
  State<ProductView> createState() => _ProductViewState();
}


class _ProductViewState extends State<ProductView> {

  late Future<List<Product>> products;
  final headers = {"Content-Type": "application/json;charset=UTF-8"};
  final url = Uri.parse("https://my-json-server.typicode.com/LITO-TR/bdShop/products");

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    products = getProducts();

  }


int numCar = 0;
  @override
  Widget build(BuildContext context) {

    numCar = widget.list.length;
    return  Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        actions: [
          Stack(
              children:[
                IconButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SaleView(list: widget.list),
                  ));
                  if(widget.list.isEmpty){
                    setState(() {
                      numCar = 0;
                    });
                  }



                }, icon: const Icon(Icons.shopping_bag,size: 35,)),
                Container(
                  padding: const EdgeInsets.all(5),
                  child:Text("${numCar}") ,
                ),
              ]
          )
        ],
      ),
      body: FutureBuilder<List<Product>>(
          future: products,
          builder: (context, snap) {
            if(snap.hasData){
              return ListView.builder(
                  itemCount: snap.data!.length,
                  itemBuilder: (context, index) {
                    var product = snap.data![index];

                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(

                        child: ListTile(
                          leading:   Image.network(product.img),
                          title: Text(product.name),
                          trailing: Text("Stock: ${product.currentAmount.toString()} und. \n Precio: S/${product.unitPrice.toString()} "),
                          onTap:() {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DetailView(p: product),
                              ));
                          },

                        ),

                      ),
                    );

              });
            }
            else if(snap.hasError) {
              return  Center(
                child: Text("error ${snap.error}"),
              );

            }
            return const Center(child: CircularProgressIndicator());
          }


    ),);
  }

  Future<List<Product>> getProducts() async{
    final res = await http.get(url); //text
    final list = List.from(jsonDecode(res.body));
     List<Product> products = [];
    list.forEach((element) {
      final Product product = Product.fromJson(element);
      products.add(product);
    });
    return products;
  }
}



