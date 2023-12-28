import 'package:blood_fighter/data/model/ambulance_list_model.dart';
import 'package:blood_fighter/data/model/hospital_list_model.dart';
import 'package:blood_fighter/presentation/UI/utility/image_asset.dart';
import 'package:blood_fighter/presentation/state%20holders/ambulance_list_screen_Controller.dart';
import 'package:blood_fighter/presentation/state%20holders/hospital_list_screen_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AmbulanceListScreen extends StatefulWidget {
  const AmbulanceListScreen({super.key});

  @override
  State<AmbulanceListScreen> createState() => _AmbulanceListScreenState();
}

class _AmbulanceListScreenState extends State<AmbulanceListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ambulance"),
      ),
      body: GetBuilder<AmbulanceListController>(
        builder: (ambulanceListController) {
          return FutureBuilder<List<AmbulanceListModel>>(
            future: ambulanceListController.allAmbulanceList(),
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
                            leading: Image.asset("${ImageAsset.iconPath}/ambulance.png",width: 50,height: 60,),
                            title: Text("Name      : ${snapshot.data![index].name}",style: Theme.of(context).textTheme.titleMedium,overflow: TextOverflow.ellipsis,),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 3,),
                                Text("Address  : ${snapshot.data![index].area}",style: Theme.of(context).textTheme.titleMedium,overflow: TextOverflow.ellipsis,),
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

                      // return Card(
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(15)
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Image.asset("asset/images/icon/ambulance.png",width: 50,height: 60,),
                      //       ),
                      //       const SizedBox(width: 4,),
                      //       Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text("Name     : ${snapshot.data![index].name}",style: Theme.of(context).textTheme.bodyLarge,),
                      //             const SizedBox(height: 4,),
                      //             Text("Address : ${snapshot.data![index].area}",style: Theme.of(context).textTheme.bodyLarge,),
                      //             const SizedBox(height: 4,),
                      //             Text("Mobile    : ${snapshot.data![index].mobile}",style: Theme.of(context).textTheme.bodyLarge,),
                      //           ],
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // );
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
