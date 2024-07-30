import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking/misc/mycolors/mycolors.dart';
import 'package:parking/widgets/custom_text.dart';

import '../widgets/custom_button.dart';
import 'mytetxwidget.dart';

class Statuscheck extends StatefulWidget {
  const Statuscheck({super.key});

  @override
  State<Statuscheck> createState() => _StatuscheckState();
}

class _StatuscheckState extends State<Statuscheck> {
  var colos= MyColors.primary1;
  String  hello= "Hello --world";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        

          children: [
            MytxtWidget(newTxt: hello),
            CustomText(text: "Add Number ", fontWeight: FontWeight.bold, fontSize: 12 ,textColor:MyColors.primary1 ),
            CustomButton(buttonText: "Continue", onTap: (){

              setState(() {
               hello="Hello to the world";
              });


            },
              btnColor: MyColors.primary6,
              buttonTextColor: MyColors.primary1,)
          ],
        ),
      ),
    );
  }
}
