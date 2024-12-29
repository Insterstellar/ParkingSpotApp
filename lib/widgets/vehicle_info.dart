import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parking/widgets/custom_button.dart';
import 'package:parking/widgets/text_field_widget.dart';

import '../misc/mycolors/mycolors.dart';
import 'custom_text.dart';

class VehicleInformation extends StatefulWidget {
  const VehicleInformation({super.key});

  @override
  State<VehicleInformation> createState() => _VehicleInformationState();
}

class _VehicleInformationState extends State<VehicleInformation> {
  TextEditingController vehicleCompanyTextController = TextEditingController();
  TextEditingController vehicleModelTextController = TextEditingController();
  TextEditingController registrationNumberTextController= TextEditingController();



@override
  void dispose() {
    // TODO: implement dispose
  vehicleCompanyTextController.dispose();
    super.dispose();


  }

  double vehicleColorHeight =35;
  double vehicleColorWidth = 35;


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                height: MediaQuery.of(context).size.height-100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: MyColors.primarylight0),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: MyColors.grey_20,
                                ),
                              )),
                        ),

                      ],
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: const Column(
                        children: [
                          CustomText(text: "Vehicle Information", fontWeight: FontWeight.w700, fontSize: 25, textColor: MyColors.grey_20),
                          SizedBox(height: 8,),
                          CustomText(text: "Please set up your car information \nfor security infromation", fontWeight: FontWeight.w300, fontSize: 14, textColor: MyColors.grey_20, softWrap: true, textAlign: TextAlign.center,),
                        ],
                      ),
                    ),
                    SizedBox(height: 18,),
                    TextFieldWidget(textEditingController: vehicleCompanyTextController,
                      title: "Vehicle Company",noSuffixIcon: true,isPassword: false, prefixIcon: Icon(Icons.location_city_outlined, size: 20,),validateInput: (value){
                      if(value == null || value.isEmpty){
                        return "enter email";
                      }
                      return null;

                      },),
                    TextFieldWidget(textEditingController: vehicleModelTextController ,title: "Vehicle Model", noSuffixIcon: false, isPassword: false, prefixIcon:  Icon(Icons.local_taxi_sharp, size: 20,),validateInput: (model){
                      if(model == null || model.isEmpty){
                        return "enter car model";
                      }
                    },),
                    TextFieldWidget(textEditingController: registrationNumberTextController ,title: "Registration Number", noSuffixIcon: true, isPassword: false, prefixIcon:  Icon(Icons.note_alt_sharp, size: 20,),validateInput: (numberplate){
                      if(numberplate == null || numberplate.isEmpty){
                        return "enter numberplate";
                      }
                    },),
                    Row(
                      children: [
                        CustomText(text: "Vehicle Color", fontWeight: FontWeight.w700, fontSize: 14, textColor: MyColors.grey_20),
                        SizedBox(width: 10,),
                        Container(
                          height: vehicleColorHeight,
                          width: vehicleColorWidth,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.red[500],
                              boxShadow:[ BoxShadow(
                                color: Colors.red.withOpacity(0.5),
                                blurRadius: 7,
                                offset: Offset(0, 5),
                              )]

                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          height: vehicleColorHeight,
                          width: vehicleColorWidth,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green[500],
                              boxShadow:[ BoxShadow(
                                color: Colors.green.withOpacity(0.5),
                                blurRadius: 7,
                                offset: Offset(0, 5),
                              )]
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          height: vehicleColorHeight,
                          width: vehicleColorWidth,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                              boxShadow:[ BoxShadow(
                                color: MyColors.grey_60,
                                blurRadius: 7,
                                offset: Offset(0, 5),
                              )]
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          height: vehicleColorHeight,
                          width: vehicleColorWidth,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blue,
                              boxShadow:[ BoxShadow(
                                color: Colors.blue.withOpacity(0.5),
                                blurRadius: 7,
                                offset: Offset(0, 5),
                              )]
                          ),
                        ),

                      ],

                    ),
                    SizedBox(height: 20,),
                    CustomButton(buttonText: "Next", onTap:(){
                      if (_formKey.currentState!.validate()) {
                      }




                    }, btnColor: MyColors.primary6,buttonTextColor: MyColors.primary1,)



                  ],
                ),
              ),
            ),
          ),
        ),

      ),
    );
  }
}
