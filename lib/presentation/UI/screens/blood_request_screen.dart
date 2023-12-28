
import 'package:blood_fighter/data/list/bloodList.dart';
import 'package:blood_fighter/data/list/distric_List.dart';
import 'package:blood_fighter/data/list/gender%20List.dart';
import 'package:blood_fighter/data/list/quantity_list.dart';
import 'package:blood_fighter/data/model/request_model.dart';
import 'package:blood_fighter/presentation/UI/screens/home_screen.dart';
import 'package:blood_fighter/presentation/UI/widgets/drop_down_widgets.dart';
import 'package:blood_fighter/presentation/state%20holders/blood_request_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BloodRequestScreen extends StatefulWidget {
  const BloodRequestScreen({Key? key}) : super(key: key);

  @override
  State<BloodRequestScreen> createState() => _BloodRequestScreenState();
}

class _BloodRequestScreenState extends State<BloodRequestScreen> {
  String districsDropdownValue = districtsList.first;
  String bloodDropdownValue = bloodList.first;
  String quantityDropdownValue = quantityList.first;
  String genderDropdownValue = gender.first;
  final TextEditingController _dateTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _patientConditionTEController = TextEditingController();
  final TextEditingController _hospitalTEController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _nameTEController,
                  validator: (String? value){
                    if(value!.isEmpty){
                      return "Enter patient name";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Enter Patient Name",

                  ),
                ),
                ///name
                const SizedBox(height: 12,),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _patientConditionTEController,
                  validator: (String? value){
                    if(value!.isEmpty){
                      return "Enter patient condition";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Enter Patient Condition",

                  ),
                ),
                /// condition
                const SizedBox(height: 12,),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _hospitalTEController,
                  validator: (String? value){
                    if(value!.isEmpty){
                      return "Enter Hospital Name";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Enter hospital Name",

                  ),
                ),
                ///hospital
                const SizedBox(height: 12,),
                DropDownWidgets(dropDownList: gender, onChanged: (value){genderDropdownValue = value;}, dropdownValue: genderDropdownValue),
                ///gender
              const SizedBox(height: 12,),
                DropDownWidgets(dropDownList: districtsList, onChanged: (value){
                  districsDropdownValue = value;
                  setState(() {
                  });
                }, dropdownValue: districsDropdownValue),
                ///location
                const SizedBox(height: 12,),
                DropDownWidgets(dropDownList: bloodList, onChanged: (value){
                  bloodDropdownValue = value;
                  setState(() {
                  });
                }, dropdownValue: bloodDropdownValue),
                /// blood group
                const SizedBox(height: 12,),
                DropDownWidgets(dropDownList: quantityList, onChanged: (value){
                  quantityDropdownValue = value;
                  setState(() {
                  });
                }, dropdownValue: quantityDropdownValue),
                /// blood quantity
                const SizedBox(height: 12,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _mobileTEController,
                  validator: (String? value){
                    if(value!.isEmpty && value.length !=11){
                      return "please Enter valid Mobile Number";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Mobile Number"
                  ),
                ),
                /// mobile number
                const SizedBox(height: 12,),
                TextFormField(
                  controller: _dateTEController,
                  onTap: (){
                    selectData();

                  },
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: Icon(Icons.calendar_month),
                      hintText: "Date"

                  ),
                  readOnly: true,

                ),
                /// select Date
                const SizedBox(height: 12,),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _descriptionTEController,
                  validator: (String? value){
                    if(value!.isEmpty){
                      return "Enter Additional details";
                    }
                    return null;
                  },
                  maxLines: 6,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Additional details",

                  ),
                ),
                /// descriotion
                const SizedBox(height: 12,),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<BloodRequestController>(
                    builder: (bloodRequestController) {
                      if(bloodRequestController.createRequestInProgress){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      return ElevatedButton(
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                            bloodRequestController.createRequest(
                                RequestModel(
                                    name: _nameTEController.text.trim(),
                                    patientCondition: _patientConditionTEController.text.trim(),
                                    location: districsDropdownValue,
                                    gender: genderDropdownValue,
                                    bloodGroup: bloodDropdownValue,
                                    mobile: _mobileTEController.text.trim(),
                                    date: _dateTEController.text.trim(),
                                    details: _descriptionTEController.text.trim(),
                                    quantity: int.parse(quantityDropdownValue),
                                    hospitalName: _hospitalTEController.text.trim()
                                )
                            );
                          }

                        },
                        child: const Text("Request Blood"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 13)
                        ),
                      );
                    }
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

 Future<void>  selectData() async {
  DateTime? _pickedDate= await  showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2100), context: context,
    );
  if(_pickedDate !=null){
    _dateTEController.text = _pickedDate.toString().split(" ")[0];
  }
  }
}
