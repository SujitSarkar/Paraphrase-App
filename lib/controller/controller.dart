import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_fast_paraphrase/view/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:the_fast_paraphrase/view/widgets/notifications.dart';

class Controller extends GetxController {
  SharedPreferences? preferences;
  RxBool isPhone = false.obs;
  RxDouble size = 0.0.obs;

  RxString userName=''.obs;
  RxString password=''.obs;
  RxString aboutUs=''.obs;
  RxString phoneNumber=''.obs;
  RxString address=''.obs;
  RxString email=''.obs;
  RxString website=''.obs;
  RxBool enableAdmob=true.obs;

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
    getAdmin();
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

  Future<bool> getAdmin()async{
    try{
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Admin').get();
      final List<QueryDocumentSnapshot> user = snapshot.docs;
      if(user.isNotEmpty){
        password(user[0].get('password'));
        userName(user[0].get('userName'));
        email(user[0].get('email'));
        address(user[0].get('address'));
        phoneNumber(user[0].get('phoneNumber'));
        website(user[0].get('website'));
        aboutUs(user[0].get('aboutUs'));
        enableAdmob(user[0].get('enableAdmob'));
        update();
        print('Admob: ${enableAdmob.value}');
        return true;
      }else{
        return false;
      }
    } on SocketException{
      showToast('No Internet Connection !');
      return false;
    } catch(error){
      showToast(error.toString());
      return false;
    }
  }
}