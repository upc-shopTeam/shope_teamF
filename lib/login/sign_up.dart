
import 'package:firebase_auth/firebase_auth.dart';

class SignUpData{
  final String name, lastname,email ,password;

  SignUpData({
    required this.name,
    required this.lastname,
    required this.email,
    required this.password,
  });
}


class SignUpResponse{
  final SignUpError? error;
  final User? user;

  SignUpResponse(this.error, this.user);

}

parseStringToSignUpError(String text){
  switch(text){
    case "email-already-in-use":
      return SignUpError.emailAlreadyInUse;

    case "weak-password":
      return SignUpError.weakPassword;
    default:
      return SignUpError.unknown;
  }
}

enum SignUpError{emailAlreadyInUse, weakPassword,unknown}