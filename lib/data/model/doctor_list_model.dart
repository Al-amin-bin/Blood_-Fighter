
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorListModel{
  final String? id ;
  final String name;
  final String degree;
  final String mobile;
  final String chamber;

  DoctorListModel({
     this.id,
    required this.name,
    required this.degree,
    required this.mobile,
    required this.chamber,
  });
  toJson(){
    return{
    "name": name,
    "location": degree,
    "mobile": mobile,
    "chamber": chamber,
    };

  }
  factory DoctorListModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return DoctorListModel(
      id: document.id,
        name: data["name"],
        degree: data["degree"],
        mobile:  data["mobile"],
      chamber:  data["chamber"],
      );
  }

}