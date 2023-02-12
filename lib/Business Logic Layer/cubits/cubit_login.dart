import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Data layer/Models/login_model.dart';
import '../../Data layer/dio_helper.dart';

import '../../presentation layer/constants/constants.dart';
import '../states/state_login.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitState());

  static LoginCubit getObject(context) => BlocProvider.of(context);

  /// User Register
  LogInModel? registerModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: 'register',
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      registerModel = LogInModel.fromJson(value.data);

      ///In this case, I sent the model so that I know how to extract the message
      /// from the register screen and print it for the user

      emit(RegisterSuccessState(registerModel!));
    }).catchError((error) {
      if (kDebugMode) {
        print('Error F userRegister ${error.toString()}');
      }
      emit(RegisterErrorState(error));
    });
  }

  /// User Login
  LogInModel? logInModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: 'login',
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      logInModel = LogInModel.fromJson(value.data);

      if (kDebugMode) {
        print(value.toString());
      }

      ///In this case, I sent the model so that I know how to extract
      ///the message from the login screen and print it for the laser
      emit(LoginSuccessState(logInModel!));
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(LoginErrorState(error));
    });
  }

  /// Get Data Profile

  LogInModel? userData;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  void getUserData() {
    emit(GetUserDataLoadingState());

    DioHelper.getData(url: 'profile', token: token).then((value) {
      userData = LogInModel.fromJson(value.data);
      nameController.text = userData!.data!.name!;
      emailController.text = userData!.data!.email!;
      phoneController.text = userData!.data!.phone!;

      emit(GetUserDataSuccessState(userData!));
    }).catchError((error) {
      if (kDebugMode) {
        print('Error F getUserData ${error.toString()}');
      }

      emit(GetUserDataErrorState());
    });
  }

  void updateProfile({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(UpdateProfileLoadingState());

    DioHelper.putData(
      url: 'update-profile',
      data: {
        'name': name,
        'phone': phone,
        'email': email,
      },
      token: token,
    ).then((value) {
      logInModel = LogInModel.fromJson(value.data);

      emit(UpdateProfileSuccessfulState(logInModel!));
    }).catchError((error) {
      if (kDebugMode) {
        print('ERROR F updateProfile= ${error.toString()}');
      }

      emit(UpdateProfileErrorState(error));
    });
  }

  bool isShowPass = true;

  IconData icon = Icons.visibility;

  void toggleIconPass() {
    isShowPass = !isShowPass;

    icon = isShowPass ? Icons.visibility : Icons.visibility_off_outlined;

    emit(LogIngToggleIconPass());
  }
}
