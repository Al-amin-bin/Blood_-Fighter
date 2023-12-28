import 'package:blood_fighter/data/model/doctor_list_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DoctorListScreenController extends GetxController{

   final database = FirebaseFirestore.instance;


   Future<List<DoctorListModel>> getAllDoctorList() async {
     final snapshot = await database.collection("Doctors").get();
     final doctorListData = snapshot.docs.map((e) => DoctorListModel.fromSnapshot(e)).toList();
     return doctorListData;
   }
}