

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parking/misc/mycolors/mycolors.dart';
import 'package:parking/widgets/custom_button.dart';
import 'package:parking/widgets/custom_text.dart';

class ParkingContainerWidget extends StatelessWidget {
  final String imageUrl;
  const ParkingContainerWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 210,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.primarylight1
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColors.primarylight
              ),
              child: 
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: imageUrl.isEmpty ?Image.asset("assets/images/carpark.jpeg", height: 50,width: 50,fit: BoxFit.cover,) :
                          Image.network(
                            imageUrl,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                "assets/images/carpark.jpeg",
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            CustomText(text: "Central Parking", fontWeight: FontWeight.bold, fontSize: 14, textColor: MyColors.grey_20),
                            CustomText(text: "11th Central Parking bergen", fontWeight: FontWeight.w400, fontSize: 10, textColor: MyColors.grey_40),
                          ],
                        ),
                      ],
                    ),
                    Container(

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: MyColors. primarylight0
                      ),
                      child: IconButton(onPressed: (){
                        print("hello world");
                      }, icon: Icon(Icons.delete, color: MyColors.primary6,size: 20,), padding: EdgeInsets.all(0),),
                    ),

                  ],
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: "Distance", fontWeight: FontWeight.w600, fontSize: 12, textColor: MyColors.grey_40),
                      CustomText(text: "2.5km", fontWeight: FontWeight.w800, fontSize: 12, textColor: MyColors.grey_20),
                    ],
                  ),
                  Container(
                    height: 22,
                    width: 2,
                    color: MyColors.primarylight0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(text: "Pricing", fontWeight: FontWeight.w600, fontSize: 12, textColor: MyColors.grey_40),
                      CustomText(text: "2kr/hr", fontWeight: FontWeight.w800, fontSize: 12, textColor: MyColors.grey_20),
                    ],
                  ),
                  Container(
                    height: 22,
                    width: 2,
                    color: MyColors.primarylight0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomText(text: "Slots", fontWeight: FontWeight.w600, fontSize: 12, textColor: MyColors.grey_40),
                      CustomText(text: "10", fontWeight: FontWeight.w800, fontSize: 12, textColor: MyColors.grey_20),
                    ],
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: CustomButton(buttonText: "Edit", onTap: (){}, btnColor: MyColors.primary1,buttonTextColor: MyColors.grey_20,)),
                  SizedBox(width: 10,),
                  Expanded(child: CustomButton(buttonText: "Book Now", onTap: (){}, btnColor: MyColors.primary6,buttonTextColor: MyColors.primary1,)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
