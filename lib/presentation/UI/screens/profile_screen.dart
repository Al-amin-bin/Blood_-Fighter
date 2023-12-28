
import 'package:blood_fighter/data/model/user_model.dart';
import 'package:blood_fighter/presentation/UI/utility/app_color.dart';
import 'package:blood_fighter/presentation/UI/utility/image_asset.dart';
import 'package:blood_fighter/presentation/state%20holders/profile_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _database = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        actions: const [
          Icon(Icons.more_vert)
        ],
      ),

      body:SingleChildScrollView(
        child: GetBuilder<ProfileController>(
          builder: (profileController) {
            return FutureBuilder(
              future: profileController.getUser(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.hasData){
                    UserModel userdata = snapshot.data as UserModel;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
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
                                        child: const Icon(Icons.edit,size: 25,color:Colors.white,)))
                              ],
                            ),
                          ),
                          const SizedBox(height: 4,),
                          Center(child: Text(userdata.name,style:const TextStyle(fontSize: 24,fontWeight: FontWeight.w700))),
                          const SizedBox(height: 18,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Text("Donation Stutus :",style: Theme.of(context).textTheme.titleLarge,),
                            Switch(
                              value: userdata.donationStatus,
                              onChanged: (value) {
                                setState(() async {
                                  await _database.collection("User").doc(userdata.id).update({"donationStatus": value});
                                  setState(() {
                                  });
                                });
                              },
                            ),

                          ],),
                          Card(
                            child: ListTile(
                              leading: Icon(Icons.calendar_month,size: 32,color: AppColors.primaryColor,),
                              title: const Text("Last Donation Date"),
                              subtitle: Text(userdata.donationDate,style:Theme.of(context).textTheme.titleMedium,),
                              trailing: ElevatedButton(
                                style: ElevatedButton.styleFrom(

                                    shape: RoundedRectangleBorder(
                                        borderRadius:BorderRadius.circular(4)
                                    )
                                ),
                                onPressed: (){},
                                child: const Text("Update Date",style: TextStyle(fontSize: 14),),
                              ),
                            ),
                          ),
                          ///donation date

                          Card(
                            child: ListTile(
                                leading: Icon(Icons.email_rounded,size: 32,color: AppColors.primaryColor,),
                                title: Row(
                                  children: [
                                    const Text("Email Address"),
                                    const SizedBox(width: 6,),
                                    Container(
                                      color: AppColors.primaryColor,
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8),
                                        child: Text("verify",style: TextStyle(color: Colors.white),),
                                      ),
                                    )
                                  ],
                                ),
                                subtitle: Text(userdata.email,style:Theme.of(context).textTheme.titleMedium,),
                                trailing: IconButton(
                                  onPressed: (){},
                                  icon: const Icon((Icons.edit)),
                                )
                            ),
                          ),
                          ///email address card
                          Card(
                            child: ListTile(
                                leading: Icon(Icons.call,size: 32,color: AppColors.primaryColor,),
                                title: const Row(
                                  children: [
                                    Text("Contact Phone"),
                                  ],
                                ),
                                subtitle: Text(userdata.mobile,style:Theme.of(context).textTheme.titleMedium,),
                                trailing: IconButton(
                                  onPressed: (){},
                                  icon: const Icon((Icons.verified_user),color: Colors.green,),
                                )
                            ),
                          ),
                          ///contact card

                          /// title

                          Card(
                            child: ListTile(
                              leading: Icon(Icons.calendar_month,size: 32,color: AppColors.primaryColor,),
                              title: const Row(
                                children: [
                                  Text("Date Of Birth"),
                                ],
                              ),
                              subtitle: Text("02- Feb- 2002",style:Theme.of(context).textTheme.titleMedium,),

                            ),
                          ),
                          ///date of birth
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.generating_tokens_outlined,
                                    size: 32,
                                    color: AppColors.primaryColor,
                                  ),
                                  const SizedBox(width: 12,),
                                  Column(
                                    children: [
                                      const Text("Gender"),
                                      const SizedBox(height: 6,),
                                      Text(
                                        userdata.gender,
                                        style: Theme.of(context).textTheme.titleMedium,
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  SvgPicture.asset("${ImageAsset.iconPath}/bloodicon.svg"),
                                  const SizedBox(width: 10,),
                                  Column(
                                    children: [const Text("Blood Group"),
                                      const SizedBox(height: 4,),

                                      Text(userdata.bloodGroup,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600),)],
                                  )
                                ],
                              ),
                            ),
                          ),
                          /// gender

                          Card(
                            child: ListTile(
                              leading: Icon(Icons.location_on,size: 32,color: AppColors.primaryColor,),
                              title: Row(
                                children: [
                                  const Text("Current Address"),
                                  const Spacer(),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                                      child: Row(
                                        children: [
                                          Text("Pic Address",style: TextStyle(color: Colors.white),),
                                          Icon(Icons.location_on,color: Colors.white,)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              subtitle: Text(userdata.location,style:Theme.of(context).textTheme.titleMedium,),

                            ),
                          ),
                          /// location
                        ],
                      ),
                    );
                  }else if(snapshot.hasError){
                    return Center(child: Text(snapshot.error.toString()),);
                  }else{
                    return const Center(child: Text("Somethings went wrong"),);
                  }
                }else{
                  return const Center(child: CircularProgressIndicator(),);
                }
              },

            );
          }
        ),
      )
    );
  }
}
