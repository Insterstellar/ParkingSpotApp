import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:parking/booking/parking_ticket.dart';
import 'package:parking/booking/parkingstate/parking_time_status.dart';
import 'package:parking/misc/mycolors/mycolors.dart';
import 'package:parking/models/SpotAvailable.dart';
import 'package:parking/models/parking_model.dart';
import 'package:parking/models/reveiw_parking.dart';
import 'package:parking/models/user_parking.dart';
import 'package:parking/repo/controller/user_parking_controller.dart';
import 'package:parking/repo/services/user_parking_service.dart';
import 'package:parking/util/coordinates_to_address.dart';
import 'package:parking/widgets/custom_button.dart';
import 'package:parking/widgets/custom_text.dart';

import 'customBookingWidgets/booking_custom_list.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({super.key});

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> with TickerProviderStateMixin {
  late TextEditingController _controller;
 int userId =1;
 int parkingId=1;

  @override
  void initState() {
    super.initState();
    activeSpotDetails();
    reservedParkingSpot();
    _controller = TextEditingController();

  }


  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  final scaffoldState = GlobalKey<ScaffoldState>();



  void _showSheet() {
    // Show BottomSheet here using the Scaffold state instead of the Scaffold context
    scaffoldState.currentState?.showBottomSheet((context) {
      return Container(
        height: 290,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 16,
            ),
            Container(
              height: 2,
              color: MyColors.primarylight,
              width: 100,
            ),
            SizedBox(
              height: 16,
            ),
            CustomText(
                text: "Cancel Booking",
                fontWeight: FontWeight.w700,
                fontSize: 18,
                textColor: MyColors.grey_90),
            SizedBox(
              height: 16,
            ),
            Container(
              height: 1,
              color: MyColors.grey_60,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomText(
                      text: "Are you sure you want to cancel reservation ?",
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      textColor: MyColors.grey_90),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                      text: "Nothing can be refunded according to our policy",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      textColor: MyColors.grey_60),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: CustomButton(
                              buttonText: "Back",
                              onTap: () {
                                Navigator.pop(context);
                              })),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: CustomButton(
                        buttonText: "Continue",
                        onTap: () {},
                        btnColor: MyColors.primary6,
                        buttonTextColor: MyColors.primary1,
                      ))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }, backgroundColor: MyColors.grey_10);
  }
var addReviewController = UserParkingController(UserParkingService());
  void _showReviewSheet() {
    scaffoldState.currentState?.showBottomSheet(
      (context) => Container(
        height: 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 16,
            ),
            Container(
              height: 2,
              color: MyColors.primarylight,
              width: 100,
            ),
            SizedBox(
              height: 16,
            ),
            const CustomText(
                text: "Your Review",
                fontWeight: FontWeight.w700,
                fontSize: 18,
                textColor: MyColors.grey_90),
            SizedBox(
              height: 16,
            ),
            CustomText(
                text: "Please rate Bergen Parking Station",
                fontWeight: FontWeight.w700,
                fontSize: 18,
                textColor: MyColors.grey_90),
            CustomText(
                text: "*******",
                fontWeight: FontWeight.w700,
                fontSize: 40,
                textColor: MyColors.grey_90),
            // Container(height: 15),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    child: TextField(
                      maxLines: 4,
                      minLines: 3,
                      maxLength: 200,
                      keyboardType: TextInputType.text,
                      controller: _controller,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(-12),
                          border: InputBorder.none,
                          hintText: "Write a review ...",
                          hintStyle: TextStyle(color: MyColors.grey_40)),
                    )),
              ),
            ),
            Container(height: 1),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                      child: CustomButton(
                          buttonText: "Cancel",
                          onTap: () {
                            Navigator.pop(context);
                          })),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: CustomButton(
                    buttonText: "Send",
                    onTap: () {
                      ReviewParking reviewParking = ReviewParking();
                      reviewParking.stars=2;
                      reviewParking.comment=_controller.value.text.toString();

                     // print("this is what am typing now "+reviewParking.comment.toString());

                      addReviewController.addReview(reviewParking, userId, parkingId);
                      Navigator.pop(context);

                    },
                    btnColor: MyColors.primary6,
                    buttonTextColor: MyColors.primary1,
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: MyColors.grey_5,
    );
  }

  int userid = 1;
  String? location;
  Parking? parking;
  //String date;







  UserParking activeParking = UserParking();

  Future<void> activeSpotDetails() async {
    var activeSpotController = UserParkingController(UserParkingService());
    var active_spot = await activeSpotController.activeSpot(userid);
    activeParking = active_spot;
    parking = activeParking.bookedSpot?.parking;
    String? coordinates = parking?.location;
    if(coordinates !=null){
      AddressConverter addressConverter = AddressConverter();
      location = await addressConverter.coordinatesToAddres(coordinates);
      if(location!=null){
        setState(() {
        });
      }
    }


  }
  List<SpotAvailable>? reservedSpot=[];
  Parking? park;
  String? streetAddress;
  UserParking reservedSpots =UserParking();
