import 'package:flutter/material.dart';
import 'package:shop_team/api/product.dart';
import 'package:shop_team/inventory/edit_view.dart';
import '../sales/list_sale.dart';

class ProductDetailView extends StatefulWidget {
  Product p;
  ProductDetailView({required this.p});
  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}


class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Destalle"),
      ),
      body: Column(
        children: [
          Image.network(
            widget.p.img,
            height: 350,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            widget.p.name,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            widget.p.description,
            style: const TextStyle(
              fontSize: 17,

            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.amber,
                  width: 3
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Precio de venta: S/${widget.p.unitPrice.toString()}",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Stock: ${widget.p.currentAmount.toString()}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )
                        ],
                      ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Precio de compra: S/${widget.p.purchasePrice.toString()}",
                      style: const TextStyle(fontSize: 20,  color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                        "Cantidad inicial: ${widget.p.initialAmount.toString()} u",
                        style: const TextStyle(fontSize: 20,  color: Colors.grey),
                      ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditView( product: widget.p,),
                ));

              }, icon: const Icon(Icons.edit, size: 50,color: Colors.orange ),
              ),
              IconButton(onPressed: (){}, icon: const Icon(Icons.delete,size: 50,color: Colors.red,))
              
            ],
          )
        ],
      ),
    );
  }
}
