import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking/misc/mycolors/mycolors.dart';
import 'package:parking/widgets/custom_button.dart';
import 'package:parking/widgets/custom_text.dart';
class CustomListWidget extends StatelessWidget {
  final String parkingName;
  final String address;
  final String price;
  final String distance;
  final String imageUrl;
  final VoidCallback onTap;
  final VoidCallback addFavorite;
  final bool isAdded;
  final bool deleteButton;
  const CustomListWidget({super.key, required this.parkingName,required this.price,required this.distance, required this.address,required this.onTap, required this.imageUrl, required this.addFavorite, required this.isAdded, this.deleteButton=false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.only(bottom: 14),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: MyColors.primarylight1,
      ),child:  Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0, top: 0, right: 0),
          child: Container(
            decoration: const BoxDecoration(
                color: MyColors.primarylight,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))
            ),
            child:  Padding(
              padding: EdgeInsets.only(top: 8,left: 8,right: 8,bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
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
                        SizedBox(width: 15,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: parkingName, fontWeight: FontWeight.w700, fontSize: 16, textColor: MyColors.grey_1),
                            CustomText(text: address, fontWeight: FontWeight.w300, fontSize: 13.6, textColor: MyColors.grey_1),
                          ],
                        ),
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: addFavorite,
                    child: isAdded ?Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: MyColors.primarylight0
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.favorite_border, size: 16,color: MyColors.grey_1,),
                        )) :deleteButton ?Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: MyColors.primarylight0
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.delete_outline_rounded, size: 16,color: MyColors.primary6,),
                        )) : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: MyColors.primary6
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.favorite_border, size: 16,color: MyColors.primary1,),
                        )) ,
                  )
                ],),
            ),
          ),
        ),
        SizedBox(height: 6,),

        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(text: "Distance", fontWeight: FontWeight.w300, fontSize: 12, textColor: MyColors.grey_3),
                  Row(
                    children: [
                      CustomText(text: distance,fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.grey_1),
                      const SizedBox(width: 3,),
                      const CustomText(text: "KM",fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.grey_1),

                    ],
                  ),
                ],
              ),   Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: "Pricing", fontWeight: FontWeight.w300, fontSize: 12, textColor: MyColors.grey_3),
                  CustomText(text: "$price/hr", fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.grey_1)

                ],
              ), CustomButton(buttonText: "Book Now", onTap: onTap, btnWidth: 60, buttonHeight: 40,btnColor: MyColors.primary6,buttonTextColor: MyColors.primary1,)
            ],),
        ),
        SizedBox(height: 6,),

      ],
    ),
    );
  }
}
