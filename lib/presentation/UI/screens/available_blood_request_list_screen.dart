import 'package:blood_fighter/data/model/user_model.dart';
import 'package:blood_fighter/data/repository/authentication_repository.dart';
import 'package:blood_fighter/data/repository/blood_request_repository.dart';
import 'package:blood_fighter/presentation/UI/screens/profile_screen.dart';
import 'package:blood_fighter/presentation/UI/utility/app_color.dart';
import 'package:blood_fighter/presentation/state%20holders/blood_request_controller.dart';
import 'package:blood_fighter/presentation/state%20holders/profile_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AvailableBloodRequestScreen extends StatefulWidget {
  const AvailableBloodRequestScreen({super.key});

  @override
  State<AvailableBloodRequestScreen> createState() => _AvailableBloodRequestScreenState();
}

class _AvailableBloodRequestScreenState extends State<AvailableBloodRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:GetBuilder<BloodRequestController>(
        builder: (bloodRequestController) {
          return FutureBuilder(
            future: bloodRequestController.getAllRequest(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasData){
                  return ListView.separated(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                          child: Container(
                            width: double.infinity,
                            height: 240,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Colors.white.withOpacity(0.8),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Color(0xFF868484)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        width: 70,
                                        height: 93,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFFFEFEF),
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                width: 1, color: Color(0xFFFFF9F9)),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                             Center(
                                              child: Text(
                                                snapshot.data![index].bloodGroup,
                                                style: const TextStyle(
                                                  color: Color(0xFFD9214B),
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w700,
                                                  height: 0,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              child: SvgPicture.asset(
                                                  "asset/images/icon/bloodicon.svg"),
                                            ),

                                             Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 6),
                                                child: Text(
                                                  "${snapshot.data![index].quantity} Beg".toString(),
                                                  style: const TextStyle(
                                                    color: Color(0xFF999999),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    height: 0,
                                                  ),
                                                ),
                                              ),

                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    /// blood group stack
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 12),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width - 170,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                 Text(
                                                  snapshot.data![index].gender,
                                                  style: const TextStyle(
                                                    color: Color(0xFF490008),
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w500,
                                                    height: 0,
                                                  ),
                                                ),
                                                const Spacer(),
                                                GetBuilder<ProfileController>(
                                                    builder: (profileController) {
                                                      return FutureBuilder(
                                                        future: profileController.getUser(),
                                                        builder: (context, snapshotData) {
                                                          if(snapshotData.connectionState == ConnectionState.done){
                                                            if(snapshotData.hasData){
                                                              UserModel userdata = snapshotData.data as UserModel;
                                                              return FittedBox(
                                                                child: ElevatedButton(
                                                                    onPressed: () async {
                                                                      DateTime now = DateTime.now();
                                                                      DateTime threeMonthsAgo = now.subtract(const Duration(days: 3 * 30));
                                                                      final dataBase = FirebaseFirestore.instance;
                                                                      String donateDate = userdata.donationDate;
                                                                      if(donateDate == "Not Yet"){
                                                                        await dataBase.collection("RequestData").doc(snapshot.data![index].id).update({"quantity": snapshot.data![index].quantity - 1});
                                                                        await dataBase.collection("User").doc(userdata.id).update({"donationDate": "${now.year}-${now.month}-${now.day}"});
                                                                        Get.snackbar("Success", "You Donate blood for ${snapshot.data![index].name} ",backgroundColor: Colors.green.withOpacity(.7),colorText: Colors.white);
                                                                        setState(() {});
                                                                      }else {
                                                                        DateTime dateTime = DateTime.parse(donateDate);
                                                                        if (dateTime.isBefore(threeMonthsAgo)) {
                                                                          await dataBase.collection("RequestData").doc(snapshot.data![index].id).update({"quantity": snapshot.data![index].quantity - 1});
                                                                          await dataBase.collection("User").doc(userdata.id).update({"donationDate": "${now.year}-${now.month}-${now.day}"});
                                                                          Get.snackbar("Success", "You Donate blood for ${snapshot.data![index].name} ",backgroundColor: Colors.green.withOpacity(.7),colorText: Colors.white);
                                                                          setState(() {});
                                                                        } else {
                                                                          Get.snackbar("Opps!", "You Not Available to donate",backgroundColor: Colors.green.withOpacity(.7),colorText: Colors.white);
                                                                        }
                                                                      }

                                                                    },
                                                                    child: const Text("Donate")),
                                                              );
                                                            }else if(snapshotData.hasError){
                                                              return const Center(child: Text("Check Internet Connection"),);
                                                            }else{
                                                              return const Center(child:  Text("Empty List"),);
                                                            }
                                                          }else{
                                                            return const Center(child: CircularProgressIndicator(),);
                                                          }

                                                        },
                                                      );
                                                    }
                                                ),

                                              ],
                                            ),
                                            const SizedBox(height: 4,),
                                             Row(
                                              children: [
                                                const Icon(Icons.person,size: 22,color: Colors.black,),
                                                const SizedBox(width: 5,),
                                                Text(
                                                  snapshot.data![index].name,
                                                  style: const TextStyle(
                                                    color: Color(0xFF868484),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    height: 0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4,),
                                            Row(
                                              children: [
                                                const Icon(Icons.local_hospital,size: 22,color: Colors.black,),
                                                const SizedBox(width: 5,),
                                                Text(
                                                   snapshot.data![index].hospitalName,
                                                  style: const TextStyle(
                                                    color: Color(0xFF868484),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,overflow: TextOverflow.ellipsis

                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4,),
                                             Row(
                                              children: [
                                                const Icon(Icons.location_pin,size: 22,color: Colors.black,),
                                                const SizedBox(width: 5,),
                                                Text(
                                                  "${snapshot.data![index].location},",
                                                  style: const TextStyle(
                                                    color: Color(0xFF868484),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,

                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4,),
                                             Row(
                                              children: [
                                                const Icon(Icons.call,size: 18,color: Colors.black,),
                                                const SizedBox(width: 5,),
                                                Text(
                                                  snapshot.data![index].mobile,
                                                  style: const TextStyle(
                                                    color: Color(0xFF868484),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4,),
                                             Row(
                                              children: [
                                                const Icon(Icons.control_point_duplicate_rounded,size: 18,color: Colors.black,),
                                                const SizedBox(width: 5,),
                                                Text(
                                                  snapshot.data![index].patientCondition,
                                                  style: const TextStyle(
                                                    color: Color(0xFF868484),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 4,),

                                            Row(
                                              children: [
                                                const Text(
                                                  'Time Limit:',
                                                  style: TextStyle(
                                                    color: Color(0xFF868484),
                                                    fontSize: 12,

                                                    fontWeight: FontWeight.w600,

                                                  ),
                                                ),
                                                const SizedBox(width: 5,),
                                                Container(
                                                  width: 75,
                                                  height: 25,
                                                  decoration: ShapeDecoration(
                                                    color: AppColors.primaryColor,
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      snapshot.data![index].date,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w700,
                                                        height: 0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                InkWell(
                                                    onTap: () async {
                                                      final Uri url =Uri(
                                                          scheme: "tel",
                                                          path: snapshot.data![index].mobile
                                                      );
                                                      if(await canLaunchUrl(url)){
                                                        await launchUrl(url);
                                                      }else{
                                                        print("cnanot");
                                                      }

                                                    },
                                                    child: Icon(Icons.call,color: AppColors.primaryColor,)),
                                                SizedBox(width: 8,)

                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_,__){
                        return const SizedBox(height: 2,);
                      } );
                }else if(snapshot.hasError){
                  return Center(child: Text(snapshot.hasError.toString()),);
                }else{
                  return const Center(child: Text("Somethings went wrong"),);
                }
              }
              else{
                return const Center(child: CircularProgressIndicator(),);
              }
            },

          );
        }
      )



    );
  }

}
