// ignore_for_file: unnecessary_import, prefer_if_null_operators, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping/layout/shop_layout_screen.dart';
import 'package:shopping/modules/login_screen/login_screen.dart';
import 'package:shopping/shared/bloc_observer.dart';
import 'package:shopping/shared/components/constants.dart';
import 'package:shopping/shared/network/local/cache_helper.dart';
import 'package:shopping/shared/network/remote/dio_helper.dart';

import 'modules/on_boarding_screen/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.dioInit();
  await CacheHelper.init();
  bool? onBoarding = CacheHelper.importData(key: 'onBoarding');
  token = CacheHelper.importData(key: 'token') != null ?CacheHelper.importData(key: 'token') :null;

  late Widget startWidget= OnBoardingScreen();
  if (onBoarding != null) {
    if (token != null) {
      startWidget = ShopLayoutScreen();
    } else {
      startWidget = LoginScreen();
    }
  } else {
    OnBoardingScreen();
  }

  runApp(MyApp(startWidget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Nunito',
        primarySwatch: Colors.indigo,
      ),
      themeMode: ThemeMode.light,
      home: startWidget,
    );
  }
}
