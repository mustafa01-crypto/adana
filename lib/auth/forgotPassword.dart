import 'package:adana/auth/login.dart';
import 'package:adana/components/mainAppBar.dart';
import 'package:adana/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  TextEditingController t1 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 32,left: 24),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: 40,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height /16,
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
                      controller: t1,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {

                          _auth.sendPasswordResetEmail(email: t1.text);

                          Get.snackbar(
                            "İşlem Başarılı",
                            'Şifrenizi yenilemeniz için email hesabınıza'
                                'gelen şifre yenileme işlemini tamamlayınız',
                            backgroundColor: Colors.grey.shade200,
                            snackPosition: SnackPosition.BOTTOM,
                          );

                          Future.delayed(Duration(seconds: 5), () {
                            Get.to(() => Login());
                          });



                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: Center(
                          child: Text(
                            "İSTEK GÖNDER",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 25),
                          ),
                        ),
                        decoration: BoxDecoration(
                          gradient:   buttonBoxGradient,
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

                ],
              )
            ],

          ),
        ),
      ),
    );
  }
}
