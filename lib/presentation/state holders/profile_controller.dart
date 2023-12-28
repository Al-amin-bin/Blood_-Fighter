
import 'package:blood_fighter/data/repository/authentication_repository.dart';
import 'package:blood_fighter/data/repository/use_repository.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{

  final _auth = Get.put(AuthenticationRepository());
  final _userRepository = Get.put(UserRepository());

  getUser(){
    final email = _auth.firebaseUser.value?.email;
    if(email != null){
      return _userRepository.getUserDetails(email);
    }else{
      Get.snackbar("Error", "Log in To Continue");
    }

  }
}