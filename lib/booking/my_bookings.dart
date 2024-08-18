import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parking/misc/mycolors/mycolors.dart';
import 'package:parking/widgets/custom_text.dart';

import 'customBookingWidgets/booking_custom_list.dart';



class MyBooking extends StatefulWidget {
  const MyBooking({super.key});

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    TabController tabController=TabController(length: 2, vsync: this)  ;
    return Scaffold(
      backgroundColor: MyColors.primary1,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(child: CustomText(text: "My Booking", fontWeight: FontWeight.bold, fontSize: 20, textColor: MyColors.grey_20)),
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
                          print("rate------22")   ;
                        }, viewTicket: () { print("ViewTimer ticket"); },),
                        //----------------------
                        SizedBox(height: 5,),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),

                          child: CustomText(text: "Paid", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.primary6),
                        ),
                        SizedBox(height: 5,),
                        Expanded(
                          child: ListView(
                              children :[
                                BookingCustomList(viewTimer: "Cancel Booking",onTap: (){print("------cancel booking")   ;  }, viewTicket: () {print("------cancel view ticket")   ;   },),
                                  BookingCustomList(viewTimer: "Cancel Booking",onTap: (){print("------cancel booking")   ;  }, viewTicket: () {print("------cancel view ticket")   ;   },),

                                  BookingCustomList(viewTimer: "Cancel Booking",onTap: (){print("------cancel booking")   ;  }, viewTicket: () {print("------cancel view ticket")   ;   },),

                                  BookingCustomList(viewTimer: "Cancel Booking",onTap: (){print("------cancel booking")   ;  }, viewTicket: () {print("------cancel view ticket")   ;   },),

                              ]),
                        )

                      ],
                    ),
              
                      ListView(
                        children: [
                          BookingCustomList(viewTimer: "Rate",onTap: (){
                            print("rate rate")   ;
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
