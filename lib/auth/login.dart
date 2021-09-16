import 'dart:async';

import 'package:adana/components/button_box.dart';
import 'package:adana/components/form_text.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  bool _passwordVisible = true;

  late StreamSubscription<User?> listener;

  static final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    _passwordVisible = false;
    listener = _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        Get.to(() => Home());
      }
    });
  }

  Future<void> girisYap() async {
    try {
      await _auth.signInWithEmailAndPassword(email: t1.text, password: t2.text);

      Get.offAll(Home());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Get.snackbar(
          "Kullanıcı Bulunamadı",
          "Lütfen bilgilerinizi kontrol ediniz",
          backgroundColor: Colors.grey.shade200,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Get.snackbar(
          "Hatalı kullanıcı adı ya da şifre",
          "Lütfen bilgilerinizi kontrol ediniz",
          backgroundColor: Colors.grey.shade200,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  DateTime timeDifference = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeDifference);
        final isExitWarning = difference >= Duration(seconds: 2);

        timeDifference = DateTime.now();
        if (isExitWarning) {
          final message = "Çıkış Yapmak için artarda 2 kez tıklayın";
          Get.snackbar(
            "Bilgi",
            message,
            backgroundColor: Colors.grey.shade200,
            snackPosition: SnackPosition.BOTTOM,
          );
          return false;
        } else {
          return true;
        }
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Form(
            key: _formKey,
            child: Stack(
              children: [
                Container(
                  constraints: BoxConstraints.expand(),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/459222.jpg',
                      ),
                    ),
                  ),
                ),
                Opacity(
                  opacity: 0.44,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [topBack, centerBack, bottomBack]),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Text('GİRİŞ EKRANI', style: loginTitle),
                    SizedBox(
                      height: 12.5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style:
                            TextStyle(color: kutu, fontWeight: FontWeight.w300),
                        decoration: formDecoration(
                            "E-mail Adresi",
                            "E-mail",
                            Icon(
                              Icons.email,
                              color: kutu,
                            ),
                            SizedBox()),
                        validator: (val) {
                          if (!GetUtils.isEmail(val!))
                            return "Geçersiz email adresi";
                          else
                            return null;
                        },
                        controller: t1,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: TextFormField(
                        style:
                            TextStyle(color: kutu, fontWeight: FontWeight.w300),
                        obscureText: !_passwordVisible,
                        decoration: formDecoration(
                          "Parola",
                          "Parola",
                          Icon(
                            Icons.vpn_key,
                            color: kutu,
                          ),
                          IconButton(
                            icon: Icon(_passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            color: kutu,
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (deger) {
                          if (deger!.isEmpty || deger.length < 6) {
                            return "Lütfen 6 karakterden uzun bir şifre giriniz";
                          }
                          return null;
                        },
                        controller: t2,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                      child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              girisYap();
                            }
                          },
                          child: buttonBox(context, "GİRİŞ YAP")),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hesabım yok?",
                          style: loginText,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed("/register");
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 2.w),
                            child: Text(
                              "Kayıt Ol",
                              style: loginTextUnderlined,
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed("/forgot");
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 2.w),
                        child: Text("Şifremi Unuttum", style: loginText),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
