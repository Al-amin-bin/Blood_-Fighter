
import 'package:blood_fighter/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();


  final dataBase = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    await dataBase.collection("User").add(user.toJson()).whenComplete(
            () => Get.snackbar("Success", "Your Account has been Created",
            snackPosition: SnackPosition.BOTTOM
            )

    ).catchError((error, stackTrace){
      Get.snackbar("Failed", "somethings went Wrong: Try Again!",
          snackPosition: SnackPosition.BOTTOM
      );
      print(error.toString());

    });
  }


  Future<UserModel> getUserDetails(String email) async {
    final snapshot = await dataBase.collection("User").where("email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  Future<List<UserModel>> allUserDetails() async {
    final snapshot = await dataBase.collection("User").get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }

  Future<List<UserModel>> searchBlood(String bloodGroup, String location) async {
    final snapshot = await dataBase.collection("User").where("bloodGroup", isEqualTo: bloodGroup ,).where("location",isEqualTo: location).where("donationStatus", isEqualTo: true).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }
}