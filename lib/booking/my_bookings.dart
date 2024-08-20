import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:parking/booking/parking_ticket.dart';
import 'package:parking/booking/parkingstate/parking_time_status.dart';
import 'package:parking/misc/mycolors/mycolors.dart';
import 'package:parking/widgets/custom_button.dart';
import 'package:parking/widgets/custom_text.dart';

import 'customBookingWidgets/booking_custom_list.dart';



class MyBooking extends StatefulWidget {
  const MyBooking({super.key});

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> with TickerProviderStateMixin {

  final scaffoldState = GlobalKey<ScaffoldState>();
  void _showSheet() {
    // Show BottomSheet here using the Scaffold state instead of the Scaffold context
    scaffoldState.currentState
        ?.showBottomSheet((context){
          return Container(
              height: 290,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16,),
                Container(
                  height: 2,
                  color: MyColors.primarylight,
                  width: 100,
                ),
                SizedBox(height: 16,),
                CustomText(text: "Cancel Booking", fontWeight: FontWeight.w700, fontSize: 18, textColor: MyColors.grey_90),
                SizedBox(height: 16,),
                Container(
                  height: 1,
                  color: MyColors.grey_60,

                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(

                    children: [
                      CustomText(text: "Are you sure you want to cancer to reservation ?", fontWeight: FontWeight.w700, fontSize: 18, textColor: MyColors.grey_90),
                      SizedBox(height: 10,),
                      CustomText(text: "Nothing can be refunded according to our policy", fontWeight: FontWeight.w400, fontSize: 16, textColor: MyColors.grey_60),
                    SizedBox(height: 30,),
                      Row(
                        children: [
                          Expanded(child: CustomButton(buttonText: "Back", onTap: (){
                            Navigator.pop(context);
                          })),
                          SizedBox(width: 10,),
                          Expanded(child: CustomButton(buttonText: "Continue", onTap: (){}, btnColor: MyColors.primary6, buttonTextColor: MyColors.primary1,))
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
  void _showReviewSheet(){
    scaffoldState.currentState?.showBottomSheet((context) => Container(
      height:350,
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16,),
          Container(
            height: 2,
            color: MyColors.primarylight,
            width: 100,
          ),
          SizedBox(height: 16,),
          const CustomText(text: "Your Review", fontWeight: FontWeight.w700, fontSize: 18, textColor: MyColors.grey_90),
          SizedBox(height: 16,),
          CustomText(text: "Please rate Bergen Parking Station", fontWeight: FontWeight.w700, fontSize: 18, textColor: MyColors.grey_90),
          CustomText(text: "*******", fontWeight: FontWeight.w700, fontSize: 40, textColor: MyColors.grey_90),
         // Container(height: 15),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4))
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: TextField(
                    maxLines: 4,
                    minLines: 3,
                    maxLength: 200,
                    keyboardType: TextInputType.text,
                    controller: new TextEditingController(),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(-12), border: InputBorder.none,
                        hintText: "Write a review ...", hintStyle: TextStyle(color:MyColors.grey_40)
                    ),
                  )
              ),
            ),
          ),
          Container(height: 1),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(child: CustomButton(buttonText: "Cancel", onTap: (){
                  Navigator.pop(context);
                })),
                SizedBox(width: 10,),
                Expanded(child: CustomButton(buttonText: "Send", onTap: (){}, btnColor: MyColors.primary6, buttonTextColor: MyColors.primary1,))
              ],
            ),
          ),




        ],
      ),

    ), backgroundColor: MyColors.grey_5, );
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController=TabController(length: 2, vsync: this)  ;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: MyColors.primary1,

          title: CustomText(text: "My Booking", fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.grey_20),
          leading: IconButton(
            icon: Icon(Icons.chevron_left, color: MyColors.grey_20,),
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
                  //isScrollable: true,
                  // labelStyle: TextStyle(color: Colors.red),
                  indicatorColor: MyColors.primary6,
                  dividerColor: MyColors.grey_95,
                  //unselectedLabelColor: MyColors.grey_20,
                  // indicator: TabBarIndicatorSize.label,

                  tabs: const [
                    Tab(text: "Ongoing Booking",),
                    Tab(text: "Booking History",),

                  ]),
            ),

            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 8,right: 12,left: 8),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                //color: Colors.blue,
                child: TabBarView(
                    controller: tabController,
                    children: [
              
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),

                          child: CustomText(text: "Active now", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.primary6),
                        ),
                        SizedBox(height: 5,),
                        BookingCustomList(viewTimer: "View Timer",onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return const ParkingStatusTime();
                          }));

                        }, viewTicket: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ParkingTicket()));
                        },),


                        //------------reserved page----------//
                        SizedBox(height: 5,),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),

                          child: CustomText(text: "Reserved", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.primary6),
                        ),
                        SizedBox(height: 5,),
                        Expanded(
                          child: ListView(
                              children :[
                                BookingCustomList(viewTimer: "Cancel Booking",onTap: (){
                                  _showSheet();


                                    },
                                  viewTicket: () {print("------cancel view ticket")   ;   },),


                              ]),
                        )

                      ],
                    ),
              
                      ListView(
                        children: [
                          BookingCustomList(viewTimer: "Rate",onTap: (){
                            _showReviewSheet();
                             ;
                          }, viewTicket: () {print("review ticket") ;   },),





                        ],
                      ),//tab bar
              
              
              
                      //
              
              
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
