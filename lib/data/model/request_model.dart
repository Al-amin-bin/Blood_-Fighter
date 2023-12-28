
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel{
  final String? id ;
  final String name;
  final String patientCondition;
  final String gender;
  final String location;
  final String hospitalName;
  final String bloodGroup;
  final String mobile;
  final int quantity;
  final String date;
  final String details;


  RequestModel({
     this.id,
    required this.name,
    required this.patientCondition,
    required this.location,
    required this.hospitalName,
    required this.gender,
    required this.bloodGroup,
    required this.mobile,
    required this.quantity,
    required this.date,
    required this.details,
  });
  toJson(){
    return{
    "name": name,
    "patientCondition": patientCondition,
    "location": location,
    "hospitalName": hospitalName,
    "gender": gender,
    "bloodGroup": bloodGroup,
    "mobile": mobile,
    "quantity": quantity,
      "date": date,
    "details": details,
    };

  }
  factory RequestModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return RequestModel(
      id: document.id,
        name: data["name"],
        patientCondition: data["patientCondition"],
        location: data["location"],
        hospitalName: data["hospitalName"],
        gender:  data["gender"],
        bloodGroup:  data["bloodGroup"],
        mobile:  data["mobile"],
        quantity:  data["quantity"],
        date: data["date"],
        details:  data["details"]);
  }

}