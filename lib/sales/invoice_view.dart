import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_team/sales/home.dart';
import 'package:shop_team/sales/products_view.dart';
import 'list_sale.dart';
import 'package:http/http.dart' as http;
import 'package:shop_team/api/product.dart';

class InvoiceView extends StatelessWidget {
  List<Item> list;
  int total;
  String name;
  String dni;
  InvoiceView(
      {super.key,
      required this.list,
      required this.total,
      required this.name,
      required this.dni});
  List<Object> listObj = [];

  final date = DateTime.now();

  final obj = {};
  void updateProduct(String id, Product p) async {
    final obj = {

      "date": p.date,
      "name": p.name,
      "unitPrice": p.unitPrice,
      "description": p.description,
      "img": p.img,
      "owner": p.owner,
      "category": p.category,
      "initialAmount": p.initialAmount,
      "currentAmount": p.currentAmount,
      "purchasePrice": p.purchasePrice

    };
    final headers = {"Content-Type": "application/json;charset=UTF-8"};
    final res = await http.put(Uri.parse("https://express-shopapi.herokuapp.com/api/products/$id"),
        headers: headers, body: jsonEncode(obj));

  }
  void saveInvoice() async {
    for (var i in list) {
      final obj = {
        "idProduct": i.product.id,
        "nameProduct": i.product.name,
        "amount": i.amount,
        "unitPrice": i.product.unitPrice,
        "subtotal": i.amount*i.product.unitPrice
      };
      listObj.add(obj);
    }

    final invoice = {
      "employee": "636587c61c8ee4c283e55e70",
      "nameCustomer": name,
      "dniCustomer": dni,
      "date": date.toString(),
      "sales": listObj,
      "totalPayment": total,
    };
    final headers = {"Content-Type": "application/json;charset=UTF-8"};
    final res = await http.post(Uri.parse("https://express-shopapi.herokuapp.com/api/invoices"),
        headers: headers, body: jsonEncode(invoice));

    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: const [ BoxShadow(
                        color: Colors.black87,
                        blurRadius: 4,
                        offset: Offset(5, 5), // Shadow position
                      ),]

                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Datos del Cliente:',
                                style: TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold),
                              ),

                              Text(
                                'Nombre: ${name}',
                              ),
                              Text('DNI: ${dni}')
                            ],
                          ),
                          Text(
                              "Fecha: ${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold
                              ),),

                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: const [ BoxShadow(
                        color: Colors.black87,
                        blurRadius: 4,
                        offset: Offset(5, 5), // Shadow position
                      ),]

                  ),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DataTable(
                          columns: const [
                            DataColumn(
                                label: Expanded(
                              child: Text(
                                '#',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            )),
                            DataColumn(
                                label: Expanded(
                              child: Text(
                                'Producto',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            )),
                            DataColumn(
                                label: Expanded(
                              child: Text(
                                'Cantidad',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            )),
                            DataColumn(
                                label: Expanded(
                              child: Text(
                                'Subtotal',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            )),
                          ],
                          rows: List<DataRow>.generate(
                              list.length,
                              (int index) => DataRow(cells: <DataCell>[
                                    DataCell(Text("${index + 1}")),
                                    DataCell(Text(list[index].product.name)),
                                    DataCell(Text('${list[index].amount}')),
                                    DataCell(Text(
                                        'S/${list[index].amount * list[index].product.unitPrice}'))
                                  ]))),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 9, right: 20, bottom: 10),
                        child: Container(
                          alignment: Alignment.topRight,
                          child: Text(
                            'Total: $total',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Venta cancelada"),));
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductView(list: []),
                          ));
                        },
                        icon: const Icon(Icons.cancel,
                        size: 50,
                        color: Colors.red,),

                    ),

                    IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Venta finalizada Correctamente"),));
                          saveInvoice();
                          for(var i in list){
                            updateProduct(i.product.id, Product(id: i.product.id, name: i.product.name, unitPrice: i.product.unitPrice, description: i.product.description, img: i.product.img, owner: i.product.owner, category: i.product.category, currentAmount: i.product.currentAmount-i.amount, initialAmount: i.product.initialAmount, date: i.product.date, purchasePrice: i.product.purchasePrice));
                          }
                          listObj.clear();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Home(),
                          ));
                        },
                        icon: const Icon(Icons.check_circle,
                        size: 50,
                        color: Colors.lightGreenAccent,)

                    )
                  ],
                ),
              ],
            ),
          ),

      ),
    );
  }

}
