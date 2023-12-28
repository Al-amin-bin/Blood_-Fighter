
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String? id ;
  final String name;
  final String location;
  final String gender;
  final String bloodGroup;
  final String email;
  final String mobile;
  final String password;
  final String donationDate;
  final bool donationStatus;

  UserModel({
     this.id,
    required this.name,
    required this.location,
    required this.gender,
    required this.bloodGroup,
    required this.email,
    required this.mobile,
    required this.password,
    required this.donationDate,
    required this.donationStatus
  });
  toJson(){
    return{
    "name": name,
    "location": location,
    "gender": gender,
    "bloodGroup": bloodGroup,
    "email": email,
    "mobile": mobile,
    "password": password,
    "donationDate": donationDate,
    "donationStatus": donationStatus,
    };

  }
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return UserModel(
      id: document.id,
        name: data["name"],
        location: data["location"],
        gender:  data["gender"],
        bloodGroup:  data["bloodGroup"],
        email: data["email"],
        mobile:  data["mobile"],
        password:  data["password"],
        donationDate:  data["donationDate"],
        donationStatus:  data["donationStatus"],

    );
  }

}