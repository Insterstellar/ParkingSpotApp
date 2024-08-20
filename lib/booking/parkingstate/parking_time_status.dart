import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking/misc/mycolors/mycolors.dart';
import 'package:parking/widgets/custom_button.dart';

import '../../widgets/custom_text.dart';
import 'exntended_parking_time.dart';

class ParkingStatusTime extends StatefulWidget {
  const ParkingStatusTime({super.key});

  @override
  State<ParkingStatusTime> createState() => _ParkingStatusTimeState();
}

class _ParkingStatusTimeState extends State<ParkingStatusTime> {

  Duration duration= Duration(hours:2 ,minutes:00,seconds: 00);
  String hoursStr   ="" ;
  String minutesStr  = "";
  String secondsStr  = "";
  @override
  void initState() {
    // TODO: implement initState
   // startTime();
    super.initState();
  }

  void startTime(){
    int addSeconds=1;

    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        int seconds =duration.inSeconds-addSeconds;
        duration= Duration(seconds: seconds);
        hoursStr = (duration.inHours).toString().padLeft(2, '0');
        minutesStr = (duration.inMinutes % 60).toString().padLeft(2, '0');
        secondsStr = (seconds % 60).toString().padLeft(2, '0');
        if(duration.inHours==0 && duration.inMinutes==0){
          duration=Duration(seconds: 0);

          timer.cancel();
        }

      });

    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary1,
      appBar: AppBar(
        backgroundColor: MyColors.primary1,
        title: const CustomText(text: "Parking Time", fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.grey_20),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: MyColors.grey_20,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

      ),
      //                child: Center(child: Text(hoursStr +" : "+minutesStr+" : "+secondsStr, style: TextStyle(fontSize: 50, color: Colors.white),)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView (
            children: [
              Container(
                height: 250,
                color: MyColors.primarylight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: MyColors.grey_20
                        ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(hoursStr , style: TextStyle(fontSize: 50, color: MyColors.primary1),),
                          )),
                      CustomText(text: " : ", fontWeight: FontWeight.bold, fontSize: 50, textColor: MyColors.grey_20),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: MyColors.grey_20
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(minutesStr , style: TextStyle(fontSize: 50, color: MyColors.primary1),),
                          )),
                      CustomText(text: " : ", fontWeight: FontWeight.bold, fontSize: 50, textColor: MyColors.grey_20),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: MyColors.grey_20
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(secondsStr , style: TextStyle(fontSize: 50, color: MyColors.primary1),),
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: MyColors.primarylight,
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: "Name", fontWeight: FontWeight.w300, fontSize: 14, textColor: MyColors.grey_20),
                              CustomText(text: "Mandy Ronald", fontWeight: FontWeight.bold, fontSize: 12, textColor: MyColors.grey_20),

                            ],
                          ),
                          SizedBox(width: 5,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomText(text: "Parking Place", fontWeight: FontWeight.w300, fontSize: 14, textColor: MyColors.grey_20),
                              CustomText(text: "146th South Street Bergen", fontWeight: FontWeight.bold, fontSize: 12, textColor: MyColors.grey_20),

                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Container(
                        height: 1,
                        color: MyColors.grey_60,
                      ) ,
                      SizedBox(height: 10,),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: "Duration", fontWeight: FontWeight.w300, fontSize: 14, textColor: MyColors.grey_20),
                              CustomText(text: "6 Hours", fontWeight: FontWeight.bold, fontSize: 12, textColor: MyColors.grey_20),

                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomText(text: "Date", fontWeight: FontWeight.w300, fontSize: 14, textColor: MyColors.grey_20),
                              CustomText(text: "2/12/2024", fontWeight: FontWeight.bold, fontSize: 12, textColor: MyColors.grey_20),

                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Container(
                        height: 1,
                        color: MyColors.grey_60,
                      ) ,
                      SizedBox(height: 10,),
                      Column(

                        children: [
                          CustomText(text: "Hours", fontWeight: FontWeight.w300, fontSize: 14, textColor: MyColors.grey_20),
                          CustomText(text: "2:00pm - 7:00pm", fontWeight: FontWeight.bold, fontSize: 12, textColor: MyColors.grey_20),

                        ],
                      ),



                    ],
                  ),
                ),
              ),


              SizedBox(
                height: 16,
              ),
              CustomButton(buttonText: "Extend Parking Time",
                onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ExtendParkingTime()));


               // print("the new time is..........."+newTime.toString());

              }, buttonTextColor: MyColors.primary1,btnColor: MyColors.primary6,)
            ],
          ),
        ),

      ),

    );
  }
}
