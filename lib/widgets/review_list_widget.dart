import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parking/misc/mycolors/mycolors.dart';
import 'package:parking/widgets/custom_text.dart';

class ReviewListWidget extends StatelessWidget {
 final String usersnames;
 final String? profileImage;
 final int stars;
 final String review;

  const ReviewListWidget({super.key, required this.usersnames,  required this.review, required this.stars, required this.profileImage});

  @override
  Widget build(BuildContext context) {
   //String? profileImage="";


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: profileImage == null ?
              Image.asset("assets/images/avataricon.png",fit: BoxFit.cover,height: 50, width: 50,):
              Image.network(
                profileImage??'',

                fit: BoxFit.cover,height: 50, width: 50,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/images/avataricon.png",
                    fit: BoxFit.cover, height: 50, width: 50,
                  );
                },
              ),

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
                          for( int a =0; a< stars; a++)
                            Icon(Icons.star, color: Colors.amber,),




                        ],
                      ),

                      //CustomText(text: " *****", fontWeight: FontWeight.w500, fontSize: 30, textColor: MyColors.primary5),

                    ],
                  ),
                  CustomText(text: review.toString(), fontWeight: FontWeight.w300, fontSize: 13, textColor: MyColors.grey_10),

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
