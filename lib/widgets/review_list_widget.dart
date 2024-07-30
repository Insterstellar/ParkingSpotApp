import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parking/misc/mycolors/mycolors.dart';
import 'package:parking/widgets/custom_text.dart';

class ReviewListWidget extends StatelessWidget {
 final String usersnames;
  const ReviewListWidget({super.key, required this.usersnames});

  @override
  Widget build(BuildContext context) {


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset("assets/images/carpark.jpeg",height:50, width:50,fit: BoxFit.cover),

            ),
            SizedBox(width: 10,),
             Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(text: usersnames, fontWeight: FontWeight.w500, fontSize: 15, textColor: MyColors.grey_10),
                      Spacer(),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber,),
                          Icon(Icons.star, color: Colors.amber,),
                          Icon(Icons.star, color: Colors.amber,),
                        ],
                      ),

                      //CustomText(text: " *****", fontWeight: FontWeight.w500, fontSize: 30, textColor: MyColors.primary5),

                    ],
                  ),
                  CustomText(text: "The Smart Parking app is a game-changer. It saves time, reduces stress, and prevents parking tickets with real-time spot availability and smart notifications. Highly convenient and efficient for frequent drivers.", fontWeight: FontWeight.w300, fontSize: 13, textColor: MyColors.grey_10),

                ],
              ),
            ),

          ],
        ),



        SizedBox(height: 20,),
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width,
          color: MyColors.grey_80,
        )
      ],
    );
  }
}
