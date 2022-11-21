import 'package:flutter/material.dart';
import 'package:shop_team/api/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shop_team/inventory/invetory_view.dart';
class EditView extends StatefulWidget {
  Product product;
  EditView({required this.product});
  @override
  State<EditView> createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {

  final txtName = TextEditingController();
  final txtCantidadInicial = TextEditingController();
  final txtPrecioCompra = TextEditingController();
  final txtPrecioVenta = TextEditingController();
  final txtCantidadActual = TextEditingController();


  void editProduct(String id, Product p) async {
    print(id);
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
    print(res.body);
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    txtName.text = widget.product.name;
    txtCantidadInicial.text= widget.product.initialAmount.toString();
    txtPrecioCompra.text = widget.product.purchasePrice.toString();
     txtPrecioVenta.text =widget.product.unitPrice.toString();
     txtCantidadActual.text = widget.product.currentAmount.toString();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Producto'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextFormField(
                controller: txtName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Nombre')
                ),
              ),
              TextFormField(
                controller: txtCantidadInicial,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Cantidad inicial')
                ),
              ),
              TextFormField(
                controller: txtPrecioCompra,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Precio de Compra')
                ),
              ),
              TextFormField(
                controller: txtPrecioVenta,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Precio de venta')
                ),
              ),
              TextFormField(
                controller: txtCantidadActual,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Cantidad Actual')
                ),
              ),
              ElevatedButton(onPressed: (){
                setState(() {
                  final p = Product(id: widget.product.id, name: txtName.text, unitPrice: int.parse(txtPrecioVenta.text), description: widget.product.description, img: widget.product.img, owner: widget.product.owner, category: widget.product.category, currentAmount: int.parse(txtCantidadActual.text), initialAmount: int.parse(txtCantidadInicial.text), date: widget.product.date, purchasePrice: int.parse(txtPrecioCompra.text));
                  print(p);
                  editProduct(widget.product.id,p);

                  });
                Navigator.pushNamed(context, '/inventory');
              }, child: const Text('Editar'))
            ],
          ),
        ),
      ),
    );
  }
}
