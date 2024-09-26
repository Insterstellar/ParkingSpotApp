import 'dart:async';
import 'dart:developer';


import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:parking/booking/my_bookings.dart';
import 'package:parking/data/keys.dart';
import 'package:parking/misc/mycolors/mycolors.dart';
import 'package:parking/models/parking_model.dart';
import 'package:parking/pages/parking_details.dart';
import 'package:parking/permissions/location_permission.dart';
import 'package:parking/repo/controller/parking_controller.dart';
import 'package:parking/repo/services/ParkingServices.dart';
import 'package:parking/util/coordinates_to_Address.dart';
import 'package:parking/util/image_converter.dart';
import 'package:parking/widgets/custom_button.dart';
import 'package:parking/widgets/custom_text.dart';
import 'package:parking/widgets/review_list_widget.dart';
import 'package:flutter/services.dart' show rootBundle;


import '../booking/date_and_time_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>  {
  @override
  void initState() {
    super.initState();

    setState(() {
      _initializeMap();
    });

    allParKinSpots();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });

  }
  Uint8List? customMarker;
  Uint8List? customMarkerLocation;
  final Set<Marker> _markers=<Marker>{};
  List<LatLng> listMarker=[
    LatLng(60.39421808459422, 5.317450687411731),
    LatLng(60.38934138582578, 5.321313068338688),
     LatLng(60.387644971556156, 5.325347110640176),
     LatLng(60.39069845361249, 5.33084027462518),
     LatLng(60.38739050179333, 5.334359332803072),
     LatLng(60.39307318614891, 5.322171375211344),
     LatLng(60.39366684222042, 5.322343036585876),
  ];
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  String? _mapStyle;
  GoogleMapController? mapController;
  Position? _currentPosition;
  final Completer<GoogleMapController>? _mapController = Completer();
  List<Parking>parkingSpaces =[];



  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(60.38891729054352, 5.332471057683227),
    zoom: 16.4746,
  );


  Future<void> _initializeMap() async {
    await _getCurrentPosition();
    await loadCustomMarker();

     addMarkers();
  }

  Future<void> allParKinSpots() async{
    var parkingSpotController = ParkingController(ParkingServices());
   var allSpots= await parkingSpotController.getAllParkingSpots();
   setState(() {
     parkingSpaces=allSpots;
   });

  }




  Future<void> _getCurrentPosition( ) async {
    LocationsPermisionClass locationPermissions = LocationsPermisionClass();
    final hasPermission =
    await locationPermissions.HandleLocationPermission(context);

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      //_getAddressFromLatLng(_currentPosition!);
      _navigateToCurrentPosition();
      print("this is the camera position-------------- ${_currentPosition }");
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _navigateToCurrentPosition() async {
    final GoogleMapController? controller = await _mapController?.future;
    if (controller != null && _currentPosition != null) {
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        zoom: 16,
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      await loadCustomImageLocation();
      addLocationMarkers(LatLng(_currentPosition!.latitude, _currentPosition!.longitude) );
      setState(() {


      });
    }
  }




  Future<void> loadCustomMarker() async {
    ImageConverter imageConverter = ImageConverter();
    customMarker = await imageConverter.getBytesFromAsset(
      path: 'assets/images/parkingicon.png',
      width: 69, // minibus temporary customer marker custom marker
    );
    if (customMarker != null) {
      setState(() {});
    } // Trigger a rebuild to display the custom marker
  }

  void addMarkers() {
    var cordinates;
    String? location;
    for (int a =0; a<parkingSpaces.length; a++)   {
      var locationCordinates = parkingSpaces[a].location;
      if(locationCordinates !=null){
         cordinates = locationCordinates.split(',');
        print("the cordinates are ------"+ cordinates.toString());

      }

        _markers.add(Marker(
          markerId: MarkerId(parkingSpaces[a].id.toString()),
          position: LatLng(double.parse(cordinates[0]),double.parse(cordinates[1])),

          icon: customMarker != null
              ? BitmapDescriptor.fromBytes(customMarker!)
              : BitmapDescriptor.defaultMarker,
          onTap: () async{

            String? parkingCordinates = locationCordinates;


              AddressConverter addressConverter = AddressConverter();
              location= await addressConverter.coordinatesToAddres(parkingCordinates!);




            await showBottomSheet(
              backgroundColor: MyColors.primarylight,
                context: context, builder: (BuildContextcontext){
                //code to be refactored into a separate widget
                  return Container(
                   // height: 200,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: parkingSpaces[a].gallery![0].imageUrl.toString().isEmpty?Image.asset("assets/images/smallcar.png", height: 50,width: 50,fit: BoxFit.cover,) :
                                Image.network(
                                  parkingSpaces[a].gallery![0].imageUrl.toString(),
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      "assets/images/smallcar.png",
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: 10,),
                               Expanded(
                                 child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(text: parkingSpaces[a].name.toString(), fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_10),
                                    CustomText(text: location ?? "", fontWeight: FontWeight.w400, fontSize: 16, textColor: MyColors.grey_20),
                                    CustomText(text: "${parkingSpaces[a].price}kr/hr", fontWeight: FontWeight.w300, fontSize: 16, textColor: MyColors.grey_20),
                                    CustomText(text: parkingSpaces[a].distance.toString(), fontWeight: FontWeight.w200, fontSize: 16, textColor: MyColors.grey_20),
                                 
                                 
                                 
                                  ],
                                                               ),
                               ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [

                              Expanded(child: CustomButton(buttonText: "Cancel", onTap: (){
                                Navigator.pop(context);
                              }, btnColor: MyColors.grey_20,buttonTextColor: MyColors.primary1,)),
                              SizedBox(width: 10,),
                              Expanded(child: CustomButton(buttonText: "Book Now", onTap: (){
                           String? convertedLocation= location;
                            parkingSpaces[a].location=convertedLocation;

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ParkingDetails(
                                        parkingDetails:  parkingSpaces[a]),
                                  ),
                                );


                              }, btnColor: MyColors.primary6,buttonTextColor: MyColors.primary1,)),


                            ],
                          ),
                        )
                      ],
                    ),
                  );
            });

          }
        ));



    }
  }


