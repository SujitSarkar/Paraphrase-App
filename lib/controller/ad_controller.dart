import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

class AdController{

  ///Banner ad ID
  //Android ca-app-pub-1854594886293142/9770615093
  //IOS ca-app-pub-1854594886293142/9383618192

  ///Interstitial
  //Android ca-app-pub-1854594886293142/6402231636
  //IOS ca-app-pub-1854594886293142/2626638159

  ///Admob App ID:::::(AndroidManifest.xml & Info.plist)
  //Android: ca-app-pub-1854594886293142~3779921819
  //iOS: ca-app-pub-1854594886293142~1888271553

  InterstitialAd? interstitialAd;
  BannerAd? bannerAd;

  static final String bannerAddUnitId=Platform.isAndroid
      ? 'ca-app-pub-1854594886293142/9770615093'
      : 'ca-app-pub-1854594886293142/9383618192';

  static final String interstitialAddUnitId=Platform.isAndroid
      ? 'ca-app-pub-1854594886293142/6402231636'
      : 'ca-app-pub-1854594886293142/2626638159';

  void loadBannerAdd(){
    bannerAd = BannerAd(
        adUnitId: bannerAddUnitId,
        size: AdSize.banner,
        request: const AdRequest(),
        listener: const BannerAdListener()
    );
    bannerAd!.load();
  }

  void loadInterstitialAd(){
    InterstitialAd.load(
        adUnitId: interstitialAddUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            //loadInterstitialAd();
            // print('InterstitialAd failed to load: $error');
          },
        ));
  }
  void showInterstitialAd(){
    interstitialAd!.show();
    loadInterstitialAd();
  }

  void disposeAllAd(){
    bannerAd!.dispose();
    interstitialAd!.dispose();
  }
}