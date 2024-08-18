import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../misc/mycolors/mycolors.dart';
import '../../widgets/custom_text.dart';

class BookingCustomList extends StatelessWidget {
  final String viewTimer;
  final VoidCallback onTap;
  final VoidCallback viewTicket;
  const BookingCustomList({super.key, required this.viewTimer, required this.onTap, required this.viewTicket});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),

      child: Container(
        //height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: MyColors.primarylight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/carpark.jpeg", fit: BoxFit.cover, height: 100,width: 100,),
                  SizedBox(width: 10,),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5,),
                      CustomText(text: "Bergen Parking Station", fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.grey_20),
                      SizedBox(height: 5,),
                      CustomText(text: "123th street togAlmingen", fontWeight: FontWeight.w400, fontSize: 13, textColor: MyColors.grey_20),
                      SizedBox(height: 5,),
                      CustomText(text: "9/82034", fontWeight: FontWeight.w400, fontSize: 13, textColor: MyColors.grey_20),
                      SizedBox(height: 5,),
                      CustomText(text: "5kr/Hours", fontWeight: FontWeight.w400, fontSize: 13, textColor: MyColors.grey_20),
                    ],
                  )

                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                color: MyColors.primarylight1,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: GestureDetector(
                    onTap: onTap,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: CustomText(text: viewTimer, fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.primary6)),
                    ),
                  )),
                  Expanded(
                    child: GestureDetector(
                      onTap: viewTicket,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only( bottomRight: Radius.circular(8)),
                            color: MyColors.primary6,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: CustomText(text: "View Ticket", fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.primary1)),
                          )),
                    ),
                  ),


                ],
              ),
            ),

          ],
        ),

      ),
    );
  }
}
