import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_team/api/employee.dart';

import 'package:flutter/material.dart';

import 'home_owner_view.dart';

class EmployeeView extends StatefulWidget {
  const EmployeeView({Key? key}) : super(key: key);

  @override
  State<EmployeeView> createState() => _EmployeeViewState();
}

class _EmployeeViewState extends State<EmployeeView> {
  static late Future<List<Employee>> employees;

  final headers = {"Content-Type": "application/json;charset=UTF-8"};
  final url = Uri.parse("https://express-shopapi.herokuapp.com/api/employee");

  final txtName = TextEditingController();
  final txtHireDate = TextEditingController();
  final txtDNI = TextEditingController();
  final txtPhoneNumber = TextEditingController();
  final txtPhoto = TextEditingController();
  final txtEmail = TextEditingController();
  final txtPassword = TextEditingController();

  String name = '';
  String DNI ='';
  String phoneNumber = '';
  String photo ='';
  String email ='';
  String password ='';
  DateTime hireDate = DateTime.now();
  String owner = '';


  @override
  void initState() {
    // TODO: implement initState
    employees = getEmployees();
    // sales = getSales();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Empleados'),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Employee>>(
            future: employees,
            builder: (context, snap) {
              if (snap.hasData) {
                return ListView.builder(

                    itemCount: snap.data!.length,
                    itemBuilder: (context, index) {
                      var employee = snap.data![index];
                      var icon = const Icon(
                        Icons.sentiment_very_satisfied_rounded, size: 30,);
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          child: ListTile(
                            leading: icon,
                            title: Text(employee.name,
                              style: TextStyle(fontWeight: FontWeight.bold),),
                            trailing: Text("DNI: ${employee.DNI
                                .toString()}. \nCelular: S/${employee
                                .phoneNumber.toString()} "),
                            /*onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    EmployeeDetailView(e: employee),
                              ));
                            },*/
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
        onPressed: () {
          showForm();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<List<Employee>> getEmployees() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? val = preferences.getString("token");
    var idOwner = '';
    if (val != null) {
      Map<String, dynamic> payload = Jwt.parseJwt(val);
      idOwner = payload["dataId"];
    }
    final res = await http.get(Uri.parse(
        "https://express-shopapi.herokuapp.com/api/owner/${idOwner}/employees")); //text

    final list = List.from(jsonDecode(res.body));
    List<Employee> employees = [];
    for (var element in list) {
      final Employee employee = Employee.fromJson(element);
      employees.add(employee);
    }
    print(employees);
    return employees;
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
                    controller: txtName,
                    decoration: const InputDecoration(hintText: "Nombre"),
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: txtDNI,
                    decoration: const InputDecoration(hintText: "DNI"),
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: txtEmail,
                    decoration: const InputDecoration(hintText: "Email"),
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: txtPassword,
                    decoration: const InputDecoration(hintText: "Contraseña"),
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: txtPhoneNumber,
                    decoration: const InputDecoration(hintText: "Celular"),
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: txtPhoto,
                    decoration: const InputDecoration(
                        hintText: "Imagen"),
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
                  setState(() {
                    name = txtName.text;
                    DNI=txtDNI.text ;
                    phoneNumber=txtPhoneNumber.text;
                    photo=txtPhoto.text;
                    email= txtEmail.text;
                    password=txtPassword.text;
                  });
                  createEmployee();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(
                      content:
                      Text("Vendedor Registrado")));
                },
                child: const Text("Guardar"),
              )
            ],
          );
        });
  }

  void createEmployee() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? val = preferences.getString("token");
    var ownerId = '';
    if(val!=null) {
      Map<String, dynamic> payload = Jwt.parseJwt(val);
      ownerId=payload["dataId"];
    }
    setState(() {
      owner = ownerId;
    });
    print(owner);
    final user = {
      "name": name,
      "dni": DNI,
      "phoneNumber": phoneNumber,
      "photo": photo,
      "email": email,
      "password": password,
      "hireDate": hireDate.toString(),
      "owner":owner
    };

    final headers = {"Content-Type": "application/json;charset=UTF-8"};

    final res = await http.post(Uri.parse("https://express-shopapi.herokuapp.com/api/employee/sign-up"),
        headers: headers, body: jsonEncode(user));
    print(res);
  }
}