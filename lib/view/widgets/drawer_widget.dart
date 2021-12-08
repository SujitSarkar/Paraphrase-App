import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_fast_paraphrase/controller/controller.dart';
import 'package:the_fast_paraphrase/view/about_page.dart';
import 'package:the_fast_paraphrase/view/contact_info.dart';
import 'package:launch_review/launch_review.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Controller controller = Get.find();
    final double size=controller.size.value;

    return Drawer(
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration:const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: SingleChildScrollView(child: Column(
            children: [
              ///Header
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/logo.png', height: 150, width: MediaQuery.of(context).size.width,fit: BoxFit.fitHeight),
                  Positioned(
                    bottom: 10.0,
                      child: Text('The Fast Paraphrase',style: TextStyle(fontSize: size*.045,fontWeight: FontWeight.bold)))
                ],
              ),
              const Divider(color: Colors.blueGrey),
              SizedBox(height: size*.05),

              ///About Us
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(10))
                ),
                child: ListTile(
                  onTap: ()=>Get.to(()=>const AboutPage()),
                  leading: Icon(CupertinoIcons.info,color: Theme.of(context).primaryColor,size: size*.07,),
                  title: Text('About Us',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade800,fontSize: size*.04)),
                  trailing: const Icon(CupertinoIcons.forward),
                ),
              ),
              SizedBox(height: size*.04),

              ///Contact info
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(10))
                ),
                child: ListTile(
                  onTap: ()=>Get.to(()=>const ContactInfo()),
                  leading: Icon(CupertinoIcons.phone,color: Theme.of(context).primaryColor,size: size*.07,),
                  title: Text('Contact Info',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade800,fontSize: size*.04)),
                  trailing: const Icon(CupertinoIcons.forward),
                ),
              ),
              SizedBox(height: size*.04),

              ///Rating
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(10))
                ),
                child: ListTile(
                  onTap: (){
                    LaunchReview.launch(androidAppId: 'com.glamworlditltd.the_fast_paraphrase',
                        iOSAppId: "");
                  },
                  leading: Icon(CupertinoIcons.star,color: Theme.of(context).primaryColor,size: size*.07),
                  title: Text('Rate Us',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade800,fontSize: size*.04)),
                  trailing: const Icon(CupertinoIcons.forward),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
