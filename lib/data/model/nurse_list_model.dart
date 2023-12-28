
import 'package:cloud_firestore/cloud_firestore.dart';

class NurseListModel{
  final String? id ;
  final String name;
  final String hospital;
  final String mobile;

  NurseListModel({
     this.id,
    required this.name,
    required this.hospital,
    required this.mobile,
  });
  toJson(){
    return{
    "name": name,
    "hospital": hospital,
    "mobile": mobile,
    };

  }
  factory NurseListModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return NurseListModel(
      id: document.id,
        name: data["name"],
        hospital: data["hospital"],
        mobile:  data["mobile"],
      );
  }

}