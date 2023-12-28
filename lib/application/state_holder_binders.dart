
import 'package:blood_fighter/presentation/state%20holders/ambulance_list_screen_Controller.dart';
import 'package:blood_fighter/presentation/state%20holders/blood_request_controller.dart';
import 'package:blood_fighter/presentation/state%20holders/doctor_list_screen_controller.dart';
import 'package:blood_fighter/presentation/state%20holders/fogot_password_controller.dart';
import 'package:blood_fighter/presentation/state%20holders/hospital_list_screen_Controller.dart';
import 'package:blood_fighter/presentation/state%20holders/profile_controller.dart';
import 'package:blood_fighter/presentation/state%20holders/search_blood_controller.dart';
import 'package:blood_fighter/presentation/state%20holders/signIn_controller.dart';
import 'package:blood_fighter/data/repository/use_repository.dart';
import 'package:get/get.dart';

import '../presentation/state holders/nurse_list_screen_Controller.dart';
import '../presentation/state holders/sign_up_controller.dart';

class StateHolderBinders extends Bindings{
  @override
  void dependencies() {
    Get.put(SignUpController());
    Get.put(SignInController());
    Get.put(UserRepository());
    Get.put(ProfileController());
    Get.put(BloodRequestController());
    Get.put(SearchBloodController());
    Get.put(HospitalListController());
    Get.put(DoctorListScreenController());
    Get.put(ForgotPasswordController());
    Get.put(AmbulanceListController());
    Get.put(NurseListController());
  }

}