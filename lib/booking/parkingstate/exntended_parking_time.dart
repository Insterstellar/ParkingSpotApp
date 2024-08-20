import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parking/widgets/custom_button.dart';

import '../../misc/mycolors/mycolors.dart';
import '../../widgets/custom_text.dart';

class ExtendParkingTime extends StatefulWidget {
  const ExtendParkingTime({super.key});

  @override
  State<ExtendParkingTime> createState() => _ExtendParkingTimeState();
}

class _ExtendParkingTimeState extends State<ExtendParkingTime> {
  double duration=0;
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary1,
      appBar: AppBar(
        backgroundColor: MyColors.primary1,
        title: const CustomText(text: "Extended Parking Time", fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.grey_20),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: MyColors.grey_20,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

      ),
      body: SafeArea(
        child: Column(
          children: [
            //adjust parking time
           Padding(
             padding: const EdgeInsets.all(20.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 CustomText(text: "Duration", fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.grey_20),
                  SizedBox(height: 10,),
                  Slider(value: duration,
                      min: 0,
                      max: 24,
                      divisions: 24,
                      label: duration.round().toString(),
                      thumbColor: MyColors.primary6,
                      activeColor: MyColors.primary6,
                      onChanged: (value){
                    setState(() {

                      duration=value;
                    });

                  }),
                 SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: "Start Hour", fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.grey_20),
                            SizedBox(height: 10,),
                            GestureDetector(
                              onTap: () async{
                                TimeOfDay? selectedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                                if(selectedTime !=null){
                                  setState(() {
                                    selectedStartTime=selectedTime;
                                  });


                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(15),

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: MyColors.primarylight,
                                ),
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(text: selectedStartTime.format(context).toString(), fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.grey_20),
                                    Icon(Icons.access_time, color: MyColors.grey_20,)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: "End Hour", fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.grey_20),
                            SizedBox(height: 10,),
                            GestureDetector(
                              onTap: () async{
                                TimeOfDay? selectedTime= await showTimePicker(context: context, initialTime: selectedEndTime);
                                if(selectedTime !=null){
                                  setState(() {
                                    selectedEndTime =selectedTime;
                                  });

                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(15),

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: MyColors.primarylight,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(text:  selectedEndTime.format(context).toString(), fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.grey_20),
                                    Icon(Icons.access_time, color: MyColors.grey_20,)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
               ],
             ),
           ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 1,
              color: MyColors.grey_60,
            ),
            SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: "Price", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_20),
                  CustomText(text: "5kr/1 hr", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.primary6)
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: "Total Price", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_20),
                  CustomText(text: "10kr/3 hrs", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.primary6)
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomButton(buttonText: "Continue", onTap: (){}, buttonTextColor: MyColors.primary1,btnColor: MyColors.primary6,),
            )





          ],
        ),
      ),
    );
  }
}
