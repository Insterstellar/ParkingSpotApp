import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parking/regestration/SignUp/driver_information.dart';

import '../../misc/mycolors/mycolors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/text_field_widget.dart';

class RegisterNow extends StatefulWidget {
  const RegisterNow({super.key});

  @override
  State<RegisterNow> createState() => _RegisterNowState();
}

class _RegisterNowState extends State<RegisterNow> {

  final _formValidation = GlobalKey<FormState>();
  TextEditingController emailTextEditController = TextEditingController();
  TextEditingController passwordTextEditController = TextEditingController();
  TextEditingController confirmPasswordTextEditController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 16),
          child: ListView(
            children: [
              Center(
                child:  Column(
                  children: [
                    CustomText(text: "SignUp", fontWeight: FontWeight.w700, fontSize: 30, textColor: MyColors.grey_20),
                    SizedBox(height: 8,),
                    CustomText(text: "Please Enter Your Details below to sign \ninto your account ", fontWeight: FontWeight.w300, fontSize: 14, textColor: MyColors.grey_20, softWrap: true, textAlign: TextAlign.center,),
                    SizedBox(height: 20,),

                  ],
                ),
              ),
              Form(
                key: _formValidation,
                child: Column(
                  children: [
                    TextFieldWidget(textEditingController: emailTextEditController, titleNeeded: false,hintText: "Email Address",
                      noSuffixIcon: true,isPassword: false, prefixIcon: Icon(Icons.email_outlined, size: 20,),validateInput: (value){
                        if(value == null || value.isEmpty){
                          return "enter your Email";
                        }
                        return null;

                      },),
                    TextFieldWidget(textEditingController: passwordTextEditController, titleNeeded: false,hintText: "Password",
                      noSuffixIcon: true,isPassword: true, prefixIcon: Icon(Icons.password_outlined, size: 20,),validateInput: (value){
                        if(value == null || value.isEmpty){
                          return "enter your password";
                        }
                        return null;

                      },),
                    TextFieldWidget(textEditingController: confirmPasswordTextEditController, titleNeeded: false,hintText: "Password",
                      noSuffixIcon: true,isPassword: true, prefixIcon: Icon(Icons.password_outlined, size: 20,),validateInput: (value){
                        if(value == null || value.isEmpty){
                          return "confirm your password";
                        }
                        return null;

                      },),
                    SizedBox(height: 20,),
                    CustomButton(buttonText: "SignUp", onTap:(){
                      if (_formValidation.currentState!.validate()) {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DriverInformation()));
                      }




                    }, btnColor: MyColors.primary6,buttonTextColor: MyColors.primary1,),
                  ],
                ),
              ),


              SizedBox(height: 25,),
              CustomText(text: "Forgot Password?", fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.grey_20, textAlign: TextAlign.center,),

              SizedBox(height: 25,),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: MyColors.grey_40,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: CustomText(text: "Or Continue With", fontWeight: FontWeight.w400, fontSize: 15, textColor: MyColors.grey_20, textAlign: TextAlign.center,),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: MyColors.grey_40,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(55),
                  color: MyColors.primarylight1,
                  border: Border.all(
                    color: MyColors.grey_60,
                    width: 0.8,
                  ),

                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/google.png",fit: BoxFit.cover, height: 16, width: 16),
                      SizedBox(width: 10,),
                      CustomText(text: " Continue with Google", fontWeight: FontWeight.w500, fontSize: 16, textColor: MyColors.grey_20, textAlign: TextAlign.center,),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 25,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(55),
                  color: MyColors.primarylight1,
                  border: Border.all(
                    color: MyColors.grey_60,
                    width: 0.8,
                  ),

                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/vippsicon.png",fit: BoxFit.cover, height: 50, ),


                    ],
                  ),
                ),
              ),
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: "Already have an account ?", fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.grey_20, textAlign: TextAlign.center,),
                  SizedBox(width: 8,),
                  CustomText(text: "Sign In.", fontWeight: FontWeight.w500, fontSize: 16, textColor: MyColors.primary6, textAlign: TextAlign.center,),

                ],
              )








            ],
          ),
        ),
      ),
    );
  }
}