List<Parking> parkSPot =[];

  Future<void> reservedParkingSpot() async{
    var reservedController = UserParkingController(UserParkingService());
     reservedSpots = await reservedController.reservedSpots(userid);
     setState(() {

     });
    reservedSpot = reservedSpots.reservedParking;
    for(int a =0; a<reservedSpot!.length ; a++){


            park =reservedSpot?[a].parking;


            String? coordinatess =  park?.location;
        AddressConverter addressConverter = AddressConverter();

        streetAddress = await addressConverter.coordinatesToAddres(coordinatess!);

        park?.location=streetAddress;
        parkSPot.add(park!);






    }




  }





  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primary1,
        title: CustomText(
            text: "My Booking",
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
      key: scaffoldState,
      backgroundColor: MyColors.primary1,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.maxFinite,
              child: TabBar(
                  controller: tabController,
                  labelColor: MyColors.primary6,
                  labelStyle: TextStyle(fontSize: 12),
                  //isScrollable: true,
                  // labelStyle: TextStyle(color: Colors.red),
                  indicatorColor: MyColors.primary6,
                  dividerColor: MyColors.grey_95,
                  //unselectedLabelColor: MyColors.grey_20,
                  // indicator: TabBarIndicatorSize.label,

                  tabs: const [
                    Tab(
                      text: "Ongoing Booking",
                    ),
                    Tab(
                      text: "Reserved",
                    ),
                    Tab(
                      text: "Booking History",
                    ),
                  ]),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 8, right: 12, left: 8),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                //color: Colors.blue,
                child: TabBarView(controller: tabController, children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: CustomText(
                            text: "Active now",
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            textColor: MyColors.primary5),
                      ),
                      SizedBox(
                        height: 5,
                      ),

                      parking==null ? Container() :BookingCustomList(
                          stationName: parking?.name,
                          streetName: location,
                          price: parking?.price,
                          viewTimer: "View Timer",
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ParkingStatusTime(
                                userParking: activeParking,
                              );
                            }));
                          },
                          viewTicket: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ParkingTicket(
                                          userParking: activeParking,
                                        )));
                          }),

                      //------------reserved page----------//
                      const SizedBox(
                        height: 5,
                      ),

                    ],
                  ),

                    ListView.builder(
                        itemCount:reservedSpot?.length ?? 0,
                        itemBuilder: (context, index) {
                          Parking? spots = parkSPot[index];

                          return BookingCustomList(
                            viewTimer: "Cancel Booking",price: spots.price,stationName: spots.name, streetName: spots.location,
                            onTap: () {
                              _showSheet();
                            },
                            viewTicket: () {
                              reservedSpots.bookedSpot = reservedSpot?[index];
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ParkingTicket(
                                        userParking: reservedSpots,
                                      )));


                            },
                          );
                        }
                    ),

                  ListView(
                    children: [
                      BookingCustomList(
                        viewTimer: "Rate",
                        onTap: () {
                          _showReviewSheet();
                        },
                        viewTicket: () {
                          print("review ticket");
                        },
                      ),
                    ],
                  ), //tab bar
                ]),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
