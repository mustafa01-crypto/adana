import 'package:adana/components/button_box.dart';
import 'package:adana/components/form_text.dart';
import 'package:adana/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                          colors: [topBack, centerBack, bottomBack]),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 1 / 7,
                    ),
                    Text('KAYIT EKRANI', style: loginTitle),
                    SizedBox(
                      height: size.height * 1 / 16,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        style:
                            TextStyle(color: kutu, fontWeight: FontWeight.w300),
                        decoration: formDecoration(
                            "Ad Soyad",
                            "Ad-Soyad",
                            Icon(
                              Icons.person,
                              color: kutu,
                            ),
                            SizedBox()),
                        controller: t1,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 1 / 30,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
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
                        controller: t2,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 1 / 30,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
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
                        controller: t3,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 1 / 30,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        style:
                            TextStyle(color: kutu, fontWeight: FontWeight.w300),
                        obscureText: !_passwordVisible2,
                        decoration: formDecoration(
                          "Parola Yeniden",
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
                          if (t3.text != deger) {
                            return "Parolanız eşleşmiyor";
                          }
                          return null;
                        },
                        controller: t4,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 1 / 30,
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
                                    (value) => Get.toNamed("/home"),
                                  );
                            }
                          },
                          child: buttonBox(context, "KAYIT OL")),
                    ),
                    SizedBox(
                      height: size.height * 1 / 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Hesabım var", style: loginText),
                        TextButton(
                          onPressed: () {
                            Get.toNamed("/login");
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child:
                                Text("Giriş Yap", style: loginTextUnderlined),
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
