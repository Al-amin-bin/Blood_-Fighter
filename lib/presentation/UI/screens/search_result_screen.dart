import 'package:blood_fighter/presentation/UI/utility/app_color.dart';
import 'package:blood_fighter/presentation/state%20holders/search_blood_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({Key? key, required this.bloodGroup, required this.location}) : super(key: key);
  final String bloodGroup, location;

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Donors"),
      ),
      body:GetBuilder<SearchBloodController>(
          builder: (searchBloodController) {
            return FutureBuilder(
              future: searchBloodController.searchBlood(widget.bloodGroup, widget.location),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.hasData){
                    return SafeArea(
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: ShapeDecoration(
                              color: AppColors.primaryColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30)),
                              ),
                            ),
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 24, horizontal: 36),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "asset/images/Group 225.svg",
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                       Text(
                                        widget.bloodGroup,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "asset/images/Vector.svg",
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                       Text(
                                        widget.location,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: 'Lexend',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
                          /// tap bar container
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                  itemCount: snapshot.data!.length,

                                  itemBuilder: (context, index){
                                    return Card(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      elevation: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 6),
                                        child: ListTile(
                                          leading:  SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(100),
                                              child: Image.asset("asset/images/userman.png"),
                                            ),
                                          ),
                                          title:  Text("Name: ${snapshot.data![index].name}", style: const TextStyle(fontSize: 18,color: Colors.black),overflow: TextOverflow.ellipsis,),
                                          subtitle:  Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Address : ${snapshot.data![index].location}",style: const TextStyle(fontSize: 14,color: Colors.black),overflow: TextOverflow.ellipsis,),
                                              const SizedBox(height: 2,),
                                              Text("Last Donation Date: ${snapshot.data![index].donationDate}",style: const TextStyle(fontSize: 14,color: Colors.black),overflow: TextOverflow.ellipsis,),
                                              const SizedBox(height: 2,),
                                              Text("Number :${snapshot.data![index].mobile}",style: const TextStyle(fontSize: 14,color: Colors.black),overflow: TextOverflow.ellipsis,),
                                            ],
                                          ),

                                          trailing: Column(

                                            children: [
                                              Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                    color: AppColors.primaryColor,
                                                    borderRadius: BorderRadius.circular(100)
                                                ),
                                                child:  Center(child: Text(snapshot.data![index].bloodGroup,style: const TextStyle(color: Colors.white,fontSize: 16),),),
                                              ),
                                              InkWell(onTap: () async {
                                                final Uri url =Uri(
                                                    scheme: "tel",
                                                    path:snapshot.data![index].mobile
                                                );
                                                if(await canLaunchUrl(url)){
                                                  await launchUrl(url);
                                                }else{
                                                  print("cnanot");
                                                }
                                              }, child: const Icon(Icons.call,color: Colors.green,))

                                            ],
                                          ),

                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  else if(snapshot.hasError){
                    return Center(child: Text(snapshot.hasError.toString()),);
                  }else{
                    return const Center(child: Text("No Data"),);
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

class BloodDonorsCard extends StatelessWidget {
  const BloodDonorsCard({
    super.key, required this.imagePath, required this.name, required this.address, required this.lastDonationDate, required this.bloodGroup, required this.mobile,
  });
  final String imagePath, name, address, lastDonationDate, bloodGroup,mobile;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: ListTile(
          leading:  SizedBox(
            height: 50,
            width: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(imagePath),
            ),
          ),
          title:  Text("Name: $name", style: const TextStyle(fontSize: 18,color: Colors.black),),
          subtitle:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Address : $address",style: const TextStyle(fontSize: 14),),
              Text("Last Donation Date: $lastDonationDate",style: const TextStyle(fontSize: 14),),
              Text("Number : $mobile",style: const TextStyle(fontSize: 14),),
            ],
          ),

          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(100)
            ),
            child:  Center(child: Text(bloodGroup,style: const TextStyle(color: Colors.white,fontSize: 16),),),
            ),
              Image.asset("asset/images/icon/call.png",height: 20,width: 20,)
            ],
          ),

        ),
      ),
    );
  }
}
