import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parking/booking/booking_confirmation.dart';
import 'package:parking/misc/mycolors/mycolors.dart';
import 'package:parking/widgets/custom_button.dart';
import 'package:parking/widgets/custom_text.dart';

class SetTimePage extends StatefulWidget {
  const SetTimePage({super.key});

  @override
  State<SetTimePage> createState() => _SetTimePageState();
}

class _SetTimePageState extends State<SetTimePage> {
  double duration=0;
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();
   double totalPrice = 0;

DateTime currentDate = DateTime.now();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: MyColors.primary1,
      appBar: AppBar(
        title: Text("Set Date And Time",style: TextStyle(color: MyColors.grey_11),),
        backgroundColor: MyColors.primary1

      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "Select Date", fontWeight: FontWeight.bold, fontSize: 18, textColor: MyColors.grey_11),
                        SizedBox(
                          height: 10,


                        ),



                       Container(
                height: 270,
                color: MyColors.grey_10,
                         child: CalendarDatePicker(initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2090), onDateChanged: (value){

                           currentDate=value;

                           print("new time -------is :"+currentDate.toString());

                         },),

                        ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: MyColors.grey_20
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: "Duration", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_11),
                   CustomText(text: duration.round().toString()+" Hours", fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.grey_10),

                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Slider(
                    value: duration,
                    //min:0,
                    max: 24,
                    divisions: 24,
                    activeColor: MyColors.primary6,
                    thumbColor: MyColors.primary6,


                    label: "${duration.round()} Hours",
                    onChanged: (value){
                      setState(() {
                        duration=value;
                        totalPrice = duration*5.toDouble();

                        print(" the returned value is"+selectedEndTime.toString());
                      });


                    }),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: "Start Time", fontWeight: FontWeight.bold, fontSize: 16, textColor:MyColors.grey_11),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () async{


                          final TimeOfDay? timeOfDay = await showTimePicker  (
                                context: context,
                                initialTime: selectedStartTime,
                              initialEntryMode: TimePickerEntryMode.dial,
                            );
                          if(timeOfDay !=null){
                            setState(() {


                              selectedStartTime =timeOfDay;
                              //selectedEndTime = pickedEndTime;
                              int startTime = selectedStartTime.hour;
                              int endTime = selectedEndTime.hour;
                              int difference = endTime-startTime ;
                              if(difference.isNegative){
                                difference = difference.abs();
                              }
                              duration =difference.toDouble();
                              totalPrice = duration*5.toDouble();
                              //selectedStartTime.minute.toString().padLeft(2,'0');
                            });

                          }


                          },
                          child: Container(
                            height: 50,
                            width: double.maxFinite,

                            decoration: BoxDecoration(
                                color: MyColors.grey_90,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(text: selectedStartTime.format(context), fontWeight: FontWeight.bold, fontSize: 15, textColor: MyColors.grey_20),
                                  Icon(Icons.access_time, color: MyColors.grey_20,size: 20,)
                                ],
                              ),
                            ),

                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: "End Time", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_11),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: ()async{

                              final pickedEndTime =  await showTimePicker(
                                  context: context,
                                  initialTime: selectedEndTime);

                              if(pickedEndTime !=null){
                                setState(() {
                                         selectedEndTime = pickedEndTime;
                                         int startTime = selectedStartTime.hour;
                                         int endTime = selectedEndTime.hour;
                                         int difference = endTime-startTime ;
                                         if(difference.isNegative){
                                           difference = difference.abs();
                                         }

                                         duration =difference.toDouble();
                                         totalPrice = duration*5.toDouble();
                                });

                              }

                              print("picked end time is "+ pickedEndTime.toString());
                            },
                            child: Container(
                              height: 50,
                              width: double.maxFinite,

                              decoration: BoxDecoration(
                               color: MyColors.grey_90,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(text: selectedEndTime.format(context).toString(), fontWeight: FontWeight.bold, fontSize: 15, textColor: MyColors.grey_20),
                                    Icon(Icons.access_time, color: MyColors.grey_20,size: 20,)
                                  ],
                                ),
                              ),

                            ),
                          )
                        ],
                      ),
                  ),

                ],),
              ],
            ),
          ),
          Container(
              height: 1,
              color: MyColors.grey_20
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: "Price", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_11),
                    CustomText(text: "5kr/hr", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_11),


                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: "Total Price", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_11),

                    CustomText(text: totalPrice.toString()+" Kr", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_11),


                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 7,
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomButton(buttonText: "C o n t i n u e", onTap:(){
              print("here is the difference time ----------"+duration.round().toString());
              print("here is the difference time ----------"+selectedStartTime.toString());
              print("here is the difference time ----------"+selectedEndTime.toString());
              print("here is the difference time ----------"+totalPrice.toString());
              print("here is the difference time ----------".toString());

              Navigator.push(context, MaterialPageRoute(builder:
              (context)=>BookingConfirmation()));


             // print("here is the current date ---------- :"+difference.toString());


            }, btnColor: MyColors.primary6,buttonTextColor: MyColors.primary1,)
          )


        ],
      ),
    );
  }
}
