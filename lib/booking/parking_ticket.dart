import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../misc/mycolors/mycolors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';

class ParkingTicket extends StatefulWidget {
  const ParkingTicket({super.key});

  @override
  State<ParkingTicket> createState() => _ParkingTicketState();
}

class _ParkingTicketState extends State<ParkingTicket> {
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: MyColors.primary1 ,
      appBar: AppBar(
        backgroundColor: MyColors.primary1,
        title: const CustomText(text: "Parking Ticket", fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.grey_20),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: MyColors.grey_20,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: MyColors.primarylight,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    CustomText(text: "Parking Details", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_20),
                    SizedBox(height: 20,),
                    QrImageView(
                      data: 'mandy Ronald',
                      version: QrVersions.auto,
                      backgroundColor: MyColors.primary6,
                      foregroundColor: MyColors.primary1,
                      size: 200.0,
                    ),
                    SizedBox(height: 25,),
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
                            CustomText(text: "Parking Location", fontWeight: FontWeight.w300, fontSize: 14, textColor: MyColors.grey_20),
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
              height: 20,
            ),
            CustomButton(buttonText: "Get direction",
              onTap: (){
              print("Open Map");


              }, buttonTextColor: MyColors.primary1,btnColor: MyColors.primary6,)

          ],
        ),
      ),
    );
  }
}
