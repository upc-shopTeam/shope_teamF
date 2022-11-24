import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_team/api/product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SalesProductsView extends StatefulWidget {
  const SalesProductsView({Key? key}) : super(key: key);

  @override
  State<SalesProductsView> createState() => _SalesProductsViewState();
}
class _SalesProductsViewState extends State<SalesProductsView> {
  late Future<List<Product>> products;
  late int totalVendido;
  late int totalInvertido;
  final headers = {"Content-Type": "application/json;charset=UTF-8"};
  //final url = Uri.parse("https://express-shopapi.herokuapp.com/api/products");

@override
  void initState() {
    // TODO: implement initState
  products = getProducts();
  totalVendido = 0;
  totalInvertido = 0;
  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        title: Text('Ventas por producto'),
      ),
      body:  SafeArea(
        child: Column(
          children: [
          
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text.rich(
                        TextSpan(
                            text: 'Inversion: ',
                            style: const TextStyle(
                                fontSize: 15
                            ),
                            children: <InlineSpan>[
                              TextSpan(
                                  text: '$totalInvertido',
                                style: TextStyle(fontWeight: FontWeight.bold)
                              )
                            ]
                        )
                    ),
                    const SizedBox(
                        height: 80,
                        child: VerticalDivider(
                            color: Colors.grey
                        )
                    ),
                    Text.rich(
                        TextSpan(
                            text: 'Ganancia vendida: ',
                            style: const TextStyle(
                                fontSize: 15
                            ),
                            children: <InlineSpan>[
                              TextSpan(
                                  text: '${totalVendido}',
                                  style: TextStyle(fontWeight: FontWeight.bold)
                              )
                            ]
                        )
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder<List<Product>>(
                future: products,
                builder: (context, snap) {
                  if (snap.hasData) {

                    return Container(
                      height: MediaQuery.of(context).size.height*0.7,
                      child: ListView.builder(

                          itemCount: snap.data!.length,
                          itemBuilder: (context, index) {

                            var product = snap.data![index];

                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child:Container(
                                decoration: BoxDecoration(
                                  color:  Colors.green[100],
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.blueGrey,
                                        width: 2
                                    )
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.check, size: 30, color: Colors.green,),
                                        Text(product.name,style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)
                                      ],
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text('Cant. Vendida:  ${product.initialAmount-product.currentAmount} u'),
                                              Text('Precio de Venta:  S/${product.unitPrice}'),
                                              Text('Total:  S/${(product.initialAmount-product.currentAmount)*product.unitPrice}')
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text('Cant. Comprada:  ${product.initialAmount} u'),
                                              Text('Precio de Compra:  S/${product.purchasePrice}'),
                                              Text('Total:  S/${product.initialAmount*product.purchasePrice}')
                                            ],
                                          )
                                        ],
                                      ),
                                    )

                                  ],
                                ),
                              ),
                            );

                          }),
                    );
                  } else if (snap.hasError) {
                    return Center(
                      child: Text("error ${snap.error}"),
                    );
                  }

                  return const Center(child: CircularProgressIndicator());
                }),


          ],
        ),
      ),
    );

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

    sumaProductosVendidos(products);
    sumaInversion(products);
    return products;
  }

  int  sumaProductosVendidos(List<Product> nums){
    for(var  i in nums){
      setState(() {
        totalVendido +=(i.initialAmount-i.currentAmount)*i.unitPrice;
      });

    }
    return totalVendido;
  }
  int  sumaInversion(List<Product> nums){
    for(var  i in nums){
      setState(() {
        totalInvertido +=i.initialAmount*i.purchasePrice;
      });

    }
    return totalInvertido;
  }


}
