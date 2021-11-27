import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:the_fast_paraphrase/controller/controller.dart';
import 'package:the_fast_paraphrase/variables/st_variables.dart';
import 'package:the_fast_paraphrase/view/widgets/button.dart';
import 'package:the_fast_paraphrase/view/widgets/notifications.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _inputText = TextEditingController(text: '');
  final GlobalKey<FormState>_formKey=GlobalKey();

  int _sentenceCount = 0;
  int _wordCount = 0;
  String _htmlResultText='';
  String _resultText='';

  void _wordCountFunction(){
    String s = _inputText.text;
    List<String> l = s.split(' ');
    setState(() => _wordCount = l.length);
    ///Sentence Count
    final RegExp regExp = RegExp(r"[.!?;]+");
    final Iterable matches = regExp.allMatches(_inputText.text);
    setState(()=> _sentenceCount = matches.length);
    //print(_count);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(builder: (controller) {
      final double size = controller.size.value;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Row(
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Image.asset('assets/logo.png', height: 30, width: 30)),
              const SizedBox(width: 10),
              const Text(StVariables.appName)
            ],
          ),
          elevation: 0.0,
        ),
        body: _bodyUI(controller, size),
      );
    });
  }

  Widget _bodyUI(Controller controller, double size) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size * .02),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ///Instruction Text
                Container(
                  padding: EdgeInsets.all(size * .02),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0))),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText(
                        StVariables.instructionText,
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(
                            color: Colors.blueGrey.shade900,
                            fontSize: size * .04),
                        colors: StVariables.colorizeColors,
                      ),
                    ],
                    isRepeatingAnimation: true,
                    totalRepeatCount: 500,
                  ),
                ),
                SizedBox(height: size * .04),

                ///Input TextField
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(5.0))),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(size * .02),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(5.0),
                              topLeft: Radius.circular(5.0)
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Write or Paste Article',
                              style: TextStyle(
                                  fontSize: size * .04, fontWeight: FontWeight.bold,color: StVariables.textColor),
                            ),
                            InkWell(
                                onTap: ()async{
                                  await Clipboard.getData(Clipboard.kTextPlain).then((value){
                                    _inputText.text=value!.text!;
                                    _wordCountFunction();
                                  });
                                },
                                child: Icon(Icons.content_paste,color: Theme.of(context).primaryColor)
                            )
                          ],
                        ),
                      ),
                      const Divider(height:0.0,color: Colors.grey),

                      //Input Field
                      Padding(
                        padding: EdgeInsets.all(size * .02),
                        child: TextFormField(
                          controller: _inputText,
                          textAlign: TextAlign.justify,
                          validator: (value)=>value!.isEmpty?'Write or Paste Article':null,
                          onChanged: (value) {
                            _wordCountFunction();
                          },
                          maxLines: 10,
                          minLines: 5,
                          style: TextStyle(fontSize: size*.04),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                            hintText: 'Write here...',
                              border: OutlineInputBorder(borderSide: BorderSide.none)),
                        ),
                      ),
                    ],
                  ),
                ),

                ///Sentence Limit
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Limit: 200 Sentences',
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: size * .035)),
                      Text('$_sentenceCount/200',
                          style: TextStyle(
                              color: _sentenceCount>200?Colors.red:Colors.grey.shade700,
                              fontSize: size * .035)),
                    ],
                  ),
                ),
                SizedBox(height: size * .02),

                ///Word Limit
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Limit: 5000 Words',
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: size * .035)),
                      Text('$_wordCount/5000',
                          style: TextStyle(
                              color: _wordCount>5000?Colors.red:Colors.grey.shade700,
                              fontSize: size * .035)),
                    ],
                  ),
                ),
                SizedBox(height: size * .04),

                ///Rewrite button
                SolidButton(
                  child: Text('Re-write Article',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size * .045,
                          fontWeight: FontWeight.w600)),
                  onPressed: ()=>_validateAndSubmitQuery(controller),
                  height: size * .12,
                  width: size * .6,
                  borderRadius: size * .1,
                ),
                SizedBox(height: size * .04),

                ///Result
                _htmlResultText.isNotEmpty?Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(5.0))),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(size * .02),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(5.0),
                                topLeft: Radius.circular(5.0)
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Result:',
                              style: TextStyle(
                                  fontSize: size * .04, fontWeight: FontWeight.bold,color: StVariables.textColor),
                            ),
                            InkWell(
                                onTap: (){
                                  Clipboard.setData(ClipboardData(text: _resultText));
                                  showToast('Text Copied');
                                },
                                child: Icon(Icons.content_copy,color: Theme.of(context).primaryColor)
                            )
                          ],
                        ),
                      ),
                      const Divider(height:0.0,color: Colors.grey),

                      //result Field
                      Padding(
                        padding: EdgeInsets.all(size * .02),
                        child: Html(data: _htmlResultText),
                      ),
                    ],
                  ),
                ):Container(),
                SizedBox(height: size * .1),
              ],
            ),
          ),
        ),
      );

  Future<void> _validateAndSubmitQuery(Controller controller)async{
    if(_formKey.currentState!.validate()){
     if(_sentenceCount<200 && _wordCount<5000){
       setState(()=>_htmlResultText='');
       showLoadingDialog(context);
       await controller.getParaphraseResponse(_inputText.text).then((result){
         if(result!=null){
           setState(()=>_htmlResultText=result);
           _resultText = Bidi.stripHtmlIfNeeded(_htmlResultText);
           Get.back();
           showToast('Complete');
         }else{
           Get.back();
           showToast('Failed! Try Again');
         }
       });
     }else{
       showToast('Over Word Limit\nMax Limit is 5000 Words');
     }
    }else {
      showToast('Field Can\'t be empty');
    }
  }
}
