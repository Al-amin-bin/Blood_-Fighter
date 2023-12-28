import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BloogScreen extends StatefulWidget {
  const BloogScreen({super.key});

  @override
  State<BloogScreen> createState() => _BloogScreenState();
}

class _BloogScreenState extends State<BloogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text("Blog"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const Text("The development  of the blood fighter application is a response to a critical healthcare  challenge. Blood shortage is a recurring issue that can have life-threatening consequences for patients in need of blood transfusions. In this contex, this application aims to bridge the gap between willing donors and indivisuals or medical facilities requiring blood.",
            style: TextStyle(fontSize: 24,fontWeight: FontWeight.w400,letterSpacing: .3,height: 1.5),),
          const SizedBox(height: 20,),
            const Text("Contact More Info",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 30,color: Colors.green),),
            const SizedBox(height: 12,),
            Text("Creative Software",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 35,color: Colors.red.shade600),),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.call,color: Colors.green,),
                TextButton(onPressed: () async {
                  final Uri url = Uri(scheme: "tel", path: "01717468814");
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        print("cnanot");
                      }
                    }, child: const Text("01717468814",style: TextStyle(fontSize: 20, color: Colors.green),)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
