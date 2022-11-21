import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_team/api/sale.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:calendar_timeline/calendar_timeline.dart';
class BalanceView extends StatefulWidget {
  DateTime initDate;
  BalanceView({required this.initDate});

  @override
  State<BalanceView> createState() => _BalanceViewState();
}

var suma = 0;
class _BalanceViewState extends State<BalanceView> {
  late DateTime _selectedDate;
  late int a;

  static late Future<List<Sale>> sales;


  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
    a = 0;
    sales =getSales();

  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now().add(Duration(days: 2));

  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor:  (Colors.blue),
        body: SafeArea(
          child:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Calendario',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.black),
                  ),
                ),
                CalendarTimeline(
                  showYears: true,
                  initialDate: _selectedDate,
                  firstDate: widget.initDate,
                  lastDate: DateTime.now().add(Duration(days: 365 * 4)),
                  onDateSelected: (date) => setState(() {
                    //a = suma;
                    a = suma;
                    suma = 0;
                    _selectedDate = date;

                  }),
                  leftMargin: 20,
                  monthColor: Colors.white,
                  dayColor: Colors.white,
                  dayNameColor: Colors.black,
                  activeDayColor: Colors.white,
                  activeBackgroundDayColor: Colors.orange,
                  dotsColor: Color(0xFF333A47),
                  selectableDayPredicate: (date) => date.day != 0,
                  locale: 'es',
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: Text(
                      'RESET',
                      style: TextStyle(color: Color(0xFF333A47)),
                    ),
                    onPressed: () => setState(() => _resetSelectedDate()),
                  ),
                ),
                SizedBox(height: 20),
                /*Center(
                  child: Text(
                    'Selected date is $_selectedDate',
                    style: TextStyle(color: Colors.white),
                  ),
                ),*/
                const Padding(padding: const EdgeInsets.all(10),
                  child:  Text('Ventas: ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),

                Column(
                  children: [
                    FutureBuilder<List<Sale>>(
                        future: sales,
                        builder: (context, snap) {
                          //print(suma);
                          if(snap.hasData){
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snap.data!.length,
                                itemBuilder: (context, index){

                                  var sale = snap.data![index];
                                  DateTime dt = DateTime.parse(sale.date);

                                  var card =Container(
                                  );

                                  if(dt.day == _selectedDate.day){
                                       suma += sale.totalPayment;
                                    card = Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('COD: ${sale.id.substring(0,4)}'),
                                                      Text('Cliente: ${sale.nameCustomer}')
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: TextButton(
                                                    style: TextButton.styleFrom(
                                                        backgroundColor: Colors.blue,
                                                        foregroundColor: Colors.white
                                                    ),
                                                    child: Text('${sale.totalPayment}'),
                                                    onPressed: () {  },
                                                  ),
                                                )
                                              ],
                                            )

                                        ),
                                      ),
                                    );

                                  }
                                  return Column(
                                    children: [
                                      card
                                    ],
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
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Color(0xFF333A47)                        ),
                        child: Text('TOTAL: ${a}'),
                        onPressed: () {  },
                      ),
                    )
                  ],
                )

              ],
            ),
          )

        ),
      );
  }

  Future<List<Sale>> getSales() async{

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? val = preferences.getString("token");
    var idOwner = '';
    if(val!=null) {
      Map<String, dynamic> payload = Jwt.parseJwt(val);
      idOwner=payload["dataId"];
    }
    final res = await http.get(Uri.parse("https://express-shopapi.herokuapp.com/api/owner/${idOwner}/invoices"));
    //text
    final list = List.from(jsonDecode(res.body));
    List<Sale> sales = [];
    list.forEach((element) {
      final Sale product = Sale.fromJson(element);
      sales.add(product);
    });
    return sales;
  }

}
