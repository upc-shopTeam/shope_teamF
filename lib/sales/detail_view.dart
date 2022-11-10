
import 'package:flutter/material.dart';
import 'package:shop_team/api/Product.dart';
import 'package:shop_team/sales/list_sale.dart';
import 'package:shop_team/sales/products_view.dart';
import 'package:shop_team/sales/sale_view.dart';

class DetailView extends StatefulWidget {
  Product p;

  DetailView({required this.p});

  @override
  State<DetailView> createState() => _DetailViewState();
}
int _cont = 0;
List<Item> item = [];
class _DetailViewState extends State<DetailView> {

  State<DetailView> createState() => _DetailViewState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Destalle Producto"),
      ),
      body: Container(
        child: Column(
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
              style: TextStyle(
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
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Precio: S/${widget.p.unitPrice.toString()}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Stock: ${widget.p.currentAmount.toString()}",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                margin: const EdgeInsets.only(top: 30),
                height: 50,
                width: 130,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(38), color: Color(0xFF42A5F5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    IconButton(onPressed: (){
                      setState(() {
                        _cont-=1;
                        if(_cont < 0){
                          _cont = 0;
                        }

                      });
                    }, icon: Icon(Icons.remove)),
                    Text('${_cont}'),
                    IconButton(onPressed: (){
                      setState(() {
                        _cont+=1;
                      });
                    }, icon: Icon(Icons.add)),
                  ],
                ),
              ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  height: 50,
                  width: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(38), color: const Color(0xFF42A5F5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [TextButton(
                      onPressed: () {
                        setState(() {
                           item.add(Item(amount: _cont,product: widget.p));
                        });
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProductView(list: item),
                        ));
                       // Scaffold.of(context).showSnackBar(SnackBar(content: Text("$item dismissed")));
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Agregado"),));
                      },
                      child: const Text("AGREGAR",style: TextStyle(color: Colors.black),),

                    )]
                  ),
                ),
              ]
            )
          ],
        ),
      ),
    );
  }
}

