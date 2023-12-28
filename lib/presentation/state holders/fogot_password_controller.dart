import 'dart:ui';

import 'package:blood_fighter/presentation/UI/screens/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController{
  bool _forgotPasswordInProgress = false;
  bool get forgotPasswordInProgress => _forgotPasswordInProgress;
  final _auth = FirebaseAuth.instance;
  
  Future<void> fogotPassword(String email) async {
    _forgotPasswordInProgress= true;
    update();
    await _auth.sendPasswordResetEmail(email: email).then((value){
      Get.snackbar("Success", "We have send to your email recover password, Please Check your Email",backgroundColor:Colors.green.withOpacity(0.5));
      Get.off(()=>LoginScreen());

    }).onError((error, stackTrace){
      print(error);
    });
    _forgotPasswordInProgress = false;
    update();
    
  }
}