import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:parking/misc/mycolors/mycolors.dart';
import 'package:parking/models/SpotAvailable.dart';
import 'package:parking/models/user_parking.dart';
import 'package:parking/widgets/custom_button.dart';

import '../../repo/controller/user_parking_controller.dart';
import '../../repo/services/user_parking_service.dart';
import '../../widgets/custom_text.dart';
import 'extended_parking_time.dart';

class ParkingStatusTime extends StatefulWidget {
  final UserParking userParking;
  const ParkingStatusTime({super.key, required this.userParking});

  @override
  State<ParkingStatusTime> createState() => _ParkingStatusTimeState();
}

class _ParkingStatusTimeState extends State<ParkingStatusTime> {
  UserParking userParking = UserParking();
  SpotAvailable spotAvailable = SpotAvailable();
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String? locationConcatenation;
  //Duration duration= Duration(hours:2 ,minutes:00,seconds: 00);
  final remainingTimeController = StreamController<Duration>.broadcast();
  StreamSink<Duration> get sinkRemainingTime => remainingTimeController.sink;
  Stream<Duration> get streamReamingTime => remainingTimeController.stream;

  // String hoursStr = "";
  // String minutesStr = "";
  // String secondsStr = "";
  int userid = 1;
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    startRequestingRemaingTime();
    requestRemainingTime();
    parkingTime();

    super.initState();
  }

  void parkingTime() async {
    userParking = widget.userParking;
    spotAvailable = userParking.bookedSpot!;

    startTime = TimeOfDay(
        hour: spotAvailable.startTime!.hour,
        minute: spotAvailable.startTime!.minute);
    endTime = TimeOfDay(
        hour: spotAvailable.endTime!.hour,
        minute: spotAvailable.endTime!.minute);

    String? location = userParking.bookedSpot?.parking?.location;
    if (location != null) {
      List<String> coordinates = location.split(',');
      double latitude = double.parse(coordinates[0].trim());
      double longitude = double.parse(coordinates[1].trim());
      List<Placemark> placeMark =
          await placemarkFromCoordinates(latitude, longitude);

      if (placeMark.isNotEmpty) {
        var address = placeMark.first;
        setState(() {
          locationConcatenation =
              "${address.street} ${address.postalCode}, ${address.subAdministrativeArea}";
        });
      }
    }
  }

  Future<Duration> requestRemainingTime() async {
    Duration duration;
    var activeSpotController = UserParkingController(UserParkingService());
    var active_spot = await activeSpotController.activeSpot(userid);
    String? time = active_spot.bookedSpot?.remainingTime;

    List<String>? formatedTime = time?.split(':');
    duration = Duration(
        hours: int.parse(formatedTime![0]),
        minutes: int.parse(formatedTime[1]),
        seconds: int.parse(formatedTime[2]));
    sinkRemainingTime.add(duration);

    //print(" current remaining time -------- :${duration.inHours}:${duration.inMinutes %60}:${duration.inSeconds %60}");

    return duration;
  }

  void startRequestingRemaingTime() {
    timer=Timer.periodic(const Duration(seconds: 1), (timer) async {
      Duration duration = await requestRemainingTime();
      if (duration.inHours == 0 &&
          duration.inMinutes == 0 &&
          duration.inSeconds == 0) {
        timer.cancel();
        print("Current time stopped");
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary1,
      appBar: AppBar(
        backgroundColor: MyColors.primary1,
        title: const CustomText(
            text: "Parking Time",
            fontWeight: FontWeight.w600,
            fontSize: 16,
            textColor: MyColors.grey_20),
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: MyColors.grey_20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      //                child: Center(child: Text(hoursStr +" : "+minutesStr+" : "+secondsStr, style: TextStyle(fontSize: 50, color: Colors.white),)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              StreamBuilder<Duration>(
                  stream: streamReamingTime,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Duration? leftTime = snapshot.data;
                      String hoursStr =
                          (leftTime?.inHours).toString().padLeft(2, '0');
                      String minutesStr =
                          (leftTime!.inMinutes % 60).toString().padLeft(2, '0');
                      String secondsStr =
                          (leftTime!.inSeconds % 60).toString().padLeft(2, '0');

                      return Container(
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
                                      color: MyColors.grey_20),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      hoursStr,
                                      style: TextStyle(
                                          fontSize: 50,
                                          color: MyColors.primary1),
                                    ),
                                  )),
                              CustomText(
                                  text: " : ",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50,
                                  textColor: MyColors.grey_20),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: MyColors.grey_20),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      minutesStr,
                                      style: TextStyle(
                                          fontSize: 50,
                                          color: MyColors.primary1),
                                    ),
                                  )),
                              CustomText(
                                  text: " : ",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50,
                                  textColor: MyColors.grey_20),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: MyColors.grey_20),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      secondsStr,
                                      style: TextStyle(
                                          fontSize: 50,
                                          color: MyColors.primary1),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
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
                              CustomText(
                                  text: "Name",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                  textColor: MyColors.grey_20),
                              CustomText(
                                  text: userParking.username ?? "",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  textColor: MyColors.grey_20),
                            ],
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomText(
                                  text: "Parking Place",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                  textColor: MyColors.grey_20),
                              CustomText(
                                  text: locationConcatenation ?? "",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  textColor: MyColors.grey_20),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 1,
                        color: MyColors.grey_60,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                  text: "Duration",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                  textColor: MyColors.grey_20),
                              CustomText(
                                  text:
                                      "${spotAvailable.duration.toString()} Hrs",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  textColor: MyColors.grey_20),
                            ],
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomText(
                                  text: "Date",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                  textColor: MyColors.grey_20),
                              CustomText(
                                  text: "2/12/2024",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  textColor: MyColors.grey_20),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 1,
                        color: MyColors.grey_60,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          CustomText(
                              text: "Hours",
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              textColor: MyColors.grey_20),
                          CustomText(
                              text:
                                  "${startTime?.format(context)} - ${endTime?.format(context)}",
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              textColor: MyColors.grey_20),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              CustomButton(
                buttonText: "Extend Parking Time",
                onTap: () async {
                  // timer?.cancel();
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ExtendParkingTime(userParking: userParking,)));
                 // startRequestingRemaingTime();
                },
                buttonTextColor: MyColors.primary1,
                btnColor: MyColors.primary6,
              )
            ],
          ),
        ),
      ),
    );
  }
}
