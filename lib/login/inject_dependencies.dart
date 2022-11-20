import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_team/login/authentication_repository_impl.dart';
import 'package:shop_team/login/sign_up_repository_impl.dart';
import 'package:shop_team/login/authentication_repository.dart';
import 'package:shop_team/login/sign_up_repository.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

void injectDependecies(){
 Get.i.lazyPut<AuthenticationRepository>(
     ()=> AuthenticationRepositoryImpl(FirebaseAuth.instance),
 );
 Get.i.lazyPut<SignUpRepository>(
         ()=> SignUpRespositoryImpl(
          FirebaseAuth.instance,
         ),
 );
}