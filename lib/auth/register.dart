import 'package:adana/auth/login.dart';
import 'package:adana/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home.dart';

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
                    margin:
                        EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 50),
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 150,
                        ),
                        formElement(
                            textEditingController: t1,
                            text: "Ad Soyad",
                            textInputType: TextInputType.text,
                            icon: Icon(
                              Icons.ac_unit,
                              size: 30,
                              color: sinir,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, top: 5, right: 8, bottom: 5),
                          child: TextFormField(
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val!)
                                  ? null
                                  : "Lütfen geçerli bir mail adresi giriniz";
                            },
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Colors.white),
                            controller: t2,
                            decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: hint,
                              suffixIcon: Icon(
                                Icons.ac_unit,
                                size: 30,
                                color: sinir,
                              ),

                              // icon is 48px widget.
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, top: 5, right: 8, bottom: 5),
                          child: TextFormField(
                            validator: (deger) {
                              if (deger!.isEmpty || deger.length < 6) {
                                return "Lütfen 6 karakterden uzun bir şifre giriniz";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            style: TextStyle(color: Colors.white),
                            controller: t3,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Parola",
                              hintStyle: hint,
                              suffixIcon: Icon(
                                Icons.ac_unit,
                                size: 30,
                                color: sinir,
                              ),

                              // icon is 48px widget.
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 1 / 20,
                        ),
                        SizedBox(
                          height: height * 1 / 30,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => Login());
                          },
                          child: Text(
                            "Hesabım var(Giriş Yap)",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: width * 1 / 2,
                            height: height * 1 / 15,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  signUp(t1.text, t2.text, t3.text);

                                  Get.to(() => Home());
                                }
                              },
                              child: Text(
                                'DEVAM ET',
                                style: TextStyle(fontSize: 22),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: sinir,
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
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
