import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home.dart';


class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;


  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 4), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    //final height = MediaQuery.of(context).size.height;
    return  SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 200,
                decoration: const BoxDecoration(
                  color:  Color(0xff343E86),

                ),

                child:Padding(
                  padding:  EdgeInsets.only(left: width*1/25 ),
                  child:  Center(
                    child: Text(' ${user.email} adlı hesabınıza doğrulama '
                        'linki gönderildi.Lütfen Doğrulayın.İşlem bittikten sonra otomatik olarak'
                        'ana sayfaya yönlendirileceksiniz',style: TextStyle(
                        color: Color(0xFFFEFD3A),fontSize: 22
                    ),),
                  ),
                )
            ),

          ],
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();

      Get.to(() => Home());
    }
  }

}
