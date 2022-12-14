class Employee {
  String id;
  String name;
  String DNI;
  String phoneNumber;
  String photo;
  String email;
  String password;
  String hireDate;

  Employee(
      {required this.id,
        required this.name,
        required this.DNI,
        required this.phoneNumber,
        required this.photo,
        required this.email,
        required this.password,
        required this.hireDate});

  factory Employee.fromJson(Map json) {
    return Employee(
        id: json["_id"],
        name: json["name"],
        DNI: json["dni"],
        phoneNumber: json["phoneNumber"],
        photo: json["photo"],
        email: json["email"],
        password: json["password"],
        hireDate: json["hireDate"]);
  }
}
