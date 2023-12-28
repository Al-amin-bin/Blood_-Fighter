
import 'package:blood_fighter/data/list/dashbord_data_list.dart';
import 'package:blood_fighter/data/model/user_model.dart';
import 'package:blood_fighter/presentation/UI/screens/Ambulance_list_screen.dart';
import 'package:blood_fighter/presentation/UI/screens/DoctorListScreen.dart';
import 'package:blood_fighter/presentation/UI/screens/Nurse_list_screen.dart';
import 'package:blood_fighter/presentation/UI/screens/bloog_screen.dart';
import 'package:blood_fighter/presentation/UI/screens/hospital_list_screen.dart';
import 'package:blood_fighter/presentation/UI/screens/profile_screen.dart';
import 'package:blood_fighter/presentation/UI/screens/request_tabbar.dart';
import 'package:blood_fighter/presentation/UI/screens/search_donners_screen.dart';
import 'package:blood_fighter/presentation/UI/utility/image_asset.dart';
import 'package:blood_fighter/data/repository/authentication_repository.dart';
import 'package:blood_fighter/presentation/state%20holders/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool light =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            "Dashbord",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          )),

        ),

        ///complete Appbar//

        drawer:  const SafeArea(
          child: Drawer(
            child: Column(
              children: [
                DrawerTitle(),
                SizedBox(
                  height: 12,
                ),
                DrawerList(),
              ],
            ),
          ),
        ),

        /// complete drawer


        body: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 10,
                ),
                itemCount: dashBordList.length,
                itemBuilder: (context, index) {
                  return FittedBox(
                      child: GestureDetector(
                    onTap: () async {
                      if (dashBordList[index].id == 1) {
                        Get.to(()=>const SearchDonnerScreen());
                      } else if (dashBordList[index].id == 2) {
                        Get.to(()=> const RequestTapBar());
                      } else if (dashBordList[index].id == 3) {
                        Get.to(()=> const DoctorListScreen());
                      } else if (dashBordList[index].id == 4) {
                        Get.to(()=> const AmbulanceListScreen());
                      } else if (dashBordList[index].id == 5) {
                        Get.to(()=> const HospitalListScreen());
                      } else if (dashBordList[index].id == 6) {
                        Get.to(()=> const NurseListScreen());
                      } else if (dashBordList[index].id == 7) {
                        goToCall();

                      } else if (dashBordList[index].id == 8) {
                        Get.to(()=> const BloogScreen());
                      }
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).width / 2 - 45,
                        width: MediaQuery.sizeOf(context).width / 2 - 45,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              dashBordList[index].imgUrl,
                              height: 40,
                              width: 40,
                            ),
                            Text(
                              dashBordList[index].title,
                              style: const TextStyle(fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
                })));
    /// complete body
  }

  Future<void> goToCall() async {
    final Uri url =Uri(
        scheme: "tel",
        path: "999"
    );
    if(await canLaunchUrl(url)){
    await launchUrl(url);
    }else{
    print("cnanot");
    }
  }
}

class DrawerList extends StatefulWidget {

  const DrawerList({
    super.key,
  });

