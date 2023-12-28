import 'package:blood_fighter/data/model/hospital_list_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HospitalListController extends GetxController{
 final database = FirebaseFirestore.instance;

  Future<List<HospitalListModel>> allHospitalList() async {
    final snapshot = await database.collection("Hospital").get();
    final hospitalListData = snapshot.docs.map((e) => HospitalListModel.fromSnapshot(e)).toList();
    return hospitalListData;
  }
}