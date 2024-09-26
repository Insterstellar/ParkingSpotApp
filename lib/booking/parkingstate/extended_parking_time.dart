import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parking/models/parking_model.dart';
import 'package:parking/models/user_parking.dart';
import 'package:parking/repo/controller/user_parking_controller.dart';
import 'package:parking/repo/services/user_parking_service.dart';
import 'package:parking/widgets/custom_button.dart';

import '../../misc/mycolors/mycolors.dart';
import '../../models/SpotAvailable.dart';
import '../../widgets/custom_text.dart';

class ExtendParkingTime extends StatefulWidget {
  final UserParking userParking ;
  const ExtendParkingTime({super.key, required this.userParking});

  @override
  State<ExtendParkingTime> createState() => _ExtendParkingTimeState();
}

class _ExtendParkingTimeState extends State<ExtendParkingTime> {
  double duration=0;
  TimeOfDay ?selectedStartTime ;
  TimeOfDay selectedEndTime =TimeOfDay.now();
  TimeOfDay ?selectedOldEndTime ;
   UserParking? userParking;
  DateTime ?timeSelected ;
   int userId=1;

   double? totalPrice;
   double price =0;

  @override
  void initState() {
    // TODO: implement initState
    extendTime();
    super.initState();
  }
  void extendTime(){
    userParking =widget.userParking;
    SpotAvailable? spotAvailable =userParking?.bookedSpot;
   DateTime? startTime =spotAvailable?.startTime;
   DateTime? endTime =spotAvailable?.endTime;
    setState(() {
       selectedStartTime =TimeOfDay(hour:startTime!.hour,minute: startTime.minute );
       selectedEndTime   =TimeOfDay(hour:endTime!.hour,minute: endTime!.minute );
       selectedOldEndTime =TimeOfDay(hour:endTime!.hour,minute: endTime!.minute );
       totalPrice= spotAvailable?.totalPrice;
       Parking? parking = userParking?.bookedSpot?.parking;
       String? newPrice= parking?.price;
         price=double.parse(newPrice!);


    });



  }

  var extendTimeController = UserParkingController(UserParkingService());


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
                            Container(
                              padding: EdgeInsets.all(15),

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: MyColors.primarylight,
                              ),
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(text: selectedStartTime!.format(context).toString(), fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.grey_20),
                                  Icon(Icons.access_time, color: MyColors.grey_20,)
                                ],
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
                                    print("this the new time now "+ selectedEndTime.toString());
                                    print("this the new time now "+ selectedOldEndTime.toString());

                                    DateTime initialTime = DateTime(DateTime.now().year, DateTime.now().month,DateTime.now().day, selectedOldEndTime!.hour, selectedOldEndTime!.minute);
                                    DateTime newTime = DateTime(DateTime.now().year, DateTime.now().month,DateTime.now().day, selectedEndTime.hour, selectedEndTime.minute);

                                    Duration difference = newTime.difference(initialTime);
                                    int minute =difference.inMinutes%60;
                                    if(difference.isNegative || difference.inHours<=0 && difference.inMinutes<=0){
                                      print("time cannot be negative . Time cannot be lesser than the initial time");

                                    }else{
                                      print("The check time date------------- is "+difference.inHours.toString()+":"+minute.toString());
                                      totalPrice=(price*difference.inHours.toDouble());
                                      duration=difference.inHours.toDouble();
                                      timeSelected=DateTime(DateTime.now().year, DateTime.now().month,DateTime.now().day, difference.inHours, minute);
                                      print("The check time total price------------- is "+totalPrice.toString());


                                    }
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
                                    CustomText(text:  selectedEndTime!.format(context).toString(), fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.grey_20),
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
                  CustomText(text: "${price}kr/hr", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.primary6)
                ],
              ),
            ),

             Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: "Total Price", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_20),
                  CustomText(text: "${totalPrice}kr", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.primary6)
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomButton(buttonText: "Continue", onTap: (){

                SpotAvailable extendedTime = SpotAvailable();

              if(timeSelected!=null){
                extendedTime.endTime=timeSelected;
                extendedTime.totalPrice=totalPrice;

             extendTimeController.extendParkingTime(userId, extendedTime);
             Navigator.pop(context);

              }else{

                print("Time cannot be lesser than the initial time");
              }








              }, buttonTextColor: MyColors.primary1,btnColor: MyColors.primary6,),
            )





          ],
        ),
      ),
    );
  }
}
