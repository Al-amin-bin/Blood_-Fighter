class SignUpEmailPasswordFailure{
  const SignUpEmailPasswordFailure([this.message ="An Unknown Occurred"]);
  final String message;

  factory SignUpEmailPasswordFailure.code(String code){
    switch(code){
      case "week-password":
        return const SignUpEmailPasswordFailure("Please Enter Your Stronger password");
      case "invalid-email":
        return const SignUpEmailPasswordFailure("email is not valid or body format");
      case "email-already-use-in":
        return const SignUpEmailPasswordFailure("An account already exit this email");
      case "user-disabled":
        return const SignUpEmailPasswordFailure("This user has been disabled, please contact support for help");
        default:
          return const SignUpEmailPasswordFailure();
    }
  }
}