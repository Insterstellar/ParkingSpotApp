import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:parking/misc/mycolors/mycolors.dart';

import '../../data/my_strings.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/my_text.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: MyColors.primary1,
      appBar: AppBar(
          backgroundColor: MyColors.primary1,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
          ),
          title: CustomText(text: "About", fontWeight: FontWeight.w300, fontSize: 18, textColor: MyColors.grey_20),

        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: MyColors.grey_20),
            onPressed: () {Navigator.pop(context);},
          ),

      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
           // Text("Parking Spot", style: MyText.display1(context)!.copyWith(color: MyColors.grey_60, fontWeight: FontWeight.w300)),
            CustomText(text: "Parking Spot", fontWeight: FontWeight.w300, fontSize: 27, textColor: MyColors.grey_20),
            Container(height: 5),
            Container(width: 120, height: 3, color: MyColors.primary6),
            Container(height: 15),
            CustomText(text: "Version", fontWeight: FontWeight.w400, fontSize: 13, textColor: MyColors.grey_20),
            CustomText(text: "0.0.0.1", fontWeight: FontWeight.w600, fontSize: 17, textColor: MyColors.grey_40),
            Container(height: 15),
            CustomText(text: "Last Update", fontWeight: FontWeight.w400, fontSize: 14, textColor: MyColors.grey_20),
            CustomText(text: "October 2024", fontWeight: FontWeight.w600, fontSize: 17, textColor: MyColors.grey_40),
            Container(height: 25),
            CustomText(text: MyStrings.about, fontWeight: FontWeight.w200, fontSize: 16, textColor: MyColors.grey_40),

            Container(height: 25),
          ],
        ),
      ),
    );
  }
}
