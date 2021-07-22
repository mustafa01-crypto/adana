import 'package:adana/components/riv.dart';
import 'package:adana/components/showDialog.dart';
import 'package:adana/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;
  bool showPassword = false;
  late BuildContext context;

  TextStyle hint = TextStyle(
    color: Colors.white,
  );

  static Future<bool> signUp(name, email, password) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? signedInUser = authResult.user;

      if (signedInUser != null) {
        _firestore
            .collection('users')
            .doc(signedInUser.email)
            .set({'name': name, 'email': email, 'parola': password});
        Get.to(() => Home());
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
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
                  margin:
                      EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 50),
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Stack(
                    children: [
                      rives(context,"assets/riv/hourglass.riv"),
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
                                    "KAYIT",
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
                                  "Ad Soyad",
                                  style: cityName,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: TextFormField(
                                  controller: t1,
                                  keyboardType: TextInputType.name,
                                  style: citytext,
                                  decoration: InputDecoration(
                                      hintText: "Ad Soyad",
                                      hintStyle: TextStyle(color: sinir)
                                      // icon is 48px widget.
                                      ),
                                ),
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
                                  controller: t2,
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
                                height: height * 1 / 60,
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
                                  controller: t3,
                                  style: TextStyle(color: sinir),
                                  obscureText: showPassword,
                                  decoration: InputDecoration(
                                    hintText: "Şifre",
                                    hintStyle: TextStyle(color: sinir),
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.all(0.0),
                                      child: showPassword == true
                                          ? IconButton(
                                              icon: Icon(Icons.remove_red_eye),
                                              color: Colors.grey,
                                              onPressed: () {
                                                setState(() {
                                                  showPassword = false;
                                                });
                                              },
                                            )
                                          : IconButton(
                                              icon: Icon(Icons.remove_red_eye),
                                              color: sinir,
                                              onPressed: () {
                                                setState(() {
                                                  showPassword = true;
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
                                        signUp(t1.text, t2.text, t3.text);

                                        showMaterialDialog(
                                          title: "Kayıt Başarılı",
                                          content: "Başarılı bir şekilde kayıt oldunuz",
                                          context: context,
                                        );
                                      }
                                    },
                                    child: Text('KAYIT OL',style: butonBaslik,),
                                    style: ElevatedButton.styleFrom(
                                        primary: sinir,
                                        shape: StadiumBorder(
                                            side: BorderSide.none)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 1 / 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Hesabım var",style: baslik3,),
                                  TextButton(
                                    onPressed: () {
                                      Get.to(() => Login());
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Text(
                                        "Giriş Yap",
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

  Widget formElement(
      {@required TextEditingController? textEditingController,
      String? text,
      TextInputType? textInputType,
      Icon? icon}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 5, right: 8, bottom: 5),
      child: TextFormField(
        keyboardType: textInputType,
        style: TextStyle(color: Colors.white),
        controller: textEditingController,
        decoration:
            InputDecoration(suffixIcon: icon, hintText: text, hintStyle: hint
                // icon is 48px widget.
                ),
      ),
    );
  }
}
