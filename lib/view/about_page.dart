import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:the_fast_paraphrase/controller/ad_controller.dart';
import 'package:the_fast_paraphrase/controller/controller.dart';
import 'package:the_fast_paraphrase/variables/st_variables.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  int _counter=0;
  bool _isLoading=false;
  AdController adController = AdController();

  void _customInit(Controller controller)async{
    _counter++;
    if(controller.userName.value.isEmpty){
      setState(()=>_isLoading=true);
      await controller.getAdmin();
      setState(()=>_isLoading=false);
    }
  }
  @override
  void initState() {
    super.initState();
    final Controller controller=Get.find();
    if(controller.enableAdmob.value){
      adController.loadBannerAdd();
      adController.loadInterstitialAd();
    }

  }
  @override
  void dispose() {
    super.dispose();
    final Controller controller=Get.find();
    if(controller.enableAdmob.value){
      adController.showInterstitialAd();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(
      builder: (controller) {
        final double size = controller.size.value;
        if(_counter==0) _customInit(controller);

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('About Us'),
            elevation: 0.0,
          ),
          body: _isLoading
              ? Center(child: SpinKitRipple(color: Theme.of(context).primaryColor, size: 100.0),)
              :SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
              child: Column(
                children: [
                  ///Banner Ad
                  controller.enableAdmob.value
                      ?Container(
                    alignment: Alignment.center,
                    child: AdWidget(ad: adController.bannerAd!),
                    width: MediaQuery.of(context).size.width,
                    height: adController.bannerAd!.size.height.toDouble(),
                  ) :Container(),
                  const SizedBox(height: 15),

                  Text(controller.aboutUs.value,
                  textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: size * .04,color: StVariables.textColor)),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
