import 'dart:async';
import 'package:adana/components/infoText.dart';
import 'package:adana/constants/constants.dart';
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

    timer = Timer.periodic(Duration(seconds: 2), (timer) {
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
    return SafeArea(

        child: Scaffold(
          backgroundColor: kutu,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        infoText(' ${user.email} adlı hesabınıza doğrulama '
            'linki gönderildi.Lütfen Doğrulayın.İşlem bittikten sonra otomatik olarak'
            ' ana sayfaya yönlendirileceksiniz'),
      ]),
    ));
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();

      Get.offAll(Home());
    }
  }
}
