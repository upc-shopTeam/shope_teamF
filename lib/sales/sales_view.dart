import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_team/api/sale.dart';
import 'dart:convert';


class SalesView extends StatefulWidget {
  const SalesView({Key? key}) : super(key: key);

  @override
  State<SalesView> createState() => _SalesViewState();
}

class _SalesViewState extends State<SalesView> {

  bool _expanded = false;

  //final url = Uri.parse("https://express-shopapi.herokuapp.com/api/invoices/");

  late Future<List<Sale>> sales;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sales = getProducts();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('VENTAS')
      ),
      body: FutureBuilder<List<Sale>>(
        future: sales,
        builder: (context, snap) {
          if(snap.hasData){
            return ListView.builder(
              itemCount: snap.data!.length,
                itemBuilder: (context, index){

                var sale = snap.data![index];
                print(sale.sales);
                return Column(
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          color: Colors.green,
                          child: ExpansionPanelList(
                            animationDuration: Duration(milliseconds: 2000),
                            children: [
                              ExpansionPanel(
                                headerBuilder: (context, isExpanded) {
                                  return ListTile(
                                    title: Text("COD:  ${sale.id.substring(0,6)}", style: const TextStyle(color: Colors.black),),
                                    trailing: Text('S/${sale.totalPayment.toString()}.00', style: const TextStyle(color: Colors.black),),
                                  );
                                },
                                body:Container(
                                  child: Column(
                                    children:[
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 18),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text('Cliente: ${sale.nameCustomer}',style: const TextStyle(color: Colors.black)),
                                            Text('DNI: ${sale.dniCustomer}',style: const TextStyle(color: Colors.black)),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 14),
                                        child: Text(sale.date.replaceAll("T"," ",)),
                                      ),
                                      const Text("Productos:",
                                          style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),),
                                      DataTable(
                                          columns: const [
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
                                                    'Precio',
                                                    style: TextStyle(fontStyle: FontStyle.italic),
                                                  ),
                                                ))
                                          ],
                                          rows: List<DataRow>.generate(

                                              sale.sales.length,
                                                  (int index) => DataRow(cells: <DataCell>[
                                                    //data[0]["name"]
                                                DataCell(Text(sale.sales[index]["nameProduct"].toString())),
                                                DataCell(Text(sale.sales[index]["amount"].toString())),
                                                DataCell(Text(sale.sales[index]["unitPrice"].toString())),

                                              ]))),

                                    ],

                                  ),
                                ),
                                isExpanded: _expanded,
                                canTapOnHeader: true,
                              ),
                            ],
                            dividerColor: Colors.grey,
                            expansionCallback: (panelIndex, isExpanded) {
                              _expanded =! _expanded;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ]
                );
                }

            );
          }
          else if(snap.hasError) {
            return  Center(
              child: Text("error ${snap.error}"),
            );

          }
          return Center(child: const CircularProgressIndicator());
        }
      )

          );

  }
  Future<List<Sale>> getProducts() async{

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? val = preferences.getString("token");
    var idEmployee = '';
    if(val!=null) {
      Map<String, dynamic> payload = Jwt.parseJwt(val);
      idEmployee=payload["dataId"];
    }
    final res = await http.get(Uri.parse("http://10.0.2.2:9000/api/employee/${idEmployee}/invoices"));

    final list = List.from(jsonDecode(res.body));

    List<Sale> sales = [];
    list.forEach((element) {
      final Sale product = Sale.fromJson(element);
      sales.add(product);
    });
    return sales;
  }

}
