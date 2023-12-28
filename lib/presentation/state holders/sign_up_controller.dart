
import 'package:blood_fighter/data/model/user_model.dart';
import 'package:blood_fighter/presentation/UI/screens/home_screen.dart';
import 'package:blood_fighter/data/repository/authentication_repository.dart';
import 'package:blood_fighter/data/repository/use_repository.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{
  bool _signUpInProgress = false;
  bool get signUpInProgress => _signUpInProgress;


  Future<void> createUser(UserModel user) async {
    _signUpInProgress = true;
    update();
   await UserRepository.instance.createUser(user);
    signUp(user.email, user.password);
    _signUpInProgress= false;
    update();
  }


  void signUp(String email, String password){
    AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
  }
}