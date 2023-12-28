
import 'package:blood_fighter/presentation/UI/screens/auth/fogot_password_screen.dart';
import 'package:blood_fighter/presentation/UI/screens/auth/sinup_screen.dart';
import 'package:blood_fighter/presentation/UI/utility/image_asset.dart';
import 'package:blood_fighter/presentation/state%20holders/signIn_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: Image.asset(
                      ImageAsset.bloodFighterLogoPng,
                      width: 300,
                    ),
                  ),

                  /// logo
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Get Started With",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _emailTEController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Enter Your Email address";
                      } else if (value.isEmail == false) {
                        return "Enter A valid Email address";
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter Your Email",
                        prefixIcon: Icon(Icons.email_outlined,color: Colors.black,)),
                  )

                  /// email textfill
                  ,
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.text,
                    obscureText: _obscureText,
                    controller: _passwordTEController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Enter Your Password";
                      } else if (value.length < 5) {
                        return "Enter 6 digit password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: const Icon(Icons.lock,color: Colors.black,),
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {});
                              _obscureText = !_obscureText;
                            },
                            child: _obscureText
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility)),
                        hintText: "password"),
                  ),

                  ///password text fill
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          Get.to(()=> const ForgotPasswordScreen());
                        }, child: const Text("Forgot Password")),
                  ),
                  GetBuilder<SignInController>(builder: (signInController) {
                    if (signInController.signInProgress) {
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              signInController.signIn(
                                  _emailTEController.text.trim(),
                                  _passwordTEController.text);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15)),
                          child: const Text("Sign In"),
                        ));
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't Have an Account!"),
                      TextButton(
                          onPressed: () {
                            Get.off(() => const SignUpScreen());
                          },
                          child: const Text("Sign Up"))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
