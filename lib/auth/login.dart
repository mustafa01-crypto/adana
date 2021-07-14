import 'dart:async';

import 'package:adana/auth/register.dart';
import 'package:adana/constants/constants.dart';
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

  bool showPassword = true;
  late StreamSubscription<User?> listener;

  static final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();

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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 0, right: 0, bottom: 50),
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 150,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, top: 15, right: 8, bottom: 15),
                          child: TextFormField(
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val!)
                                  ? null
                                  : "Lütfen geçerli bir mail adresi giriniz";
                            },
                            controller: t1,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: "E mail",
                                hintStyle: TextStyle(color: Colors.white)
                                // icon is 48px widget.
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, top: 15, right: 8, bottom: 15),
                          child: TextFormField(
                              controller: t2,
                              style: TextStyle(color: Colors.white),
                              obscureText: showPassword,
                              decoration: InputDecoration(
                                hintText: "Şifre",
                                hintStyle: TextStyle(color: Colors.white),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child: showPassword == false
                                      ? IconButton(
                                          icon: Icon(Icons.remove_red_eye),
                                          color: Colors.red.shade700,
                                          onPressed: () {
                                            setState(() {
                                              showPassword = true;
                                            });
                                          },
                                        )
                                      : IconButton(
                                          icon: Icon(Icons.remove_red_eye),
                                          color: Colors.grey.shade700,
                                          onPressed: () {
                                            setState(() {
                                              showPassword = false;
                                            });
                                          },
                                        ),
                                ), // icon is 48px widget.
                              ),
                              validator: (deger) {
                                if (deger!.isEmpty || deger.length < 6) {
                                  return "Lütfen 6 karakterden uzun bir şifre giriniz";
                                }
                                return null;
                              }),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: width * 1 / 20,
                              top: 15,
                              right: width * 1 / 20,
                              bottom: 15),
                          child: Container(
                            width: width * 9 / 10,
                            height: height * 1 / 15,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  girisYap();

                                  Get.to(() => Home());
                                }
                              },
                              child: Text('GİRİŞ YAP'),
                              style: ElevatedButton.styleFrom(
                                primary: sinir,
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: width * 1 / 20,
                              top: 15,
                              right: width * 1 / 20,
                              bottom: 15),
                          child: Container(
                            width: width * 9 / 10,
                            height: height * 1 / 15,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(() => Register());
                              },
                              child: Text('KAYIT OL'),
                              style: ElevatedButton.styleFrom(
                                primary: sinir,
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
