
import 'package:blood_fighter/data/repository/authentication_repository.dart';
import 'package:get/get.dart';

class SignInController extends GetxController{
  bool _signInProgress = false;
  bool get signInProgress => _signInProgress;


  Future<void> signIn(String email, String password) async {
    _signInProgress = true;
    update();
    await AuthenticationRepository.instance.logInUserWithEmailAndPassword(email, password);
    _signInProgress= false;
    update();
  }
}