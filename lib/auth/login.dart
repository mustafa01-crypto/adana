import 'dart:async';
import 'package:adana/auth/register.dart';
import 'package:adana/auth/forgotPassword.dart';
import 'package:adana/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    final width = MediaQuery.of(context).size.width;

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
          // Fluttertoast.showToast(msg: message);
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
                      image: NetworkImage(
                        'https://wallpaperaccess.com/full/459222.jpg',
                      ),
                    ),
                  ),
                ),
                Opacity(
                  opacity: 0.59,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.black26,
                            Colors.black54,
                            Colors.black,
                          ]),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: width * 1 / 2,
                    ),
                    Text(
                      'GİRİŞ EKRANI',
                      style: TextStyle(
                        letterSpacing: 3,
                        fontSize: 35.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: width * 1 / 5,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w300),
                        decoration: InputDecoration(
                          hintText: "Email Adresi",
                          hintStyle: TextStyle(color: Colors.white),
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.white),
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                              style: BorderStyle.solid,
                              width: 1.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                              style: BorderStyle.solid,
                              width: 1.5,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.grey.shade300,
                          ), // icon is 48px widget.
                          //fillColor: Colors.green
                        ),
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
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w300),
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                            hintText: "Parola",
                            hintStyle: TextStyle(color: Colors.white),
                            labelText: "Parola",
                            labelStyle: TextStyle(color: Colors.white),
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.white,
                                style: BorderStyle.solid,
                                width: 1.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.white,
                                style: BorderStyle.solid,
                                width: 1.5,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.vpn_key,
                              color: Colors.grey.shade300,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(_passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              color: Colors.grey.shade300,
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            )
                            // icon is 48px widget.
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
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            girisYap();
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: Center(
                            child: Text(
                              "GİRİŞ YAP",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade400,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black38.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset:
                                    Offset(0, -1), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hesabım yok",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => Register());
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Text(
                              "Kayıt Ol",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => ForgotPassword());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(
                          "Şifremi Unuttum",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
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
