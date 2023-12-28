import 'package:blood_fighter/data/model/doctor_list_model.dart';
import 'package:blood_fighter/presentation/UI/utility/image_asset.dart';
import 'package:blood_fighter/presentation/state%20holders/doctor_list_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({super.key});

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctors"),
      ),
      body: GetBuilder<DoctorListScreenController>(
        builder: (doctorListScreenController) {
          return FutureBuilder<List<DoctorListModel>>(
            future:doctorListScreenController.getAllDoctorList() ,
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasData){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index){
                          return Card(
                            // color: Colors.white.withOpacity(0.8),
                              shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                               leading: Image.asset("${ImageAsset.iconPath}/doctor.png",width: 50,height: 60,),
                                title: Text("Name      : ${snapshot.data![index].name}",style: Theme.of(context).textTheme.titleMedium,overflow: TextOverflow.ellipsis,),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 3,),
                                    Text("Address  : ${snapshot.data![index].degree}",style: Theme.of(context).textTheme.titleMedium,overflow: TextOverflow.ellipsis,),
                                    const SizedBox(height: 2,),
                                    Text("Mobile     : ${snapshot.data![index].mobile}",style: Theme.of(context).textTheme.titleMedium,overflow: TextOverflow.ellipsis,),
                                    const SizedBox(height: 2,),
                                    Text("Camber   : ${snapshot.data![index].chamber}",style: Theme.of(context).textTheme.titleMedium,overflow: TextOverflow.ellipsis,),
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


                    }),
                  );
                }else if(snapshot.hasError){
                  return const Center(child:Text("SomeThings went Wrong"),);
                }else{
                  return const Center(child: Text("Empty List"),);
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
