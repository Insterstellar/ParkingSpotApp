import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parking/booking/booking_confirmation.dart';
import 'package:parking/misc/mycolors/mycolors.dart';
import 'package:parking/models/parking_model.dart';
import 'package:parking/widgets/custom_button.dart';
import 'package:parking/widgets/custom_text.dart';

class SetTimePage extends StatefulWidget {
  final int? parkingSpotId;
  final Parking? parking;
  const SetTimePage(
      {super.key, required this.parkingSpotId, required this.parking});

  @override
  State<SetTimePage> createState() => _SetTimePageState();
}

class _SetTimePageState extends State<SetTimePage> {
  double duration = 0;
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();
  double totalPrice = 0;

  DateTime currentDate = DateTime.now();
  double price = 0;
  @override
  Widget build(BuildContext context) {
    int? parkingSpotId = widget.parkingSpotId;

    Parking? parking = widget.parking;
    String? parkingPrice = parking!.price;
    if (parkingPrice != null) {
      price = double.parse(parkingPrice);
    }

    return Scaffold(
      backgroundColor: MyColors.primary1,
      appBar: AppBar(
        title: Text(
          "Set Date And Time",
          style: TextStyle(color: MyColors.grey_11),
        ),

        backgroundColor: MyColors.primary1,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    text: "Select Date",
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    textColor: MyColors.grey_11),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 270,
                  color: MyColors.grey_10,
                  child: CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2090),
                    onDateChanged: (value) {
                      currentDate = value;

                      print("new time -------is :" + currentDate.toString());
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(height: 1, color: MyColors.grey_20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     CustomText(
                        text: "Duration",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        textColor: MyColors.grey_11),
                    CustomText(
                        text: duration.round().toString() + " Hours",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        textColor: MyColors.grey_10),
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
                    onChanged: (value) {
                      setState(() {
                        duration = value;
                        totalPrice = duration * price;

                        print(
                            " the returned value of selected end time  :  " +
                                selectedEndTime.toString());
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
                          const CustomText(
                              text: "Start Time",
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              textColor: MyColors.grey_11),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final TimeOfDay? timeOfDay = await showTimePicker(
                                context: context,
                                initialTime: selectedStartTime,
                                initialEntryMode: TimePickerEntryMode.dial,
                              );
                              if (timeOfDay != null) {
                                setState(() {
                                  selectedStartTime = timeOfDay;
                                  //selectedEndTime = pickedEndTime;
                                  int startTime = selectedStartTime.hour;
                                  int endTime = selectedEndTime.hour;
                                  int difference = endTime - startTime;
                                  if (difference.isNegative) {
                                    difference = difference.abs();
                                  }
                                  duration = difference.toDouble();
                                  totalPrice = duration * price;
                                  //selectedStartTime.minute.toString().padLeft(2,'0');
                                });
                              }
                            },
                            child: Container(
                              height: 50,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: MyColors.grey_90,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                        text: selectedStartTime.format(context),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        textColor: MyColors.grey_20),
                                    Icon(
                                      Icons.access_time,
                                      color: MyColors.grey_20,
                                      size: 20,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                              text: "End Time",
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              textColor: MyColors.grey_11),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final pickedEndTime = await showTimePicker(
                                  context: context,
                                  initialTime: selectedEndTime);

                              if (pickedEndTime != null) {
                                setState(() {
                                  selectedEndTime = pickedEndTime;
                                  int startTime = selectedStartTime.hour;
                                  int endTime = selectedEndTime.hour;
                                  int difference = endTime - startTime;
                                  if (difference.isNegative) {
                                    difference = difference.abs();
                                  }

                                  duration = difference.toDouble();
                                  totalPrice = duration * price.toDouble();
                                });
                              }

                              print("picked end time is " +
                                  pickedEndTime.toString());
                            },
                            child: Container(
                              height: 50,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: MyColors.grey_90,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                        text: selectedEndTime
                                            .format(context)
                                            .toString(),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        textColor: MyColors.grey_20),
                                    const Icon(
                                      Icons.access_time,
                                      color: MyColors.grey_20,
                                      size: 20,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(height: 1, color: MyColors.grey_20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        text: "Price",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        textColor: MyColors.grey_11),
                    CustomText(
                        text: parking!.price.toString() + "/hr",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        textColor: MyColors.grey_11),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        text: "Total Price",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        textColor: MyColors.grey_11),
                    CustomText(
                        text: totalPrice.toString() + " Kr",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        textColor: MyColors.grey_11),
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
              child: CustomButton(
                buttonText: "C o n t i n u e",
                onTap: () {




                  if(selectedEndTime != selectedStartTime && price>0){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookingConfirmation(
                              parkingSpotId: parkingSpotId,
                              parking: parking,
                              selectedEndTime: selectedEndTime,
                              selectedStartTime: selectedStartTime,
                              totalPrice: totalPrice,
                              currentDate: currentDate,
                              duration: duration,
                            )));
                  }else{
                    const snackBar = SnackBar(
                      content: Text('Oops .Set time in Hours! '),

                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }


                },
                btnColor: MyColors.primary6,
                buttonTextColor: MyColors.primary1,
              ))
        ],
      ),
    );
  }
}
