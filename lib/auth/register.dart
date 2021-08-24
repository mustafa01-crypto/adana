import 'package:adana/constants/constants.dart';
import 'package:adana/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  TextEditingController t4 = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  static final _auth = FirebaseAuth.instance;
  static final store = FirebaseFirestore.instance;
  bool _passwordVisible = true;
  bool _passwordVisible2 = true;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _passwordVisible2 = false;
  }

  DateTime timeDifference = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                          colors: [
                            topBack,
                            centerBack,
                            bottomBack
                          ]),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 1 / 10,
                    ),
                    Text(
                      'KAYIT EKRANI',
                      style: loginTitle
                    ),
                    SizedBox(
                      height: size.height * 1 / 15,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        style: TextStyle(
                            color: kutu, fontWeight: FontWeight.w300),
                        decoration: InputDecoration(
                          hintText: "Ad Soyad",
                          hintStyle: TextStyle(color: kutu),
                          labelText: "Ad-Soyad",
                          labelStyle: TextStyle(color: kutu),
                          fillColor: kutu,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: kutu,
                              style: BorderStyle.solid,
                              width: 1.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: kutu,
                              style: BorderStyle.solid,
                              width: 1.5,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: kutu,
                          ),
                        ),
                        controller: t1,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 1 / 25,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                            color: kutu, fontWeight: FontWeight.w300),
                        decoration: InputDecoration(
                          hintText: "Email Adresi",
                          hintStyle: TextStyle(color: kutu),
                          labelText: "Email",
                          labelStyle: TextStyle(color: kutu),
                          fillColor: kutu,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: kutu,
                              style: BorderStyle.solid,
                              width: 1.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: kutu,
                              style: BorderStyle.solid,
                              width: 1.5,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: kutu,
                          ), // icon is 48px widget.
                          //fillColor: Colors.green
                        ),
                        validator: (val) {
                          if (!GetUtils.isEmail(val!))
                            return "Geçersiz email adresi";
                          else
                            return null;
                        },
                        controller: t2,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 1 / 25,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        style: TextStyle(
                            color: kutu, fontWeight: FontWeight.w300),
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          hintText: "Parola",
                          hintStyle: TextStyle(color: kutu),
                          labelText: "Parola",
                          labelStyle: TextStyle(color:kutu),
                          fillColor: kutu,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: kutu,
                              style: BorderStyle.solid,
                              width: 1.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: kutu,
                              style: BorderStyle.solid,
                              width: 1.5,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: kutu,
                          ),
                          suffixIcon: IconButton(
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
                        controller: t3,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 1 / 25,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        style: TextStyle(
                            color: kutu, fontWeight: FontWeight.w300),
                        obscureText: !_passwordVisible2,
                        decoration: InputDecoration(
                          hintText: "Parola Yeniden",
                          hintStyle: TextStyle(color:kutu),
                          labelText: "Parola",
                          labelStyle: TextStyle(color: kutu),
                          fillColor: kutu,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: kutu,
                              style: BorderStyle.solid,
                              width: 1.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: kutu,
                              style: BorderStyle.solid,
                              width: 1.5,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: kutu,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(_passwordVisible2
                                ? Icons.visibility
                                : Icons.visibility_off),
                            color: kutu,
                            onPressed: () {
                              setState(() {
                                _passwordVisible2 = !_passwordVisible2;
                              });
                            },
                          ),
                        ),
                        validator: (deger) {
                          if (t3.text != deger) {
                            return "Parolanız eşleşmiyor";
                          }
                          return null;
                        },
                        controller: t4,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 1 / 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            store.collection('users').doc(t2.text).set({
                              'name': t1.text,
                              'email': t2.text,
                              'parola': t3.text
                            });
                            _auth
                                .createUserWithEmailAndPassword(
                                    email: t2.text, password: t3.text)
                                .then(
                                  (value) => Get.to(() => Home()),
                                );
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: Center(
                            child: Text(
                              "KAYIT OL",
                              style: loginButton
                            ),
                          ),
                          decoration: BoxDecoration(
                            gradient: buttonBoxGradient,
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
                          style: loginText
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => Login());
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Text(
                              "Giriş Yap",
                              style: loginTextUnderlined
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
      ),
    );
  }
}
