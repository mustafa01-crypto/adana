import 'dart:async';
import 'package:adana/auth/register.dart';
import 'package:adana/components/riv.dart';
import 'package:adana/components/showDialog.dart';
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

      Get.to(() => Home());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');

        showMaterialDialog(
            title: "Kullanıcı Bulunamadı",
            content: "Lütfen bilgilerinizi kontrol ediniz",
            context: context);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');

        showMaterialDialog(
            title: "Hatalı kullanıcı adı ya da şifre",
            content: "Lütfen bilgilerinizi kontrol ediniz",
            context: context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
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
                    color: Colors.white,
                  ),
                  child: Stack(
                    children: [
                      Rives(),
                      Padding(
                        padding: EdgeInsets.only(top: height * 1 / 3),
                        child: Container(
                          width: double.infinity,
                          height: height * 2 / 3,
                          decoration: BoxDecoration(
                              color: Colors.white,

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                ),
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 1 / 120,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "GİRİŞ",
                                    style: baslik2,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: height * 1 / 60,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "Email",
                                  style: cityName,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
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
                                  style: citytext,
                                  decoration: InputDecoration(
                                      hintText: "E mail",
                                      hintStyle: TextStyle(color: sinir)
                                      // icon is 48px widget.
                                      ),
                                ),
                              ),
                              SizedBox(
                                height: 23,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "Parola",
                                  style: cityName,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: TextFormField(
                                  controller: t2,
                                  style: TextStyle(color: sinir),
                                  obscureText: showPassword,
                                  decoration: InputDecoration(
                                    hintText: "Şifre",
                                    hintStyle: TextStyle(color: sinir),
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.all(0.0),
                                      child: showPassword == false
                                          ? IconButton(
                                              icon: Icon(Icons.remove_red_eye),
                                              color: sinir,
                                              onPressed: () {
                                                setState(() {
                                                  showPassword = true;
                                                });
                                              },
                                            )
                                          : IconButton(
                                              icon: Icon(Icons.remove_red_eye),
                                              color: Colors.grey,
                                              onPressed: () {
                                                setState(() {
                                                  showPassword = false;
                                                });
                                              },
                                            ),
                                    ),
                                    // icon is 48px widget.
                                  ),
                                  validator: (deger) {
                                    if (deger!.isEmpty || deger.length < 6) {
                                      return "Lütfen 6 karakterden uzun bir şifre giriniz";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: height * 1 / 30,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 1 / 20),
                                child: Container(
                                  width: width * 9 / 10,
                                  height: height * 1 / 15,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        girisYap();
                                      }
                                    },
                                    child: Text('GİRİŞ YAP',style: butonBaslik,),
                                    style: ElevatedButton.styleFrom(
                                      primary: sinir,
                                      shape:
                                          StadiumBorder(side: BorderSide.none),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 1 / 20,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 1 / 20),
                                child: Container(
                                  width: width * 9 / 10,
                                  height: height * 1 / 15,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.to(() => Register());
                                    },
                                    child: Text('KAYIT OL',style: butonBaslik,),
                                    style: ElevatedButton.styleFrom(
                                        primary: sinir,
                                        shape: StadiumBorder(
                                            side: BorderSide.none)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
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
 */
