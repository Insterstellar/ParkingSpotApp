import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parking/misc/mycolors/mycolors.dart';

import '../widgets/add_parking_widget.dart';
import '../widgets/custom_text.dart';
import '../widgets/parkingdesignwidget/parking_container_widget.dart';
import 'add_parking.dart';

class ParkingDashboard extends StatefulWidget {
  const ParkingDashboard({super.key});

  @override
  State<ParkingDashboard> createState() => _ParkingDashboardState();
}

class _ParkingDashboardState extends State<ParkingDashboard> with TickerProviderStateMixin {
  String ? img;
  @override
  Widget build(BuildContext context) {
    TabController tabController=TabController(length: 2, vsync: this)  ;
    return Scaffold(
      backgroundColor: MyColors.primary1,
      appBar: AppBar(
        backgroundColor: MyColors.primary1,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios, color: MyColors.grey_20,)),
        title: CustomText(text: "Add Parking", fontWeight: FontWeight.w600,fontSize: 15,textColor: MyColors.grey_20,),
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0,right: 16.0,top: 16.0,bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          "assets/images/avataricon.png",
                          fit: BoxFit.cover,
                          height: 39,
                          width: 39,
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
                CustomText(text: "Parking \nDashBoard", fontWeight: FontWeight.bold, fontSize: 25, textColor: MyColors.yellow_100_)
              ],
            ),
          ),
          Container(
            color: MyColors.primarylight,
            height: 1,
          ),
          const Padding(
            padding: EdgeInsets.all(14.0),
            child: Row(
              children: [
                Row(
                  children: [
                    Icon(Icons.circle_outlined, color: MyColors.yellow_100_,),
                    SizedBox(width: 10,),
                    CustomText(
                        text: "10 spots",
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        textColor: MyColors.grey_20)
                  ],
                ),
                SizedBox(width: 15,),
                Row(
                  children: [
                    Icon(Icons.local_parking, color: MyColors.yellow_100_,),
                    SizedBox(width: 10,),
                    CustomText(
                        text: "1 place",
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        textColor: MyColors.grey_20)
                  ],
                ),

              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16,right: 16,bottom: 16),
            child: Row(
              children: [
                Icon(Icons.file_open_sharp, color: MyColors.yellow_100_,),
                SizedBox(width: 10,),
                Expanded(
                  child: CustomText(
                      text: "This is an admin dashboard for managing parking, where you can add and view your parking spaces.",
                      fontWeight: FontWeight.w300,
                      fontSize: 11,
                      textColor: MyColors.grey_20),
                ),
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            child: TabBar(
                controller: tabController,
                labelColor: MyColors.primary6,
                //isScrollable: true,
                // labelStyle: TextStyle(color: Colors.red),
                indicatorColor: MyColors.primary6,
                dividerColor: MyColors.grey_95,
                //unselectedLabelColor: MyColors.grey_20,
                // indicator: TabBarIndicatorSize.label,

                tabs: const [
                  Tab(text: "Manage Parking",),
                  Tab(text: "Owned",),

                ]),


          ),

          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 16),
              width: MediaQuery.of(context).size.width,
            
            
              child: TabBarView(
                controller: tabController,
                  children: [
                    Wrap(
                      spacing: 8.0, // gap between adjacent chips
                      runSpacing: 4.0, // gap between lines
                      children: <Widget>[
                        AddParkingWidget(text: "Add your \nown Parking",onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return AddParking();
                          }));
                        },icon: Icons.add_circle,color: MyColors.primary6,),
                        AddParkingWidget(text: "Suggestions",onTap: (){},icon: Icons.settings_suggest,color: Colors.amber,),
                        SizedBox(width: 55,),
                        AddParkingWidget(text: "Statistics",onTap: (){},icon: Icons.calculate_outlined,color: MyColors.yellow_1_,),
              
                      ],
                    ),
                   /* */
                    ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return ParkingContainerWidget(imageUrl: img ?? '',);
                      }
                    ),
              
              
                  ]),
            ),
          )

        ],
      )),
    );
  }
}
