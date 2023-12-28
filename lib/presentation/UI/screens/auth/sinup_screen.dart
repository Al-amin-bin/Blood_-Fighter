
import 'package:blood_fighter/data/list/bloodList.dart';
import 'package:blood_fighter/data/list/distric_List.dart';
import 'package:blood_fighter/data/list/gender%20List.dart';
import 'package:blood_fighter/data/model/user_model.dart';
import 'package:blood_fighter/presentation/UI/screens/auth/login_screen.dart';
import 'package:blood_fighter/presentation/UI/utility/app_color.dart';
import 'package:blood_fighter/presentation/UI/widgets/drop_down_widgets.dart';
import 'package:blood_fighter/presentation/state%20holders/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTeController = TextEditingController();
  final TextEditingController _phoneTeController = TextEditingController();
  final TextEditingController _passwordTeController = TextEditingController();
  final TextEditingController _confirmPasswordTeController = TextEditingController();
  final TextEditingController _nameTeController = TextEditingController();
  bool _obscureText= true;
  bool _confirmObscureText= true;
  int _selectedColorIndex = 0;
  int _selectedGender = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String districDropdownValue = districtsList.first;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 18,),
                  Center(
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 120,
                          width: 120,
                          child: ClipRRect(borderRadius: BorderRadius.circular(100),
                            child: Image.asset("asset/images/userman.png"),),
                        ),
                        Positioned(
                          bottom: 0,
                            right: 5,
                            child: Container(
                              height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(100)
                                ),
                                child: const Icon(Icons.camera_alt,size: 25,color:Colors.white,)))
                      ],
                    ),
                  ),

                  /// profile picture complete
                  const SizedBox(height: 60,),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _nameTeController,
                    style: const TextStyle(color: Colors.black),
                    validator: (String? value){
                      if(value!.isEmpty){
                        return "Enter Your full name";
                      }
                      return null;
                    },
                    decoration:  const InputDecoration(
                        hintText: "Enter Your full Name",
                      fillColor: Colors.white,
                      filled: true
                    ),
                  ),
                  ///name Text filed
                  const SizedBox(height: 12,),
                  DropDownWidgets(dropDownList: districtsList, onChanged: (value){
                    districDropdownValue = value;
                    setState(() {
                    });
                  }, dropdownValue: districDropdownValue),
                  /// location dropdown
                  const SizedBox(height: 12,),
                  Text("Gender",style: Theme.of(context).textTheme.titleLarge,),
                  const SizedBox(height: 12,),

                  SizedBox(
                    height: 80,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: genderList.length,
                      itemBuilder: (context, index){
                        return InkWell(
                            onTap: (){
                              _selectedGender= index;
                              if(mounted){
                                setState(() {
                                });
                              }
                            },
                            child:Column(
                              children: [
                                Container(
                                  width: 58,
                                  height: 58,
                                  decoration: ShapeDecoration(

                                    image:    DecorationImage(
                                      image: AssetImage(
                                          "${genderList[index].imgUrl}"),
                                      fit: BoxFit.cover,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),const Spacer(),
                                 Text(
                                  genderList[index].title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:  _selectedGender == index ? AppColors.primaryColor:null,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,

                                  ),
                                ),
                              ],
                            ),



                        );
                      }, separatorBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          const SizedBox(width: 50,),
                          Container(
                            height: 50,
                            width: 2,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 50,),
                        ],
                      );
                    },),

                  ),
                  /// select gender
                  const SizedBox(height: 12,),
                  Text("Select Blood Group",style: Theme.of(context).textTheme.titleLarge,),
                  const SizedBox(height: 12,),
              SizedBox(
                height: 70,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: bloodList.length,
                  itemBuilder: (context, index){
                    return InkWell(
                      onTap: (){
                      _selectedColorIndex = index;
                        if(mounted){
                          setState(() {
                          });
                        }
                      },
                      child:Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(

                          border: Border.all(),
                          color: _selectedColorIndex == index ? AppColors.primaryColor:null,
                          borderRadius: BorderRadius.circular(100),

                        ),
                        child: Center(child: Text(bloodList1[index],style: const TextStyle(fontSize: 24,fontWeight: FontWeight.w600),)),
                      )



                      );
                  }, separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(width: 10,);
                },),

              ),
                  /// blood group listview
                  const SizedBox(height: 12,),

                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _emailTeController,
                    style: const TextStyle(color: Colors.black),
                    validator: (String? value){
                      if(value!.isEmpty){
                        return "Enter Your Email";
                      }else if(value.isEmail== false){
                        return "Enter a valid Email Address";
                      }
                      return null;

                    },
                    decoration:  const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.email_outlined),
                        // label: Text("Email")
                      hintText: "Enter Your Email",

                    ),
                  ),
                  /// email Text filed
                  const SizedBox(height: 12,),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _phoneTeController,
                    style: const TextStyle(color: Colors.black),
                    validator: (String? value){
                      if(value!.isEmpty){
                        return "Enter Your Phone Number";
                      }else if(value.length !=11){
                        return "Enter A valid Phone Number";
                      }
                      return null;

                    },
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                      prefixIcon: Icon(Icons.phone),
                        hintText: "Phone Number"
                    ),
                  ),
                  /// mobile text field
                  const SizedBox(height: 12,),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: _obscureText,
                    style: const TextStyle(color: Colors.black),
                    controller: _passwordTeController,
                    validator: (String? value){
                      if(value!.isEmpty){
                        return "Enter Your Password";
                      }else if(value.length <5){
                        return "Enter  6 digit password";
                      }
                      return null;

                    },
                    decoration:  InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(Icons.lock),
                        suffixIcon: InkWell(
                            onTap:(){
                              setState(() {
                              });
                              _obscureText = !_obscureText;
                            },
                            child:_obscureText? const Icon(Icons.visibility_off):const Icon(Icons.visibility)),
                        hintText: "password"
                    ),
                  ),
                  const SizedBox(height: 12,),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: _confirmObscureText,
                    style: const TextStyle(color: Colors.black),
                    controller: _confirmPasswordTeController,
                    validator: (String? value){
                      if(value!.isEmpty){
                        return "Enter Your Confirm Password";
                      }else if(_passwordTeController ==_confirmPasswordTeController ){
                        return "No match Password";
                      }
                      return null;

                    },
                    decoration:  InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.lock),
                        suffixIcon: InkWell(
                            onTap:(){
                              setState(() {
                              });
                              _confirmObscureText = !_confirmObscureText;
                            },
                            child:_confirmObscureText? const Icon(Icons.visibility_off):const Icon(Icons.visibility)),
                        hintText: " Confirm password"
                    ),
                  ),
                  /// password


                  const SizedBox(height: 12,),
                  SizedBox(
                    width: double.infinity,
                    child: GetBuilder<SignUpController>(
                      builder: (signUpController) {
                        if(signUpController.signUpInProgress){
                          return const Center(child: CircularProgressIndicator(),);
                        }
                        return ElevatedButton(
                          onPressed: (){
                            if(_formKey.currentState!.validate()){
                              UserModel user = UserModel(
                                  name: _nameTeController.text.trim(),
                                  location: districDropdownValue,
                                  gender: genderList[_selectedGender].title,
                                  bloodGroup: bloodList1[_selectedColorIndex],
                                  email: _emailTeController.text.trim(),
                                  mobile: _phoneTeController.text.trim(),
                                  password: _confirmPasswordTeController.text,
                                  donationDate: 'Not Yet',
                                  donationStatus: false);
                              signUpController.createUser(user);
                            }
                            // Get.off(()=> const OtpVerificationScreen());
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15)
                          ),
                          child: const Text("Sign Up"),
                        );
                      }
                    )
                  ),
                  /// button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Have an Account!"),
                      TextButton(onPressed: (){
                        Get.off(()=> const LoginScreen());
                      }, child: const Text("Sign In"))
                    ],)

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
