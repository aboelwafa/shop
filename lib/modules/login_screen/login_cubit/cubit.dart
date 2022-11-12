// ignore_for_file: unnecessary_import, unnecessary_string_interpolations, avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/models/login_model.dart';
import 'package:shopping/modules/login_screen/login_cubit/states.dart';
import 'package:shopping/shared/components/constants.dart';
import 'package:shopping/shared/network/remote/dio_helper.dart';


class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  void changePasswordShow() {
    isPassword = !isPassword;
    emit(ChangePasswordState());
  }
  UserModel? user;

  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    await DioHelper.postData(
        url: LOGIN,
        lang: language,
        data: {'email': email, 'password': '$password'}).then((value) {
      user = UserModel.fromJson(value.data);
      print(user!.status);
      print(user!.message);
      emit(LoginSuccessState(user!));
    }).catchError((error) {
      emit(LoginErrorState());
    });
  }
}
