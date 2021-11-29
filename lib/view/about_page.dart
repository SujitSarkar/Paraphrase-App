import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
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
            title: const Text('About Us'),
            elevation: 0.0,
          ),
          body: _isLoading
              ? Center(child: SpinKitRipple(color: Theme.of(context).primaryColor, size: 100.0),)
              :SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
              child: Text(controller.aboutUs.value,
              textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: size * .04,color: StVariables.textColor)),
            ),
          ),
        );
      }
    );
  }
}