  @override
  State<DrawerList> createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  @override
  void initState() {
    super.initState();
    _getThemeStatus();
  }
  RxBool _isLightTheme = false.obs;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  _saveThemeStatus() async {
    SharedPreferences pref = await _prefs;
    pref.setBool('theme', _isLightTheme.value);
  }
  _getThemeStatus() async {
    var _isLight = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('theme') != null ? prefs.getBool('theme') : true;
    }).obs;
    _isLightTheme.value = (await _isLight.value)!;
    Get.changeThemeMode(_isLightTheme.value ? ThemeMode.light : ThemeMode.dark);
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
    child:Column(
      children: [
        ListTile(
          onTap: (){
            Get.back();
            Get.to(()=>const ProfileScreen());
          },
          leading: const Icon(Icons.person,size: 38,),
          title: const Text("Profile",style: TextStyle(fontSize: 16),),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        ListTile(
          leading: Icon(Icons.sunny),
          title: const Text("Change Theme",style: TextStyle(fontSize: 16),),
          trailing: ObxValue(
                (data) => Switch(
              value: _isLightTheme.value,
              onChanged: (val) {
                _isLightTheme.value = val;
                Get.changeThemeMode(
                  _isLightTheme.value ? ThemeMode.light : ThemeMode.dark,
                );
                _saveThemeStatus();
              },
            ),
            false.obs,
          ),
        ),
        ListTile(
          onTap: (){

            Share.share('Check out this awesome Flutter app!');
          },
          leading: const Icon(Icons.share),
          title: const Text("Share",style: TextStyle(fontSize: 16),),
        ),
        ListTile(
          onTap: (){
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const Ratting();
              },
            );
          },
          leading: const Icon(Icons.star_rate),
          title: const Text("Rate The App",style: TextStyle(fontSize: 16),),
        ),
        ListTile(
          onTap: (){
            showDialog(context: context,
              builder: (BuildContext context){
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius:  BorderRadius.circular(25)
                ),

                title: const Text('Privacy & Policy'),
                content: const Text('Creative Software built the Blood Fighter app as a Free app. This SERVICE is provided by Creative Software at no cost and is intended for use as isThis page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Blood Fighter unless otherwise defined in this Privacy Policy.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      // Close the AlertDialog
                     Get.back();
                    },
                    child: const Text('OK',style: TextStyle(color: Colors.green),),
                  ),

                ],
              );

              }

            );
          },
          leading: Image.asset(
            "${ImageAsset.iconPath}/privacy-policy.png",
            height: 33,
            width: 40,
          ),
          title: const Text("Privacy policy",style: TextStyle(fontSize: 16),),
        ),


        Container(
          height: 2,
          width: double.infinity,
            color: Colors.grey,
        ),
        ListTile(
          onTap: (){
            Get.back();
            AuthenticationRepository.instance.logOut();
          },
          leading: const Icon(Icons.logout),
          title: const Text("Log Out",style: TextStyle(fontSize: 16),),
        ),
      ],
    )
    );

    }

  Future<void> goToEmergencyCall() async {
    final Uri url =Uri(
        scheme: "tel",
        path: "999"
    );
    if(await canLaunchUrl(url)){
    await launchUrl(url);
    }else{
    print("cnanot");
    }
  }
}

class Ratting extends StatelessWidget {
  const Ratting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius:  BorderRadius.circular(25)
      ),

      title: const Text('Please Rate This Application'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('This will help to make better Feature'),
      const SizedBox(height: 8,),
       RatingBar.builder(
        initialRating: 3,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          print(rating);
        },
      )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Close the AlertDialog
            Navigator.of(context).pop();
          },
          child: const Text('OK',style: TextStyle(color: Colors.green),),
        ),
        TextButton(
          onPressed: () {
            // Close the AlertDialog
            Navigator.of(context).pop();
          },
          child: const Text('cancel'),
        ),
      ],
    );
  }
}


class DrawerTitle extends StatefulWidget {
  const DrawerTitle({
    super.key,
  });


  @override
  State<DrawerTitle> createState() => _DrawerTitleState();
}

class _DrawerTitleState extends State<DrawerTitle> {
  bool light1 = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {
        return FutureBuilder(
          future:profileController.getUser(),
          builder: (context , snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasData){
                UserModel userData = snapshot.data as UserModel;
                return Container(
                  height: 220,
                  width: double.infinity,
                  color: Colors.white.withOpacity(.9),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        ImageAsset.bloodFighterLogoPng,
                        height: 80,
                        width: 300,
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset("asset/images/userman.png"),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                           Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                userData.name,
                                style: const TextStyle(fontSize: 18,color: Colors.black),
                              ),
                              const SizedBox(height: 3,),
                               Text(
                                userData.mobile,
                                style: const TextStyle(fontSize: 18,color: Colors.black),
                              ),
                              const SizedBox(height: 3,),
                               Text(
                                "Last Donate : ${userData.donationDate}",
                                style: const TextStyle(fontSize: 16,color: Colors.black),
                              ),
                              const SizedBox(height: 3,),

                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }else if(snapshot.hasError){
                return const Center(child: Text("Somethings Went Wrong"),);
              }else{
                return const Center(child: Text("Empty Data"),);
              }
            }else{
              return const Center(child: CircularProgressIndicator(),);
            }
          },

        );
      }
    );
  }
}
