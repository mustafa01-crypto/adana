import 'package:adana/components/showDialog.dart';
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
  bool _passwordVisible = true;
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
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
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
                      'https://images.pexels.com/photos/1366919/pexels-photo-1366919.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                    ),
                  ),
                ),
              ),
              Opacity(
                opacity: 0.85,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.red,
                          Colors.blue,
                        ]),
                  ),
                ),
              ),
              Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  SizedBox(
                    height: width*1/2,
                  ),
                  Text(
                    'KAYIT EKRANI',
                    style: TextStyle(
                      fontSize: 35.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w300),
                      decoration: InputDecoration(
                        hintText: "Ad Soyad",
                        hintStyle: TextStyle(color: Colors.white),
                        labelText: "Ad-Soyad",
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
                          Icons.email_outlined,
                          color: Colors.grey.shade300,
                        ), // icon is 48px widget.
                        //fillColor: Colors.green
                      ),
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
                          Icons.email_outlined,
                          color: Colors.grey.shade300,
                        ), // icon is 48px widget.
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val!)
                            ? null
                            : "Lütfen geçerli bir mail adresi giriniz";
                      },
                      controller: t2,
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
                          Icons.lock_outline,
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
                        ),
                      ),
                      validator: (deger) {
                        if (deger!.isEmpty || deger.length < 6) {
                          return "Lütfen 6 karakterden uzun bir şifre giriniz";
                        }
                        return null;
                      },
                      controller: t3,
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
                          signUp(t1.text, t2.text, t3.text);

                          showMaterialDialog(
                            title: "Kayıt Başarılı",
                            content: "Başarılı bir şekilde kayıt oldunuz",
                            context: context,
                          );
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: Center(
                          child: Text(
                            "KAYIT OL",
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
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hesabım var",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => Login());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Text(
                            "Giriş Yap",
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
            ],
          ),
        ),
      ),
    );
  }
}
