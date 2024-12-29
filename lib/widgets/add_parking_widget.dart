import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../misc/mycolors/mycolors.dart';
import 'custom_text.dart';

class AddParkingWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final Color color;
  const AddParkingWidget({super.key, required this.text, required this.icon, required this.onTap, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 120,
          width: 90,
          decoration: BoxDecoration(
            color: MyColors.primarylight,
            borderRadius: BorderRadius.circular(8)

          ),

          child:  Padding(
            padding: EdgeInsets.all(13.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon,color: color, size: 25, ),

                CustomText(
                    text: text,
                    fontWeight: FontWeight.w300,
                    fontSize: 11,
                    textColor: MyColors.grey_20),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
