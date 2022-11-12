// ignore_for_file: unused_import

import 'package:dio/dio.dart';
import 'package:shopping/models/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}
class ChangePasswordState extends LoginStates {}
class LoginLoadingState extends LoginStates {}
class LoginSuccessState extends LoginStates {
  final UserModel userModel;

  LoginSuccessState(this.userModel);
}
class LoginErrorState extends LoginStates {}

