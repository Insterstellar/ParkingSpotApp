import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:parking/util/dashedlibe_verticle_painter.dart';
import 'package:parking/widgets/custom_text.dart';

import '../../misc/mycolors/mycolors.dart';

class ParkingDesignWidget extends StatelessWidget {
  final VoidCallback onTap;
  final bool isAvailable;
  final bool? notAvailable;
  final String? text;

  ParkingDesignWidget(
      {super.key,
      required this.onTap,
      required this.isAvailable,
      this.notAvailable = false,
      this.text});

  Random random = Random();

  List<String> cars = ["greencar.png", "whitecar.png", "redcar.png"];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: isAvailable
          ? RotationTransition(
              turns: new AlwaysStoppedAnimation(23 / 360),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: getScreenWidth(context) * 0.4,
                    height: 1, // Height of the dashed line
                    child: CustomPaint(
                      painter: DashedLineHorizontalPainter(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25.0),
                    child: CustomText(
                      text: text!,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      textColor: MyColors.grey_40,
                    ),
                  ),
                  Container(
                    width: getScreenWidth(context) * 0.4,
                    // height: 1, // Height of the dashed line
                    child: CustomPaint(
                      painter: DashedLineHorizontalPainter(),
                    ),
                  ),
                ],
              ),
            )
          : SizedBox(
              //height: 60,
              //width: 60,
              //color: isAvailable ? MyColors.grey_1 :MyColors.primary1,
              child: RotationTransition(
                turns: new AlwaysStoppedAnimation(23 / 360),
                child: Column(
                  children: [
                    Container(
                      width: getScreenWidth(context) * 0.4,
                      height: 1, // Height of the dashed line
                      child: CustomPaint(
                        painter: DashedLineHorizontalPainter(),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Image.asset(
                            "assets/images/${cars[random.nextInt(3)]}",
                            fit: BoxFit.none,
                            scale: 13,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: getScreenWidth(context) * 0.4,
                      height: 1, // Height of the dashed line
                      child: CustomPaint(
                        painter: DashedLineHorizontalPainter(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
