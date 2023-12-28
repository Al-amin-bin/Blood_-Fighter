
import 'package:cloud_firestore/cloud_firestore.dart';

class AmbulanceListModel{
  final String? id ;
  final String name;
  final String area;
  final String mobile;

  AmbulanceListModel({
     this.id,
    required this.name,
    required this.area,
    required this.mobile,
  });
  toJson(){
    return{
    "name": name,
    "address": area,
    "mobile": mobile,
    };

  }
  factory AmbulanceListModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return AmbulanceListModel(
      id: document.id,
        name: data["name"],
        area: data["area"],
        mobile:  data["mobile"],
      );
  }

}