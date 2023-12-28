import 'package:blood_fighter/data/model/request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BloodRequestRepository extends GetxController {
  static BloodRequestRepository get instance => Get.find();
  final dataBase = FirebaseFirestore.instance;
  createRequest(RequestModel user) async {
    await dataBase.collection("RequestData").add(user.toJson()).whenComplete(
            () => Get.snackbar("Success", "Your Request has been Created",)

    ).catchError((error, stackTrace){
      Get.snackbar("Failed", "somethings went Wrong: Try Again!",
      );
      print(error.toString());

    });
  }

  Future<List<RequestModel>> allBloodRequestDetails() async {
    DateTime now = DateTime.now();
    final snapshot = await dataBase.collection("RequestData").where("quantity",isGreaterThan: 0,).get();
    final bloodRequestData = snapshot.docs.map((e) => RequestModel.fromSnapshot(e)).toList();
    return bloodRequestData;
  }
  
}