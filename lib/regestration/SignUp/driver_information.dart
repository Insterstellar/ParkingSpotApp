import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking/widgets/vehicle_info.dart';

import '../../misc/mycolors/mycolors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/text_field_widget.dart';

class DriverInformation extends StatefulWidget {
  const DriverInformation({super.key});

  @override
  State<DriverInformation> createState() => _DriverInformationState();
}

class _DriverInformationState extends State<DriverInformation> {
  TextEditingController fullNameTextEditController = TextEditingController();
  TextEditingController phoneNumberTextEditController = TextEditingController();
  TextEditingController idCardNumberTextEditController= TextEditingController();
  TextEditingController idCardPdfTextEditController = TextEditingController();
  //TextEditingController steveneditcontroplløer = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: MyColors.grey_90,
                        borderRadius: BorderRadius.circular(50),

                      ),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(13),
                          child: Icon(Icons.arrow_back, color: MyColors.grey_20),
                        ),
                      )),
                 // CustomText(text: "Payment", fontWeight: FontWeight.w400, fontSize: 18, textColor: MyColors.grey_10),
                  SizedBox(width: 10,)

                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Center(
                      child:  Column(
                        children: [
                          CustomText(text: "Driver Information", fontWeight: FontWeight.w700, fontSize: 25, textColor: MyColors.grey_20),
                          SizedBox(height: 8,),
                          CustomText(text: "Please set up driver information for \nsecurity purposes", fontWeight: FontWeight.w300, fontSize: 14, textColor: MyColors.grey_20, softWrap: true, textAlign: TextAlign.center,),
                          SizedBox(height: 20,),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child:
                            Image.asset("assets/images/avataricon.png",fit: BoxFit.cover,height: 100, width: 100,),
                
                
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextFieldWidget(textEditingController: fullNameTextEditController,
                      title: "Full Name",noSuffixIcon: true,isPassword: false, prefixIcon: Icon(Icons.person, size: 20,),validateInput: (value){
                        if(value == null || value.isEmpty){
                          return "enter your Names";
                        }
                        return null;
                
                      },),
                    SizedBox(height: 15,),
                    TextFieldWidget(textEditingController: phoneNumberTextEditController,
                      title: "Phone Number",noSuffixIcon: true,isPassword: false, prefixIcon: Icon(Icons.phone, size: 20,),validateInput: (value){
                        if(value == null || value.isEmpty){
                          return "enter your Number";
                        }
                        return null;
                
                      },),
                    SizedBox(height: 15,),
                    TextFieldWidget(textEditingController: fullNameTextEditController,
                      title: "National Id Card Number",noSuffixIcon: true,isPassword: false, prefixIcon: Icon(Icons.confirmation_num_rounded, size: 20,),validateInput: (value){
                        if(value == null || value.isEmpty){
                          return "enter your Id";
                        }
                        return null;
                
                      },),
                    SizedBox(height: 15,),
                    TextFieldWidget(textEditingController: fullNameTextEditController,
                      title: "National Id Card PDF",noSuffixIcon: true,isPassword: false, prefixIcon: Icon(Icons.picture_as_pdf, size: 20,),validateInput: (value){
                        if(value == null || value.isEmpty){
                          return "enter your Names";
                        }
                        return null;
                
                      },),
                    SizedBox(height: 15,),
                    TextFieldWidget(textEditingController: fullNameTextEditController,
                      title: "STEVEN",noSuffixIcon: true,isPassword: false, prefixIcon: Icon(Icons.picture_as_pdf, size: 20,),validateInput: (value){
                        if(value == null || value.isEmpty){
                          return "enter your Names";
                        }
                        return null;

                      },),
                    CustomButton(buttonText: "Next", onTap:(){
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>VehicleInformation()));
                      }
                
                
                
                
                    }, btnColor: MyColors.primary6,buttonTextColor: MyColors.primary1,),
                  ],
                ),
              )

            ],
          ),
        ),
      ) ,
    );
  }
}
