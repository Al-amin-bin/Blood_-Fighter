import 'package:blood_fighter/data/model/hospital_list_model.dart';
import 'package:blood_fighter/data/model/nurse_list_model.dart';
import 'package:blood_fighter/presentation/UI/utility/image_asset.dart';
import 'package:blood_fighter/presentation/state%20holders/hospital_list_screen_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../state holders/nurse_list_screen_Controller.dart';

class NurseListScreen extends StatefulWidget {
  const NurseListScreen({super.key});

  @override
  State<NurseListScreen> createState() => _NurseListScreenState();
}

class _NurseListScreenState extends State<NurseListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nurse"),
      ),
      body: GetBuilder<NurseListController>(
        builder: (nurseListController) {
          return FutureBuilder<List<NurseListModel>>(
            future: nurseListController.allNurseList(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasData){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.separated(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index){
                        return Card(
                          // color: Colors.white.withOpacity(0.8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: Image.asset("${ImageAsset.iconPath}/nurse.png",width: 50,height: 60,),
                              title: Text("Name      : ${snapshot.data![index].name}",style: Theme.of(context).textTheme.titleMedium,overflow: TextOverflow.ellipsis,),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 3,),
                                  Text("Mobile     : ${snapshot.data![index].mobile}",style: Theme.of(context).textTheme.titleMedium,overflow: TextOverflow.ellipsis,),
                                  const SizedBox(height: 2,),
                                  Text("Hospital  : ${snapshot.data![index].hospital}",style: Theme.of(context).textTheme.titleMedium,overflow: TextOverflow.ellipsis,),
                                ],
                              ),
                              trailing: InkWell(
                                  onTap:  () async {
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
                                  child: const Icon(Icons.call,color: Colors.green,)),
                            ),
                          ),
                        );

                      }, separatorBuilder: (_,__){
                      return const SizedBox(height: 1,);
                    },),
                  );

                }else if(snapshot.hasError){
                  return const Center( child:  Text("SomeThing Went Worng"),);
                }else{
                  return const Center(child: Text("No Hospital DAta"),);
                }
              }else{
                return const Center(child: CircularProgressIndicator(),);
              }

            },

          );
        }
      ),
    );
  }
}
