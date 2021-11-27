import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_fast_paraphrase/view/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:the_fast_paraphrase/view/widgets/notifications.dart';

class Controller extends GetxController {
  SharedPreferences? preferences;
  RxBool isPhone = true.obs;
  RxDouble size = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    iniatializeApp();
  }

  Future<void> iniatializeApp() async {
    preferences = await SharedPreferences.getInstance();
    isPhone(preferences!.getBool('isPhone')!);
    if (isPhone.value) {
      size(MediaQuery.of(Get.context!).size.width);
    } else {
      size(MediaQuery.of(Get.context!).size.height);
    }
    Future.delayed(const Duration(seconds: 5)).then((value) => Get.offAll(()=> const HomePage()));
  }

  Future<String?>getParaphraseResponse(String data)async{
    try{
      final response = await http.post(Uri.parse('https://www.prepostseo.com/apis/checkparaphrase'),
      body: {
        'key': '7d816829ffdc5daf36a1b9713687e19a',
        'data': data,
        'lang': 'en'
      });
      if(response.statusCode==200){
        final jsonData = jsonDecode(response.body);
        return jsonData['paraphrasedContent'];
      }else {
        showToast('Something Wrong! Try Again');
        return null;
      }
    }on SocketException{
      showToast('No Internet Connection');
      return null;
    } catch(error){
      showToast(error.toString());
      return null;
    }
  }
}