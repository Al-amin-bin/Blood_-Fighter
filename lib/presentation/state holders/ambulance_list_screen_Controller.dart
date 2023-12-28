import 'package:blood_fighter/data/model/ambulance_list_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AmbulanceListController extends GetxController{
 final database = FirebaseFirestore.instance;

  Future<List<AmbulanceListModel>> allAmbulanceList() async {
    final snapshot = await database.collection("Ambulance").get();
    final ambulanceListData = snapshot.docs.map((e) => AmbulanceListModel.fromSnapshot(e)).toList();
    return ambulanceListData;
  }
}