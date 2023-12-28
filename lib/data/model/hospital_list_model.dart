
import 'package:cloud_firestore/cloud_firestore.dart';

class HospitalListModel{
  final String? id ;
  final String name;
  final String address;
  final String mobile;

  HospitalListModel({
     this.id,
    required this.name,
    required this.address,
    required this.mobile,
  });
  toJson(){
    return{
    "name": name,
    "address": address,
    "mobile": mobile,
    };

  }
  factory HospitalListModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return HospitalListModel(
      id: document.id,
        name: data["name"],
        address: data["address"],
        mobile:  data["mobile"],
      );
  }

}