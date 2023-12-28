import 'package:blood_fighter/data/model/hospital_list_model.dart';
import 'package:blood_fighter/presentation/UI/utility/image_asset.dart';
import 'package:blood_fighter/presentation/state%20holders/hospital_list_screen_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalListScreen extends StatefulWidget {
  const HospitalListScreen({super.key});

  @override
  State<HospitalListScreen> createState() => _HospitalListScreenState();
}

class _HospitalListScreenState extends State<HospitalListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hospital"),
      ),
      body: GetBuilder<HospitalListController>(
        builder: (hospitalListController) {
          return FutureBuilder<List<HospitalListModel>>(
            future: hospitalListController.allHospitalList(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasData){
                  return ListView.separated(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index){
                      return Card(
                        // color: Colors.white.withOpacity(0.8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: Image.asset("${ImageAsset.iconPath}/hospital.png",width: 50,height: 60,),
                            title: Text("Name      : ${snapshot.data![index].name}",style: Theme.of(context).textTheme.titleMedium,overflow: TextOverflow.ellipsis,),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 3,),
                                Text("Address  : ${snapshot.data![index].address}",style: Theme.of(context).textTheme.titleMedium,overflow: TextOverflow.ellipsis,),
                                const SizedBox(height: 2,),
                                Text("Mobile     : ${snapshot.data![index].mobile}",style: Theme.of(context).textTheme.titleMedium,overflow: TextOverflow.ellipsis,),
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
                  },);

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
