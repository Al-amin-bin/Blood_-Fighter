
import 'package:blood_fighter/data/exeption/signUp_email_password_Failure.dart';
import 'package:blood_fighter/presentation/UI/screens/auth/login_screen.dart';
import 'package:blood_fighter/presentation/UI/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance  => Get.find();

  final  _auth =FirebaseAuth.instance;
  late final  Rx<User?> firebaseUser;

  checkUser(){
    firebaseUser =Rx<User?> (_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }
  // @override
  // void onReady() {
  //   super.onReady();
  //
  //   firebaseUser =Rx<User?> (_auth.currentUser);
  //   firebaseUser.bindStream(_auth.userChanges());
  //   ever(firebaseUser, _setInitialScreen);
  // }




  _setInitialScreen(User? user) {
    user ==null ? Get.off(()=> const LoginScreen()): Get.offAll(()=>const HomeScreen());

  }

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

      firebaseUser.value != null ? Get.offAll(()=>HomeScreen()): Get.offAll(()=> LoginScreen());
    } on FirebaseAuthException catch(e){
      final ex = SignUpEmailPasswordFailure.code(e.code);
      print("Firebase Auth Exeption ${ex.message}");
      throw ex;
    }catch(_){
      const ex = SignUpEmailPasswordFailure();
      print("Exeption !- ${ex.message}");
      throw ex;
    }
  }

  Future<void> logInUserWithEmailAndPassword(String email, String password) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e){
      Get.snackbar("Authentication Failed!", "Incorrect Email or Password");

    }catch(_){}
  }
  Future<void> logOut()  async => await _auth.signOut();
}