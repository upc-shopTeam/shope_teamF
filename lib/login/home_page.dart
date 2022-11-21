import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_team/login/authentication_repository.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/router.dart' as router;

import 'routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("HOME PAGE"),
            SizedBox(height: 20),
            CupertinoButton(
              color: Colors.blue,
                child: Text("sign out"),
                onPressed: () async{
                await  Get.i.find<AuthenticationRepository>().signOut();
                router.pushNamedAndRemoveUntil(Routes.LOGIN);
                },
            )
          ],
        ),
      ),
    );

  }
}
