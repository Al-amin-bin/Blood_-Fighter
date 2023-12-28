import 'package:blood_fighter/presentation/UI/utility/app_color.dart';
import 'package:flutter/material.dart';

ThemeData darkTheme (){
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.red,
    primarySwatch:
    MaterialColor(AppColors.primaryColor.value, AppColors().color),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.black),
      contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 18),
      border:
      OutlineInputBorder(borderRadius: BorderRadius.circular(30),borderSide: BorderSide(color: Colors.grey,)),
      enabledBorder:
      OutlineInputBorder(borderRadius: BorderRadius.circular(30),borderSide: BorderSide(color: Colors.grey)),
      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.grey),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,

        // padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle:
        const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)),
      ),
    ),

  );
}
