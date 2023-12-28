
import 'package:blood_fighter/data/repository/authentication_repository.dart';
import 'package:blood_fighter/presentation/UI/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({super.key});

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  void initState() {
    super.initState();
    goToNextScreen();
  }
  goToNextScreen(){
  Future.delayed(const Duration(seconds: 3)).then((value){
    // Get.put(AuthenticationRepository());
    Get.find<AuthenticationRepository>().checkUser();
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SafeArea(
       child: Column(
         children: [
           const Spacer(),
           Center(child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 12),
             child: Image.asset("asset/images/Blood-logo.png",),
           ),),
           const Spacer(),
           const CircularProgressIndicator(color: Color(0xFFEC718D),),
           const SizedBox(height: 15,),
           const Text("Version 1.1.0",style: TextStyle(fontSize: 16,color: Colors.black),),
           const SizedBox(height: 15,)

         ],
       ),
     ),
    );
  }
}
