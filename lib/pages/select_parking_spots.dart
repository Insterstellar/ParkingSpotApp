
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:parking/booking/status_check.dart';
import 'package:parking/misc/mycolors/mycolors.dart';
import 'package:parking/models/SpotAvailable.dart';
import 'package:parking/models/parking_model.dart';
import 'package:parking/repo/controller/parking_controller.dart';
import 'package:parking/repo/services/ParkingServices.dart';
import 'package:parking/widgets/custom_button.dart';
import 'package:parking/widgets/custom_text.dart';
import 'package:parking/widgets/parkingdesignwidget/parking_design_widget.dart';

import '../booking/booking_confirmation.dart';
import '../booking/date_and_time_page.dart';
import '../booking/parkingstate/extended_parking_time.dart';
import '../booking/parkingstate/parking_time_status.dart';

class SelectParkingSPotsPage extends StatefulWidget {
  final Parking? parkingSpot;
  const SelectParkingSPotsPage({super.key,  this.parkingSpot});

  @override
  State<SelectParkingSPotsPage> createState() => _SelectParkingSPotsPageState();
}

class _SelectParkingSPotsPageState extends State<SelectParkingSPotsPage> {
  bool accessible =true;

  void isVailable (){
    setState(() {
      accessible=true;
    });
  }
  String? avaibleText;
  void available(){
   avaibleText="Available";
  }

  Parking? parkingSpot;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     parkingSpot=widget.parkingSpot;
  }


  var parkingController=ParkingController(ParkingServices());
  int? parkingSpotId;


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: MyColors.primary1,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: MyColors.grey_80
                      ),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(Icons.arrow_back,color: MyColors.grey_10,),
                        )),
                  ),
                  SizedBox(width: 20,),
                  CustomText(text: "Choose Space", fontWeight: FontWeight.w400, fontSize: 23, textColor: MyColors.grey_20),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.all(8.0),
              child: CustomText(text: parkingSpot?.name??"", fontWeight: FontWeight.w400, fontSize: 25, textColor: MyColors.grey_10),
            ),
            Padding(
              padding:  EdgeInsets.all(6.0),
              child: CustomText(text: "Number of Parking Spots : "+parkingSpot!.numberOfSpots.toString() ??"", fontWeight: FontWeight.w400, fontSize: 16, textColor: MyColors.grey_10),
            ),
            SizedBox(height: 25,),
            Expanded(
              child: GridView.builder(
                itemCount: parkingSpot?.spotAvailable!.length ?? 0,
                  padding: EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10,),
                  itemBuilder: (context, index){


                    var spotStatus =parkingSpot?.spotAvailable?[index].isOccupied ?? false;


                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ParkingDesignWidget(onTap: () {



                       setState(() {
                         if(parkingSpot?.spotAvailable?[index].isOccupied== true){
                          //updateSpotController.updateParkingSpot(parkingSpot?.spotAvailable?[index].id, false);
                       parkingSpot!.spotAvailable?[index].isOccupied=false;

                       parkingSpotId=parkingSpot?.spotAvailable?[index].id;



                         }
                         else {
                           showDialog(
                               context: context,
                               builder: (context)=>AlertDialog(
                                 backgroundColor: MyColors.primary1,
                                 actions: [
                                   TextButton(onPressed: (){
                                     Navigator.of(context).pop();
                                   }, child: Text("Close",style: TextStyle(color: MyColors.primary6)))

                                 ],//title: Text("occupied!"),
                                 contentPadding: EdgeInsets.all(16),
                                 content: const Text("Spot not available!", style: TextStyle(color: MyColors.primary6),),
                               )) ;
                           print("occupied!:$index");
                           print("number of------ spots are "+parkingSpot!.spotAvailable![index].id.toString());
                          // print("number of------ show boolen "+parkingSpot!.spotAvailable![index].isOccupied);
                          // print("number of------ spots are "+parkingSpot!.spotAvailable![index].duration.toString());


                         }

                       });

                      }, isAvailable:spotStatus  , text: "Available" ),
                    )      ;

                  }),
            ) ,
        

            Padding(
              padding:  EdgeInsets.all(16.0),
              child: CustomButton(buttonText: "Continue", onTap: (){

                 if(parkingSpotId!=null){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                   return SetTimePage (parking: parkingSpot ,parkingSpotId: parkingSpotId ,);
                  }));
                }else{

                        final snack= SnackBar(
                             content: CustomText(text: "Please select a spot !", fontWeight: FontWeight.w600, fontSize: 12, textColor: MyColors.grey_20,),
                             backgroundColor: MyColors.grey_100_);

                        ScaffoldMessenger.of(context).showSnackBar(snack);



                }






              },
                btnColor: MyColors.primary6,
                buttonTextColor: MyColors.primary1,),
            )
          ],
        ),
      )
    );
  }
}
