import 'package:blood_fighter/presentation/UI/screens/available_blood_request_list_screen.dart';
import 'package:blood_fighter/presentation/UI/screens/blood_request_screen.dart';
import 'package:flutter/material.dart';

class RequestTapBar extends StatefulWidget {
  const RequestTapBar({super.key});

  @override
  State<RequestTapBar> createState() => _RequestTapBarState();
}

class _RequestTapBarState extends State<RequestTapBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Blood Request",textAlign: TextAlign.center,),
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.list_alt_sharp),
                  text: "Request List",
                ),
                Tab(
                  icon: Icon(Icons.playlist_add),
                  text: "Make A Request",
                ),

              ],

            ),

          ),
          body: const TabBarView(
            children: [
              AvailableBloodRequestScreen(),
              BloodRequestScreen(),
            ],
          ),
        )
    );
  }
}
