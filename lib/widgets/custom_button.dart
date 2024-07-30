
import 'package:flutter/material.dart';
import 'package:parking/misc/mycolors/mycolors.dart';

class CustomButton extends StatelessWidget {
  final String buttonText ;
  final VoidCallback onTap;
  final Color buttonTextColor;
  final double? fontSize;
  final double? buttonHeight;
  final double ? btnWidth;
  final Color btnColor;
   const CustomButton({super.key,
     required this.buttonText,
     required this.onTap,
     this.buttonTextColor =MyColors.grey_1,
     this.fontSize,
     this.buttonHeight,
     this.btnColor=MyColors.primary1,
      this.btnWidth});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
              minimumSize: Size (btnWidth ?? MediaQuery.of(context).size.width,
                  buttonHeight ?? MediaQuery.of(context).size.height *0.06),
        
        backgroundColor: btnColor,
        elevation: 1.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
      ),


        onPressed: onTap,
        child: Center(child: Text(buttonText, style: TextStyle(color: buttonTextColor, fontSize: fontSize),)));
  }
}
