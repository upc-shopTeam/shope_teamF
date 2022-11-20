import 'package:flutter/material.dart';
import 'package:shop_team/sales/invoice_view.dart';

import '../api/product.dart';
import 'list_sale.dart';

class SaleView extends StatefulWidget {
  List<Item> list;
  SaleView({super.key, required this.list});

  @override
  State<SaleView> createState() => _SaleViewState();
}

var total = 0;
var raa = 0;

class _SaleViewState extends State<SaleView> {
  late List<Item> items;

  final txtNameCustomer = TextEditingController();
  final txtDNICustomer = TextEditingController();
  String name = '';
  String dni = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items = widget.list;

    total = 0;
    for (var i in items) {
      var a = i.amount * i.product.unitPrice;
      total += a;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de productos"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            height: 450,
            child: ListView.builder(
              itemCount: widget.list.length,
              itemBuilder: (context, index) {
                var item = widget.list[index];
                var sum = item.amount * item.product.unitPrice;
                // print(totalList(item.amount*item.product.unitPrice));
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Icon(Icons.delete),
                  ),
                  key:UniqueKey(),
                  onDismissed: (DismissDirection direction) {
                    setState(() {
                      items.removeAt(index);
                     total = 0;
                      for (var i in items) {
                        var a = i.amount * i.product.unitPrice;
                        total += a;
                      }
                    });
                  },
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.network(
                              item.product.img,
                              width: 90,
                              height: 90,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.product.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                  ),
                                ),
                                Text(
                                    "S/${item.product.unitPrice.toString()}.00 u.",
                                style: const TextStyle(
                                  color: Colors.grey
                                ),),
                              ],
                            ),

                            const VerticalDivider(
                              thickness: 1,
                              color: Colors.black87,
                              width: 1,
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(38), color: const Color(0xFF42A5F5)),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            item.amount -= 1;

                                            if (item.amount < 0) {
                                              item.amount = 0;
                                            }
                                            total = 0;
                                            for (var i in items) {
                                              var a = i.amount * i.product.unitPrice;
                                              total += a;
                                            }
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(item.amount.toString()),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            item.amount += 1;
                                            total = 0;
                                            for (var i in items) {
                                              var a = i.amount * i.product.unitPrice;
                                              total += a;
                                            }
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "TOTAL: S/$sum.00",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.red),
                                ),
                              ],
                            ),
                          ]),
                      const Divider(
                        height: 10,
                        thickness: 1,
                        indent: 20,
                        endIndent: 0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          Text(
            "Total: ${total}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: 200,
              height: 40,
              child: TextField(
                controller: txtNameCustomer,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre del cliente'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: 200,
              height: 40,
              child: TextField(
                controller: txtDNICustomer,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(

                  border: OutlineInputBorder(),
                  labelText: 'DNI',
                ),
              ),
            ),
          ),

          ElevatedButton(
              onPressed: () {
                setState(() {
                  name = txtNameCustomer.text;
                  dni = txtDNICustomer.text;
                });
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      InvoiceView(list: items, total: total, name: name, dni: dni),
                ));
                txtDNICustomer.clear();
                txtNameCustomer.clear();
              },
              child: const Text(
                "Generar venta",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
        ])),
      ),
    );
  }
}
