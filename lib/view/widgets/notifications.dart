import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showLoadingDialog(BuildContext context) {
  showGeneralDialog(
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.8),
      transitionDuration: const Duration(milliseconds: 500),
      context: context,
      pageBuilder: (context, __, ___){
        return Material(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SpinKitRipple(color: Theme.of(context).primaryColor, size: 150.0),
                const Text('Processing...',style: TextStyle(color: Colors.white,fontSize: 25.0),)
              ],
            ),
          ),
        );
      });
}

void showToast(String message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
