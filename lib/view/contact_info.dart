import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:the_fast_paraphrase/controller/controller.dart';
import 'package:the_fast_paraphrase/variables/st_variables.dart';

class ContactInfo extends StatefulWidget {
  const ContactInfo({Key? key}) : super(key: key);

  @override
  _ContactInfoState createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  int _counter=0;
  bool _isLoading=false;

  void _customInit(Controller controller)async{
    _counter++;
    if(controller.userName.value.isEmpty){
      setState(()=>_isLoading=true);
      await controller.getAdmin();
      setState(()=>_isLoading=false);
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
              title: const Text('Contact Information'),
              elevation: 0.0,
            ),
            body: _isLoading
                ? Center(child: SpinKitRipple(color: Theme.of(context).primaryColor, size: 100.0),)
                :Center(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      controller.phoneNumber.value.isNotEmpty?SelectableText('Phone Number: ${controller.phoneNumber.value}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: size * .045,color: StVariables.textColor)):Container(),
                      controller.phoneNumber.value.isNotEmpty?SizedBox(height: size*.04):Container(),

                      controller.email.value.isNotEmpty?SelectableText('Email: ${controller.email.value}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: size * .045,color: StVariables.textColor)):Container(),
                      controller.email.value.isNotEmpty?SizedBox(height: size*.04):Container(),

                      controller.address.value.isNotEmpty?SelectableText('Address: ${controller.address.value}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: size * .045,color: StVariables.textColor)):Container(),
                      controller.address.value.isNotEmpty?SizedBox(height: size*.04):Container(),

                      controller.website.value.isNotEmpty?SelectableText('Website: ${controller.website.value}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: size * .045,color: StVariables.textColor)):Container(),
                      controller.website.value.isNotEmpty?SizedBox(height: size*.04):Container(),
                    ],
                  )
              ),
            ),
                ),
          );
        }
    );
  }
}
