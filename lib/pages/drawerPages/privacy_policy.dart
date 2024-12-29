import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../misc/mycolors/mycolors.dart';
import '../../widgets/custom_text.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: MyColors.primarylight0),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_back,
                            color: MyColors.grey_20,
                          ),
                        )),
                  ),
                  CustomText(
                      text: "Privacy Policy",
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      textColor: MyColors.grey_20),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(height: 20,),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: "Terms & Conditions", fontWeight: FontWeight.w700, fontSize: 15, textColor: MyColors.grey_20),
                  SizedBox(height: 12,),
                 CustomText(text: "This app is for parking cars. If you somehow manage to park a helicopter, we’re impressed, but please use the sky instead 😁.", fontWeight: FontWeight.w200, fontSize: 12, textColor: MyColors.grey_20),

                  SizedBox(height: 16,),

                  CustomText(text: "Terms & Policy", fontWeight: FontWeight.w700, fontSize: 15, textColor: MyColors.grey_20),
                  SizedBox(height: 12,),
                  CustomText(text: "This app grants you a license to park your car—on the ground, where cars generally belong. If your vehicle is capable of flight, we suggest you contact the FAA for proper clearance, because unfortunately, our parking spots aren’t equipped for aerial landings (yet). \n\nWe appreciate your advanced transportation technology, but we must remind you that our app doesn’t cover hovercrafts, flying saucers, or broomsticks", fontWeight: FontWeight.w200, fontSize: 12, textColor: MyColors.grey_20),
                ],
              )

            ],
          ),
        ),

      ),
    );
  }
}
