class Sale {
  String id;
  String employee;
  String nameCustomer;
  String dniCustomer;
  String date;
  List sales;
  int totalPayment;

  Sale({required this.id,
    required this.employee,
    required this.nameCustomer,
    required this.dniCustomer,
    required this.date,
    required this.sales,
    required this.totalPayment,
  });
  factory Sale.fromJson(Map json) {
    return Sale(
        id: json["_id"],
        employee: json["employee"],
        nameCustomer: json["nameCustomer"],
        dniCustomer: json["dniCustomer"],
        date: json["date"],
        sales: json["sales"],
        totalPayment: json["totalPayment"]);
  }
}
