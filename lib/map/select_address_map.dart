import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking/misc/mycolors/mycolors.dart';
import 'package:parking/provider/current_position.dart';
import 'package:parking/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class SelectMapAddress extends StatefulWidget {
  final StreamSink<LatLng> sinkParkingCoordinates;
  const SelectMapAddress({super.key, required this.sinkParkingCoordinates});

  @override
  State<SelectMapAddress> createState() => _SelectMapAddressState();
}



class _SelectMapAddressState extends State<SelectMapAddress> {
  GoogleMapController? mapController;

  LatLng? parkingCoordinates;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
   context.read<CurrentPosition>().userCurrentPosition(context);

  }


  static const CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(60.391249711811405, 5.3255167191915245),
    zoom: 15,

  );

  void _goToCurrentPosition (Position? _currentPosition){
    if(_currentPosition !=null){
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
        zoom: 14,
      );
      mapController?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    }


  }


  @override
  void dispose() {
    // TODO: implement dispose
    mapController?.dispose();
    super.dispose();
  }







  @override
  Widget build(BuildContext context) {
   final currentPos = context.watch<CurrentPosition>().currentPosition;



    return Scaffold(
      backgroundColor: MyColors.primary1,
      appBar: AppBar(
        backgroundColor: MyColors.primary1,
        foregroundColor: MyColors.grey_40,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);

        }, icon: Icon(Icons.arrow_back_ios)) ,
        actions: [
          parkingCoordinates != null ?IconButton(onPressed: (){
            widget.sinkParkingCoordinates.add(parkingCoordinates!);
            Navigator.pop(context);

          }, icon: Icon(Icons.check, color: MyColors.primary6,)) : Container() ,
        ],

        title: CustomText(text: "Select Address", fontWeight: FontWeight.w400, fontSize: 16, textColor: MyColors.grey_20),
      ),
      body: Stack(

        children: [
          GoogleMap(
              initialCameraPosition: initialCameraPosition ,
          onMapCreated: (GoogleMapController controller){
                mapController =controller;
                _goToCurrentPosition(currentPos);

          },
            markers:{
          Marker(markerId: MarkerId("position"), position: LatLng(currentPos!.latitude,currentPos!.longitude),
            draggable: true,
            onDragEnd: ((newPosition){
             /// to handle error
              setState(() {
                parkingCoordinates =newPosition;

              });
            })

          )
            },

             // marker=Marker(markerId: const MarkerId("position"), position: LatLng(_currentPosition!.latitude, _currentPosition!.longitude), draggable: true)


          )
        ],
      ),
    );
  }
}
