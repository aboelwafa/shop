// ignore_for_file: unnecessary_import, avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/models/login_model.dart';
import 'package:shopping/modules/register_screen/register_cubit/states.dart';
import 'package:shopping/shared/components/constants.dart';
import 'package:shopping/shared/network/remote/dio_helper.dart';


class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  void changePasswordShow() {
    isPassword = !isPassword;
    emit(ChangePasswordState());
  }
  late UserModel user;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    emit(RegisterLoadingState());
    await DioHelper.postData(
        url: REGISTER,
        lang: language,
        // ignore: unnecessary_string_interpolations
        data: {'name':'$name','email': '$email', 'password': '$password','phone': '$phone'}).then((value) {
      user = UserModel.fromJson(value.data);
      emit(RegisterSuccessState(user));
    }).catchError((error) {
      print('Error');
      emit(RegisterErrorState());
      print(error.toString());
    });
  }
}
