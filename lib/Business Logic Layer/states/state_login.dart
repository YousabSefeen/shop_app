
import '../../Data layer/Models/login_model.dart';

abstract class LoginStates {}

class LoginInitState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LogInModel logInModel;

  LoginSuccessState(this.logInModel);
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class LogIngToggleIconPass extends LoginStates {}

class UpdateProfileLoadingState extends LoginStates {}

class UpdateProfileSuccessfulState extends LoginStates {
  final LogInModel logInModel;

  UpdateProfileSuccessfulState(this.logInModel);
}

class UpdateProfileErrorState extends LoginStates {
  final String error;

  UpdateProfileErrorState(this.error);
}

class GetUserDataLoadingState extends LoginStates {}

class GetUserDataSuccessState extends LoginStates {
  final LogInModel userData;

  GetUserDataSuccessState(this.userData);
}

class GetUserDataErrorState extends LoginStates {}

class RegisterLoadingState extends LoginStates {}

class RegisterSuccessState extends LoginStates {
  final LogInModel registerModel;

  RegisterSuccessState(this.registerModel);
}

class RegisterErrorState extends LoginStates {
  final String error;

  RegisterErrorState(this.error);
}
