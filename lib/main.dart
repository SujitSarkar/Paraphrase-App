import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_fast_paraphrase/variables/st_variables.dart';
import 'package:the_fast_paraphrase/view/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  /// Set Device orientation
  final bool _isPhone = Device.get().isPhone;
  SharedPreferences pref = await SharedPreferences.getInstance();
  if(_isPhone) {StVariables.portraitMood;}
  else {StVariables.landscapeMood;}
  pref.setBool('isPhone', _isPhone);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'The Fast Paraphrase',
      theme: StVariables.appTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen()
    );
  }
}
