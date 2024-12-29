import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/intl.dart';
import 'package:parking/dialog/payment_confirmed_dialogue.dart';
import 'package:parking/misc/mycolors/mycolors.dart';
import 'package:parking/models/ProductRequest.dart';
import 'package:parking/models/SpotAvailable.dart';
import 'package:parking/models/stripe_response.dart';
import 'package:parking/repo/controller/stripe_controller.dart';
import 'package:parking/repo/services/product_request_service.dart';
import 'package:parking/widgets/custom_button.dart';
import 'package:parking/widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/PaymentIntentSheet.dart';
import '../models/parking_model.dart';
import '../repo/controller/parking_controller.dart';
import '../repo/services/ParkingServices.dart';

class BookingConfirmation extends StatefulWidget {
  final int? parkingSpotId;
  final Parking? parking;
  final TimeOfDay? selectedStartTime;
  final TimeOfDay? selectedEndTime ;
  final double? totalPrice  ;
  final DateTime? currentDate;
  final duration;
   const BookingConfirmation({super.key, required this.parkingSpotId, required this.parking, required this.selectedStartTime, required this.selectedEndTime, required this.totalPrice, required this.currentDate, required this.duration});

  @override
  State<BookingConfirmation> createState() => _BookingConfirmationState();
}



var stripeController = StripeController(ProductRequestService());

class _BookingConfirmationState extends State<BookingConfirmation> {

  var updateSpotController = ParkingController(ParkingServices());
  int userId=1;

  Future<void> openBrowser(String urlString) async {
    final Uri url = Uri.parse(urlString);


    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }



  @override
  Widget build(BuildContext context) {

    int? parkingSpotId                =widget.parkingSpotId;
    Parking? parking                  =widget.parking;
    TimeOfDay? selectedStartTime      =widget.selectedStartTime;
    TimeOfDay? selectedEndTime        =widget.selectedEndTime ;
    double? totalPrice                =widget.totalPrice  ;
    DateTime? currentDate =widget.currentDate;
    final duration =widget.duration;

    String dataFormat= currentDate!.year.toString()+"/"+currentDate!.month.toString()+"/"+currentDate.day.toString() ;
    return Scaffold(
      backgroundColor: MyColors.primary1,
      appBar: AppBar(
        title: const Text("Booking Confirmation",style: TextStyle(color: MyColors.grey_20),),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: MyColors.grey_20,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),


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
                   const SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: parking!.name.toString(), fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.grey_20),
                          SizedBox(height: 10,),
                          CustomText(text: parking!.location.toString(), fontWeight: FontWeight.w300, fontSize: 14, textColor: MyColors.grey_20),
                          SizedBox(height: 10,),
                          CustomText(text: parking.price.toString()+"kr/Hours", fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.primary6),
                        ],
                      ),
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
                     Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: "Date", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_20),

                              CustomText(text: dataFormat, fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_11),


                            ],
                          ),
                          SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CustomText(text: "Duration", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_20),

                              CustomText(text: duration.round().toString()+" Hrs", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_11),


                            ],
                          ),
                          SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: "Hours", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_20),

                              Row(
                                children: [
                                  CustomText(text: selectedStartTime!.format(context), fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_11),
                                  CustomText(text: " - ", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_11),
                                  CustomText(text: selectedEndTime!.format(context).toString(), fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_11),

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


                              CustomText(text: totalPrice.toString()+" Kr", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_11),


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

              CustomButton(buttonText: "Confirm Payment", onTap: () async{
                //parkingSpotId: parkingSpotId,
                //parking: parking,
                //selectedEndTime: selectedEndTime,
                //selectedStartTime: selectedStartTime,
                //totalPrice: totalPrice,
                //currentDate: currentDate,
                //duration: duration,




                //showDialog(context: context,builder: (_) => BookingConfirmationDialog() );

                DateTime startDateTime= DateTime(currentDate!.year,currentDate!.month, currentDate!.day,selectedStartTime.hour,selectedStartTime.minute);
                 DateTime endDateTime= DateTime(currentDate!.year,currentDate!.month, currentDate!.day,selectedEndTime.hour,selectedEndTime.minute);
               String formattedStartDate = DateFormat('yyyy-MM-ddTHH:mm:ss').format(startDateTime);
               String formattedEndDate = DateFormat('yyyy-MM-ddTHH:mm:ss').format(endDateTime);



                SpotAvailable spotAvailable = SpotAvailable();
                spotAvailable.id=parkingSpotId;
                spotAvailable.isOccupied=false;
                spotAvailable.duration=duration.round();
                spotAvailable.totalPrice=totalPrice;
                // to be refactored to coordinations . spotAvailable.parking!.location.toString()
                spotAvailable.parking=parking;
                spotAvailable.qrCodeNumber=1.toDouble();
               spotAvailable.startTime=startDateTime;
               spotAvailable.endTime=endDateTime;

             // updateSpotController.updateParkingSpot(userId, spotAvailable);
               ProductRequest productService = ProductRequest();
               productService.name= parking.name;
               productService.amount=1000;
               productService.currency="US";
               productService.quantity=1;
Stripe.publishableKey="pk_test_51NC6uKA24EkNE4sIYoQSSzpjdZrKABXWwuNfjZSjig4jYZzLskgrZB6dtYJOvW8xAOQZ0Dq1YFJWtfDy5liKdvYN00C3ka6fFv";
                PaymentIntentSheet stripeResponse = await stripeController.stripeResponse(productService);
                print("here is the ephemeral code --- :"+ stripeResponse.publishableKey.toString());

                try {
                  await Stripe.instance.initPaymentSheet(
                    paymentSheetParameters: SetupPaymentSheetParameters(
                      // Set to true for custom flow
                      customFlow: false,
                      // Main params
                      merchantDisplayName: 'Test Merchant',
                      paymentIntentClientSecret: stripeResponse.paymentIntent,
                      // Customer keys
                      customerEphemeralKeySecret: stripeResponse.ephemeralKey,
                      customerId: stripeResponse.customer,

                      style: ThemeMode.dark,
                    ),

                  );
                }catch(e){
                  print("first something went wrong with the payment---"+e.toString());
                }



               try {
                 await Stripe.instance.presentPaymentSheet();
               }catch(e){
                 print("something went wrong with the payment---"+e.toString());

               }


               // final url = Uri.parse(stripeResponse.sessionUrl.toString());
             //  openBrowser(stripeResponse.sessionUrl!);



               // print("the current date time--------------------"+jsonEncode(spotAvailable.toJson().toString()));
                //print("the current date time--------------------"+spotAvailable.parking!.location.toString());


              }, btnColor: MyColors.primary6,buttonTextColor: MyColors.primary1,),

            ],
          ),
        ),
      ),
    );
  }
}
