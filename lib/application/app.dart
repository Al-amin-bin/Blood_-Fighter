
import 'dart:async';

import 'package:blood_fighter/application/state_holder_binders.dart';
import 'package:blood_fighter/data/Theme/dark_theme.dart';
import 'package:blood_fighter/data/Theme/light_theme.dart';
import 'package:blood_fighter/presentation/UI/screens/splash_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BloodFighter extends StatefulWidget {
  const BloodFighter({super.key});

  @override
  State<BloodFighter> createState() => _BloodFighterState();
}

class _BloodFighterState extends State<BloodFighter> {
  @override
  void initState() {
    checkInternetConnectivityStatus();
    super.initState();
  }

  late final StreamSubscription _connectivityStreamStatus;

  Future<void> checkInitialInternetConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    handleConnectivityState(result);
  }

  void checkInternetConnectivityStatus(){
    _connectivityStreamStatus = Connectivity().onConnectivityChanged.listen((status) {
      handleConnectivityState(status);
    });

  }

  void handleConnectivityState(ConnectivityResult status){
    if(status != ConnectivityResult.mobile && status != ConnectivityResult.wifi){
      Get.showSnackbar(const GetSnackBar(
        title: "No Internet",
        message: "Please Check your Connectivity",
        isDismissible: false,
      ));
    }else{
      if(Get.isSnackbarOpen){
        Get.closeAllSnackbars();
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      title: "Blood Fighter",
      debugShowCheckedModeBanner: false,
      home: const SplashScreen1(),
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      initialBinding: StateHolderBinders(),
    );
  }
}
