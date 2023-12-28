import 'package:blood_fighter/data/model/hospital_list_model.dart';
import 'package:blood_fighter/data/model/nurse_list_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class NurseListController extends GetxController{
 final database = FirebaseFirestore.instance;

  Future<List<NurseListModel>> allNurseList() async {
    final snapshot = await database.collection("Nurse").get();
    final nurseListData = snapshot.docs.map((e) => NurseListModel.fromSnapshot(e)).toList();
    return nurseListData;
  }
}