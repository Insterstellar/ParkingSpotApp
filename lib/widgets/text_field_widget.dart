import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../misc/mycolors/mycolors.dart';
import '../misc/validator.dart';
import 'custom_text.dart';

class TextFieldWidget extends StatelessWidget {
   final TextEditingController textEditingController;
   final String? title;
   final String? hintText;
   final bool noSuffixIcon;
   final bool isPassword;
   final Icon prefixIcon;
   final Validator validateInput;
   final bool? titleNeeded ;


   TextFieldWidget({super.key, required this.textEditingController,  this.title, required this.noSuffixIcon, required this.isPassword, required this.prefixIcon, required this.validateInput, this.titleNeeded, this.hintText, });

  final List<String> carModel = <String>[
    "Model S"        ,
    "Model 3"        ,
    "Model X"        ,
    "Model Y"         ,
    "ID.3"            ,
    "ID.4"            ,
    "Golf"            ,
    "Passat"          ,
    "Tiguan"          ,
    "Leaf"           ,
    "Qashqai"        ,
    "X-Trail"        ,
    "i3"             ,
    "iX"             ,
    "X3"             ,
    "X5"             ,
    "3 Series"       ,
    "e-tron"         ,
    "Q4 e-tron"      ,
    "A4"             ,
    "Q5"             ,
    "Kona Electric"  ,
    "Ioniq Electric" ,
    "Ioniq 5"        ,
    "Tucson"         ,
    "RAV4"            ,
    "Yaris"           ,
    "Corolla"         ,
    "Prius"           ,
    "XC40"            ,
    "XC60"            ,
    "V90"             ,
    "C40 Recharge"    ,
    "EV6"             ,
    "e-Niro"          ,
    "e-Soul"          ,
    "Sportage"        ,
    "EQC"             ,
    "EQA"             ,
    "EQS"             ,
    "GLC"             ,
  ];




  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleNeeded==true ? CustomText(
            text: title ?? "",
            fontWeight: FontWeight.w600,
            fontSize: 15,
            textColor: MyColors.grey_20) : Container(),
        const SizedBox(
          height: 15,
        ),
        TextFormField(
          obscureText: isPassword,
          validator: validateInput,



          cursorColor: MyColors.grey_40,
          style: TextStyle(color: MyColors.grey_20, fontSize: 14),
          decoration: InputDecoration(



            prefixIcon: Padding(
              padding: EdgeInsetsDirectional.only(start: 10.0),
              child: prefixIcon,
            ),
           suffixIcon: noSuffixIcon ? null : Padding(
              padding: EdgeInsetsDirectional.only(end: 10.0),
              child: PopupMenuButton<String>(
                onSelected: (String value){
                  textEditingController.text=value;
                  print("This is the controllee that was picked   : "+ value.toString());
                },
                // Offset to ensure the dropdown appears correctly relative to the icon
                offset: Offset(0, 40),
                // The icon that triggers the dropdown
                icon: Icon(Icons.keyboard_arrow_down, size: 20),
                // Define the options in the dropdown
                itemBuilder: (BuildContext context) {
                  return carModel
                      .map((String choice) {


                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            )  ,
            prefixIconColor: MyColors.grey_40,
            suffixIconColor: MyColors.grey_40,
            contentPadding: EdgeInsets.symmetric(vertical: 17.8),

            //labelText: 'Search',
            hintText: hintText ?? "Type here",
            hintStyle: TextStyle(color: MyColors.grey_60),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(35)),
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.5),
                width: 1.0,
                // width: 2.0, // Border width
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(35)),
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.5),
                width: 1.0,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(35)),
              borderSide: BorderSide(
                color: Colors.green.withOpacity(0.5),
                width: 1.0,
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red.withOpacity(0.5),
                width: 1.0,
              ),
            ),
          ),
          controller: textEditingController,
        ),



      ],
    );
  }
}
