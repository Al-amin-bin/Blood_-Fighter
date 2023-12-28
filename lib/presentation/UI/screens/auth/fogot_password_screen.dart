import 'package:blood_fighter/presentation/state%20holders/fogot_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController _emailTEConroller = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset("asset/images/forgot.PNG",height: 180,width: 140,),
              const SizedBox(height: 24,),
              TextFormField(
                controller: _emailTEConroller,
                validator: (String? value){
                  if(value!.isEmpty){
                    return "Enter Your Email";
                  }else if(value.isEmail== false){
                    return "Enter Valid Email";
                }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Enter Your Email"
                ),
              ),
              const SizedBox(height: 8,),
              SizedBox(
                width: double.infinity,
                child: GetBuilder<ForgotPasswordController>(
                  builder: (forgotPasswordController) {
                    if(forgotPasswordController.forgotPasswordInProgress){
                      return Center(child: CircularProgressIndicator(),);
                    }
                    return ElevatedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          forgotPasswordController.fogotPassword(_emailTEConroller.text.trim());
                        }

                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16)
                      ),
                      child: const Text("Forgot Password"),
                    );
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
