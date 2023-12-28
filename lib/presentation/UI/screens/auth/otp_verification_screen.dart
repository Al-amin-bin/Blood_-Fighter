import 'dart:async';
import 'package:blood_fighter/presentation/UI/screens/home_screen.dart';
import 'package:blood_fighter/presentation/UI/utility/app_color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _otpTEController = TextEditingController();
  @override
  void initState() {
    final CounterController counterController = Get.put(CounterController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
        body: SafeArea(

          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  const SizedBox(
                    height: 140,
                  ),
                  // Center(
                  //   child: SvgPicture.asset(
                  //     ImageAsset.bloodFighterSVG,
                  //     width: 100,
                  //   ),
                  // ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Enter OTP Code",
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 30,color: Colors.white),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "A-4 Digit Code has been Sent",
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  PinCodeTextField(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "please fill the code";
                      }
                      return null;
                    },
                    controller: _otpTEController,
                    keyboardType: TextInputType.number,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    length: 4,
                    backgroundColor: null,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        disabledColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        inactiveColor:Colors.white,
                        activeFillColor: Colors.white,
                        activeColor: Colors.white,
                        selectedColor: Colors.green),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,


                    onCompleted: (v) {},
                    onChanged: (value) {},
                    beforeTextPaste: (text) {
                      return true;
                    },
                    appContext: context,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white
                        ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {

                            }
                            Get.offAll(()=> HomeScreen());

                          },
                          child: const Text("Submit"))

                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  GetBuilder<CounterController>(builder: (controller) {
                    return RichText(
                      text: TextSpan(
                          style: const TextStyle(color: Colors.grey),
                          children: [
                            const TextSpan(
                              text: "This Code will expire in ",
                              style: TextStyle(color: Colors.white)
                            ),
                            TextSpan(
                                style: TextStyle(color: Colors.white),
                                text: "${controller.counter} S")
                          ]),
                    );
                  }),

                  TextButton(
                    onPressed: () async {

                    },
                    child: const Text(
                      "Resend Code",
                      style: TextStyle(color: Colors.white),
                    ),
                  )

                ]),
              ),
            ),
          ),
        ),
    );
  }
}
class CounterController extends GetxController {
  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  late Timer _timer;
  int _counter = 120;
  get counter => _counter;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        _counter--;
        update();
      } else {
        _timer.cancel();
      }
    });
  }
}