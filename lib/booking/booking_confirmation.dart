import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking/dialog/payment_confirmed_dialogue.dart';
import 'package:parking/misc/mycolors/mycolors.dart';
import 'package:parking/widgets/custom_button.dart';
import 'package:parking/widgets/custom_text.dart';

class BookingConfirmation extends StatefulWidget {
  const BookingConfirmation({super.key});

  @override
  State<BookingConfirmation> createState() => _BookingConfirmationState();
}

class _BookingConfirmationState extends State<BookingConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary1,
      appBar: AppBar(
        title: const Text("Booking Confirmation",style: TextStyle(color: MyColors.grey_20),),

        backgroundColor: MyColors.primary1,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children:  [
              Container(
                padding: EdgeInsets.all(10.0) ,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: MyColors.primarylight,
                ),
                //height: 200,
                child: (
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("assets/images/carpark.jpeg", fit: BoxFit.cover, height: 100,width: 100,),
                   SizedBox(width: 10,),
                   const Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: "Bergen Parking Station", fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.grey_20),
                        SizedBox(height: 10,),
                        CustomText(text: "123th street togAlmingen", fontWeight: FontWeight.w300, fontSize: 14, textColor: MyColors.grey_20),
                        SizedBox(height: 10,),
                        CustomText(text: "5kr/Hours", fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.primary6),
                      ],
                    )
                  ],
                )
                ),
              ),
              SizedBox(height: 20,),

              Container(
              //  padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: MyColors.primarylight,
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: "Date", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_20),

                              CustomText(text: " 18/29/2004", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_11),


                            ],
                          ),
                          SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: "Duration", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_20),

                              CustomText(text: " 2Hours", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_11),


                            ],
                          ),
                          SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: "Hours", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_20),

                              Row(
                                children: [
                                  CustomText(text: " 2:00PM", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_11),
                                  CustomText(text: " - ", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_11),
                                  CustomText(text: " 3:00PM", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_11),

                                ],
                              ),


                            ],
                          ),
                          SizedBox(height: 8,),
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      color: MyColors.grey_60,
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: "Price", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_20),

                              CustomText(text: " 5Kr/hr", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_11),


                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: "Total Price", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_20),


                              CustomText(text: " 5Kr/hr", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_11),


                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8,),

                  ],
                ),
              ),

              SizedBox(height: 25,),

              CustomButton(buttonText: "Confirm Payment", onTap: (){

                showDialog(context: context,builder: (_) => BookingConfirmationDialog() );


              }, btnColor: MyColors.primary6,buttonTextColor: MyColors.primary1,),

            ],
          ),
        ),
      ),
    );
  }
}
