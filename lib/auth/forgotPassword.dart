import 'package:adana/components/button_box.dart';
import 'package:adana/components/form_text.dart';
import 'package:adana/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

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
                        colors: [topBack, centerBack, bottomBack]),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(top: 4.h, left: 4.w),
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
                    height: 8.33.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w300),
                      decoration: formDecoration(
                          "E-mail Adresi",
                          "E-mail",
                          Icon(
                            Icons.email,
                            color: kutu,
                          ),
                          SizedBox()),
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
                    height: 3.33.h,
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 2.5.w),
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
                            Get.toNamed("/login");
                          });
                        }
                      },
                      child: buttonBox(context, "İSTEK GÖNDER"),
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
