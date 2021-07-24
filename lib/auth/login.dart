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
        backgroundColor: kutu,
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
                    color: xdArka,
                  ),
                  child: Stack(
                    children: [
                      rives(context,"assets/riv/new_file.riv"),
                      Padding(
                        padding: EdgeInsets.only(top: height * 1 / 3),
                        child: Container(
                          width: double.infinity,
                          height: height * 2 / 3,
                          decoration: BoxDecoration(
                              color: Colors.white,

                          ),
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
                                    style: xdAppBarBaslik,
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
                                  style: TextStyle(color: sol),
                                  decoration: InputDecoration(
                                      hintText: "E mail",
                                      hintStyle: TextStyle(color: sol)
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
                                  style: TextStyle(color: sol),
                                  obscureText: showPassword,
                                  decoration: InputDecoration(
                                    hintText: "Şifre",
                                    hintStyle: TextStyle(color: sol),
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
                                              color: sol,
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
                              TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    girisYap();
                                  }
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 70,
                                  child: Center(
                                    child: Text(
                                      "GİRİŞ YAP",
                                      style: xdBeyazBaslik,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: sol,
                                    //border: Border.all(color: kutu, width: 4),
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black38.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: Offset(0, -1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 1 / 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Hesabım yok",style: baslik3,),
                                  TextButton(
                                    onPressed: () {
                                      Get.to(() => Register());
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Text(
                                        "Kayıt Ol",
                                        style: link,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
 if (_formKey.currentState!.validate()) {
                                        girisYap();
                                      }
 */