//------------------------------------------------------------------------------
  Future<void> loadCustomImageLocation() async {
    ImageConverter imageConverter = ImageConverter();
    customMarkerLocation = await imageConverter.getBytesFromAsset(
      path: 'assets/images/locationicon.png',
      width: 400,height: 400 // minibus temporary customer marker custom marker
    );
    if (customMarkerLocation != null) {
      setState(() {});
    } // Trigger a rebuild to display the custom marker
  }

//location marker
  void addLocationMarkers(LatLng latLng) {

      _markers.add(Marker(
        markerId: MarkerId("Locationmarker"),
        position: latLng,
        icon: customMarkerLocation != null
            ? BitmapDescriptor.fromBytes(customMarkerLocation!)
            : BitmapDescriptor.defaultMarker,
      ));
     // print("the makrer is ------------${LatLng(listMarker[a].longitude,listMarker[a].latitude)}");

  }
double _distance =50;

//color for map 181926
  @override
  Widget build(BuildContext context) {
    final googleMapWidget = GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      markers: _markers  ,
      onMapCreated: (GoogleMapController controller) {
        _mapController?.complete(controller);
        mapController = controller;
        mapController?.setMapStyle(_mapStyle);
      },
      rotateGesturesEnabled: false,
      tiltGesturesEnabled: false,
      mapToolbarEnabled: false,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: true,
      padding: const EdgeInsets.only(top: 300),
    );
    return  Scaffold(
backgroundColor: MyColors.primary1,
      body:Stack(
        children: [

          googleMapWidget,

           Positioned(
            top: 0,
            right: 0,
            left: 0,

              child: Container(
                height: 150,
                padding: EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      MyColors.primary1,
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0, 2],
                  ),
                ),

                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: MyColors.grey_80
                            ),
                            child: const Padding(
                              padding:  EdgeInsets.all(8.0),
                              child: Icon(Icons.menu_rounded, color: MyColors.grey_20,),
                            )),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: MyColors.grey_80
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.asset("assets/images/avataricon.png", fit: BoxFit.cover, height: 35, width: 35,)),
                              SizedBox(width: 6,),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 3,),
                                  CustomText(text: "Welcome Back 👋", fontWeight: FontWeight.w500, fontSize: 10, textColor: MyColors.grey_40),
                                  CustomText(text: "Mandy Ronald", fontWeight: FontWeight.w500, fontSize: 12, textColor: MyColors.grey_20),
                                  SizedBox(height: 3,),
                                ],
                              ),

                              SizedBox(width: 16,),
                            ],
                          ),
                        )


                      ],
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: const CustomText(text: "Parking Space ", fontWeight: FontWeight.w400, fontSize: 30, textColor: MyColors.grey_10)),

                        Row(children: [
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: MyColors.grey_80
                              ),
                              child: const Padding(
                                padding:  EdgeInsets.all(8.0),
                                child: Icon(Icons.search, color: MyColors.grey_20,),
                              )),
                          SizedBox(width: 8,),
                          GestureDetector(
                            onTap: (){
                              showModalBottomSheet(
                                backgroundColor: MyColors.primarylight,
                                  context: context,
                                  builder: (BuildContext context){
                                    return  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 23,),
                                        Center(
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 3,
                                                width: 80,
                                                color: MyColors.grey_40,
                                              ),
                                              SizedBox(height: 14,),
                                              CustomText(text: "Filter", fontWeight: FontWeight.w600, fontSize: 22, textColor: MyColors.grey_20),
                                              SizedBox(height: 14,),
                                              Container(
                                                height: 2,

                                                color: MyColors.grey_40,
                                              ),

                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20,right: 20,bottom: 12,top: 16),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CustomText(text: "Distance", fontWeight: FontWeight.bold, fontSize: 19, textColor: MyColors.grey_20),

                                              StatefulBuilder(
                                                builder: (context,state) {
                                                  return Slider(value:  _distance,
                                                    //  min:0,
                                                     max:120,
                                                     label: _distance.round().toString()+" Km",
                                                      activeColor: MyColors.primary6,
                                                      inactiveColor: MyColors.grey_1,
                                                      thumbColor: MyColors.primary6,
                                                     divisions: 12,

                                                     onChanged: (value){
                                                       _distance=value;
                                                    state((){


                                                    });
                                                    setState(() {


                                                    });

                                                        });
                                                }
                                                                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  CustomText(text: "0.00km", fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.grey_40),
                                                  CustomText(text: "120km", fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.grey_40),

                                                ],
                                              ),
                                              SizedBox(height: 14,),
                                              CustomText(text: "Price", fontWeight: FontWeight.bold, fontSize: 19, textColor: MyColors.grey_20),
                                              StatefulBuilder(
                                                  builder: (context,state) {
                                                    return Slider(value:  _distance,
                                                       // min:0,
                                                        max:120,
                                                        label: "  "+ _distance.round().toString()+" Kr ",
                                                        activeColor: MyColors.primary6,
                                                        inactiveColor: MyColors.grey_1,
                                                        thumbColor: MyColors.primary6,
                                                        divisions: 18,

                                                        onChanged: (value){
                                                          _distance=value;
                                                          state((){


                                                          });
                                                          setState(() {


                                                          });

                                                        });
                                                  }
                                              ),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  CustomText(text: "2kr/hr", fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.grey_40),
                                                  CustomText(text: "50kr/hr", fontWeight: FontWeight.w600, fontSize: 16, textColor: MyColors.grey_40),

                                                ],
                                              ),
                                              SizedBox(height: 18,),

                                            ],
                                          ),
                                        ),

                                        Container(
                                          height: 2,

                                          color: MyColors.grey_40,
                                        ),
                                        SizedBox(height: 15,),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(

                                            children: [
                                              Expanded(
                                                child: CustomButton(buttonText: "Clear", onTap: (){
                                                }, buttonTextColor: MyColors.primary1,btnColor: Colors.white,),
                                              ),
                                              SizedBox(width: 7,),
                                              Expanded(
                                                child: CustomButton(buttonText: "Apply", onTap: (){
                                                  Navigator.pop(context);
                                                }, buttonTextColor: MyColors.primary1, btnColor: MyColors.primary6,),
                                              )
                                            ],
                                          ),
                                        ),




                                      ]
                                    );
                              });
                            }
                            ,
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: MyColors.grey_80
                                ),
                                child: const Padding(
                                  padding:  EdgeInsets.all(8.0),
                                  child: Icon(Icons.tune, color: MyColors.grey_20,),
                                )),
                          )
                        ],)
                      ],
                    ),
                  ],
                ),
              )),
          Positioned(
            bottom: 20,
            right: 20,
            child: ClipOval(
              child: Material(
                color: MyColors.primarylight, // button color
                child: InkWell(
                  splashColor: MyColors.primary6, // inkwell color
                  child: const SizedBox(
                    width: 56,
                    height: 56,
                    child: Icon(Icons.my_location_sharp, color: MyColors.grey_20,size: 19,),
                  ),
                  onTap: () async {

                    // Move camera to the specified latitude & longitude



                    CameraPosition cameraPosition = CameraPosition(
                      target: LatLng(_currentPosition!.latitude,
                          _currentPosition!.longitude),
                      zoom: 15,
                    );
                    final GoogleMapController? controller =
                    await _mapController?.future;
                    controller?.animateCamera(
                        CameraUpdate.newCameraPosition(cameraPosition));
                    setState(() {});

                    //
                    // on button tap
                  },
                ),
              ),
            ),
          ),

        ],
      )
    );
  }
}
