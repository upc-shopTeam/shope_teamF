
class User{

  String id;
  String name;
  String lastname;
  String email;
  String phone;
  String dni;
  String date;
  String rol;
  String img;


  User({required this.id,
    required this.name,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.dni,
    required this.date,
    required this.rol,
    required this.img,
  });

  // NO SE COMO FUNCIONA ESTA PARTE
 //factory User.fromJson(Map json) {
 //  return User(
 //      id: json["_id"],
 //      date: json["date"],

}




  //{
  //"id": 1,
  //"name": "Leanne Graham",
  //"username": "Bret",
  //"email": "Sincere@april.biz",
  //"address": {
  //"street": "Kulas Light",
  //"suite": "Apt. 556",
  //"city": "Gwenborough",
  //"zipcode": "92998-3874",
  //"geo": {
  //"lat": "-37.3159",
  //"lng": "81.1496"
  //}
  //},
  //"phone": "1-770-736-8031 x56442",
  //"website": "hildegard.org",
  //"company": {
  //"name": "Romaguera-Crona",
  //"catchPhrase": "Multi-layered client-server neural-net",
  //"bs": "harness real-time e-markets"
  //}