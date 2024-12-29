import 'dart:ui';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parking/misc/mycolors/mycolors.dart';
import 'package:parking/pages/drawerPages/favorites_page.dart';
import 'package:parking/regestration/SignUp/register_now.dart';
import 'package:parking/widgets/custom_button.dart';

import 'custom_text.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key, });


  @override
  Widget build(BuildContext context) {
    return Container(

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children:  [
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
                CustomText(
                    text: "Profile",
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                    textColor: MyColors.grey_20),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
              SizedBox(
              height: 15,
            ),
            Container(
              //   height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        "assets/images/avataricon.png",
                        fit: BoxFit.cover,
                        height: 50,
                        width: 50,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  const CustomText(
                      text: "Mandy Ronald",
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      textColor: MyColors.grey_20),
                  const SizedBox(
                    height: 2,
                  ),
                  const CustomText(
                      text: "+4784848949",
                      fontWeight: FontWeight.w300,
                      fontSize: 11,
                      textColor: MyColors.grey_20),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),

            ListTile(
              contentPadding: EdgeInsets.only(left: 0, right: 0),
              leading: Icon(Icons.wallet, color: MyColors.grey_20, ),
              trailing: Icon(Icons.arrow_forward_ios, color: MyColors.grey_20, size: 12,),
              shape: Border(bottom: BorderSide(width: 1, color: MyColors.grey_80)),
              title:   const CustomText(
                  text: "My Wallet",
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  textColor: MyColors.grey_20),
              onTap: (){



              },
            ),


            ListTile(
           //selected: selectedIndex ==0,
              contentPadding: EdgeInsets.only(left: 0, right: 0),
              leading: Icon(Icons.favorite, color: MyColors.grey_20, ),
              trailing: Icon(Icons.arrow_forward_ios, color: MyColors.grey_20, size: 12,),
              shape: Border(bottom: BorderSide(width: 1, color: MyColors.grey_80)),
              title:   const CustomText(
                  text: "Favorites",
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  textColor: MyColors.grey_20),
              onTap: (){
                Navigator.pushNamed(context,"favorites");

              //  Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 0, right: 0),
              leading: Icon(Icons.help_center, color: MyColors.grey_20, ),
              trailing: Icon(Icons.arrow_forward_ios, color: MyColors.grey_20, size: 12,),
              shape: Border(bottom: BorderSide(width: 1, color: MyColors.grey_80)),
              title:   const CustomText(
                  text: "Help center",
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  textColor: MyColors.grey_20),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 0, right: 0),
              leading: Icon(Icons.privacy_tip, color: MyColors.grey_20, ),
              trailing: Icon(Icons.arrow_forward_ios, color: MyColors.grey_20, size: 12,),
              shape: Border(bottom: BorderSide(width: 1, color: MyColors.grey_80)),
              title:   const CustomText(
                  text: "Privacy policy",
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  textColor: MyColors.grey_20),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.pushNamed(context,"privacyPolicy");
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 0, right: 0),
              leading: Icon(Icons.info, color: MyColors.grey_20, ),
              trailing: Icon(Icons.arrow_forward_ios, color: MyColors.grey_20, size: 12,),
              shape: Border(bottom: BorderSide(width: 1, color: MyColors.grey_80)),
              title:   const CustomText(
                  text: "About",
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  textColor: MyColors.grey_20),
              onTap: () {
                Navigator.pushNamed(context,"About");
                // Update the state of the app.
                // ...
                //Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 0, right: 0),
              leading: Icon(Icons.create, color: MyColors.primary6, ),
              trailing: Icon(Icons.arrow_forward_ios, color: MyColors.primary6_light1, size: 12,),
              shape: Border(bottom: BorderSide(width: 1, color: MyColors.grey_80)),
              title:   const CustomText(
                  text: "Create your own parking spot",
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  textColor: MyColors.primary6),
              onTap: (){
                Navigator.pushNamed(context,"parkingDashboard");
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 0, right: 0),
              leading: Icon(Icons.output, color: Colors.red[500], ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.red[500], size: 12,),
            //  shape: Border(bottom: BorderSide(width: 1, color: MyColors.grey_80)),
              title:   CustomText(
                  text: "Sign out",
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  textColor: Colors.red),
              onTap: () {
                // Update the state of the app.
                // ...
                print("hello am back to flutter guys and good help me be much better at it from now ");
                showModalBottomSheet(
                    context: context,
                   // isDismissible: false,
                    backgroundColor: Colors.transparent,
                  

                    builder: (BuildContext context){
                      return BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.45,
                        
                        
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            color: MyColors.primary1,
                            boxShadow:[ BoxShadow(
                              color: MyColors.grey_60,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            )]
                          ),
                          
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [

                                    Container(

                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                          color: MyColors.primarylight1,
                                        ),
                                        child: IconButton(onPressed: (){
                                          Navigator.pop(context);
                                        }, icon: Icon(Icons.close, color: MyColors.grey_20, size: 18,),  )),
                                  ],
                                ),
                                Icon(Icons.login_sharp, size: 100, color: MyColors.primary6,),
                                const Column(
                                  children: [
                                    CustomText(text: "Logout", fontWeight: FontWeight.bold, fontSize: 28, textColor: MyColors.grey_20),
                                    SizedBox(height: 10,),
                                    CustomText(text: "Are you sure you  want to\n log out ?", fontWeight: FontWeight.w400, fontSize: 14, textColor: MyColors.grey_20, textAlign: TextAlign.center, softWrap: true,),
                                  ],
                                ),
                                SizedBox(height: 15,),
                                CustomButton(buttonText: "Logout", onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterNow()));

                                }, buttonTextColor: MyColors.primary1, btnColor: MyColors.primary6,)
                              ],
                            ),
                          ),
                        ),
                      );
                });
                //Navigator.pop(context);
              },
            ),





// ,lklllkl



          ],
        ),
      ),
    );
  }
}
