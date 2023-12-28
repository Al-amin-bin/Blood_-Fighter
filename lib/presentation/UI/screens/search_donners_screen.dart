
import 'package:blood_fighter/data/list/bloodList.dart';
import 'package:blood_fighter/data/list/distric_List.dart';
import 'package:blood_fighter/presentation/UI/screens/search_result_screen.dart';
import 'package:blood_fighter/presentation/UI/utility/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/drop_down_widgets.dart';

class SearchDonnerScreen extends StatefulWidget {
  const SearchDonnerScreen({super.key});

  @override
  State<SearchDonnerScreen> createState() => _SearchDonnerScreenState();
}

class _SearchDonnerScreenState extends State<SearchDonnerScreen> {

  String bloodDropdownValue = bloodList.first;
  String districsDropdownValue = districtsList.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Donors"),
      ),
      body:SingleChildScrollView(
        child: Container(

          width: MediaQuery.of(context).size.width,
          decoration: ShapeDecoration(
            color:AppColors.primaryColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  'Choose Blood group',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                const SizedBox(height: 12,),
               DropDownWidgets(dropDownList: bloodList, onChanged: (value){
                 bloodDropdownValue = value;
                 setState(() {
                 });
               }, dropdownValue: bloodDropdownValue),
                const SizedBox(height: 22,),
                const Text(
                  'Location',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                const SizedBox(height: 12,),
                DropDownWidgets(dropDownList: districtsList, onChanged: (value){
                  districsDropdownValue = value;
                  setState(() {
                  });
                }, dropdownValue: districsDropdownValue),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: 130,
                    child: ElevatedButton(
                        onPressed: (){
                          Get.to(()=> SearchResultScreen(bloodGroup: bloodDropdownValue, location: districsDropdownValue,));
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 13,vertical: 14),
                          textStyle: const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24)),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 10
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search),
                            Text("Search"),
                          ],
                        )),
                  ),
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }

}
