
import 'package:blood_fighter/data/model/user_model.dart';
import 'package:blood_fighter/data/repository/authentication_repository.dart';
import 'package:blood_fighter/data/repository/use_repository.dart';
import 'package:get/get.dart';

class SearchBloodController extends GetxController{

  final _userRepository = Get.put(UserRepository());


  Future<List<UserModel>> searchBlood(String bloodGroup, String location) async {
    return await _userRepository.searchBlood(bloodGroup, location);

  }
}