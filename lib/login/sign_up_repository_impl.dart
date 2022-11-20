
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_team/login/sign_up.dart';
import 'package:shop_team/login/sign_up_repository.dart';

class SignUpRespositoryImpl implements SignUpRepository{
   final FirebaseAuth _auth;

   SignUpRespositoryImpl(this._auth);

  @override
  Future<SignUpResponse> register(SignUpData data) async{
    try{
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: data.email,
        password: data.password,
      );
      await userCredential.user!.updateDisplayName(
          "${data.name} ${data.lastname}",
      );
      return SignUpResponse(null ,userCredential.user!);
    } on FirebaseAuthException catch(e){
        return SignUpResponse(parseStringToSignUpError(e.code),null);
    }
  }


}