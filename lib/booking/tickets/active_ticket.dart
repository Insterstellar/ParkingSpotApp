import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:parking/models/SpotAvailable.dart';
import 'package:parking/models/parking_model.dart';
import 'package:parking/models/user_parking.dart';
import 'package:parking/show_directions.dart';
import 'package:parking/util/coordinates_to_Address.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../misc/mycolors/mycolors.dart';
import '../../provider/current_position.dart';
import '../../provider/show_directions_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';




class ActiveTicket extends StatefulWidget {
  final UserParking userParking;
  final bool? accessDirection;
  const ActiveTicket({super.key, required this.userParking,  this.accessDirection,  });

  @override
  State<ActiveTicket> createState() => _ActiveTicketState();
}

class _ActiveTicketState extends State<ActiveTicket> {

  @override
  void initState() {
    // TODO: implement initState



    super.initState();
    convertCoordinates();
    toggleGetDirectionButtons();
   // context.read<ShowDirectionsProvider>().getUserDetailsProvider(widget.userParking!);
  }
  String? location;
  UserParking? userParking;
  SpotAvailable? spotAvailable;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  Parking? parking;
  String? startDate;
  bool accessDirection =true;
  //String? coordinates;

  Future<void> convertCoordinates() async {
    userParking = widget.userParking;
    spotAvailable = userParking?.bookedSpot;
    startDate= "${spotAvailable?.startTime?.year}-${spotAvailable?.startTime?.month}-${spotAvailable?.startTime?.day}";

    startTime = TimeOfDay(
        hour: spotAvailable!.startTime!.hour,
        minute: spotAvailable!.startTime!.minute);

    endTime = TimeOfDay(
        hour: spotAvailable!.endTime!.hour,
        minute: spotAvailable!.endTime!.minute);
    parking = spotAvailable?.parking;


    if(parking?.location is String){
      location=parking?.location;}
    else{
      String? coordinates = parking?.location;
      if (coordinates!.isNotEmpty) {
        AddressConverter addressConverter = AddressConverter();
        setState(() async {
          location = await addressConverter.coordinatesToAddres(coordinates!);
        });

        //print("here is the parking of al+++l times now"+location.toString());
      }
    }




  }

  void toggleGetDirectionButtons(){
    bool? direction =widget.accessDirection;
    setState(() {
      if(direction!=null){
        accessDirection =widget.accessDirection!;

      }else{
        accessDirection=true;
      }


    });

  }

  @override
  Widget build(BuildContext context) {




    return Scaffold(
      backgroundColor: MyColors.primary1,
      appBar: AppBar(
        backgroundColor: MyColors.primary1,
        title: const CustomText(
            text: "Parking Ticket",
            fontWeight: FontWeight.w600,
            fontSize: 16,
            textColor: MyColors.grey_20),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: MyColors.grey_20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: MyColors.primarylight,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    CustomText(
                        text: "Parking Details",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        textColor: MyColors.grey_20),
                    SizedBox(
                      height: 20,
                    ),
                    QrImageView(
                      data: userParking!.username.toString(),
                      version: QrVersions.auto,
                      backgroundColor: MyColors.primary6,
                      foregroundColor: MyColors.primary1,
                      size: 200.0,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                                text: "Name",
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                textColor: MyColors.grey_20),
                            CustomText(
                                text: userParking?.username ?? "",
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                textColor: MyColors.grey_20),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomText(
                                text: "Parking Location",
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                textColor: MyColors.grey_20),
                            CustomText(
                                text: location ?? "",
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                textColor: MyColors.grey_20),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 1,
                      color: MyColors.grey_60,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                                text: "Duration",
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                textColor: MyColors.grey_20),
                            CustomText(
                                text: spotAvailable!.duration.toString(),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                textColor: MyColors.grey_20),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomText(
                                text: "Date",
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                textColor: MyColors.grey_20),
                            CustomText(
                                text:  startDate ?? "",
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                textColor: MyColors.grey_20),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 1,
                      color: MyColors.grey_60,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        CustomText(
                            text: "Hours",
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            textColor: MyColors.grey_20),
                        CustomText(
                            text:
                            "${startTime?.format(context)} - ${endTime?.format(context)}",
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            textColor: MyColors.grey_20),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            accessDirection?
            CustomButton(
              buttonText: "Get direction",
              onTap: () async {

                //AddressConverter addressConvert = AddressConverter();
               // String? locationCoordinates = await addressConvert.addressToCoordinatess(location);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowDirections(userParking: userParking )));
              //  print("this is the actual time please-------------" +userParking!.username.toString());
                context.read<ShowDirectionProvider>().getUserDetailsProvider(userParking!);

                //String? user =context.watch<ShowDirectionProvider>().userParking.username;

             //   print("here is the na,e now ----------------------_>>>>"+ user!);

                //print("this is the actual endtime please---------" + endtime);
              },
              buttonTextColor: MyColors.primary1,
              btnColor: MyColors.primary6,
            ) :Container()
          ],
        ),
      ),
    );
  }
}
