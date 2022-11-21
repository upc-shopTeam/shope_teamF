import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_team/login/sign_up.dart';

abstract class AuthenticationRepository{
  Future<User?> get user;
  Future<void> signOut();
  Future<SignInResponse> signInWithEmailAndPassword(
      String email,
      String password,
      );
}

class SignInResponse{
  final SignInError? error;
  final User? user;

  SignInResponse(this.error, this.user);
}

enum SignInError{
  networkRequestFailed,
  userDisabled,
  userNotFound,
  wrongPassword,
  unknown
}


SignInError stringToSignInError(String code){
  switch(code){
    case "user-disabled":
      return SignInError.userDisabled;
    case "user-not-found":
      return SignInError.userNotFound;
    case "network-request-failed":
      return SignInError.networkRequestFailed;
    case "wrong-password":
      return SignInError.wrongPassword;
    default:
      return SignInError.unknown;
  }
}

