import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking/models/parking_model.dart';
import 'package:parking/permissions/location_permission.dart';
import 'package:parking/provider/current_position.dart';
import 'package:parking/provider/show_directions_provider.dart';
import 'package:parking/util/coordinates_to_Address.dart';
import 'package:parking/util/image_converter.dart';
import 'package:parking/widgets/custom_text.dart';
import 'package:provider/provider.dart';

import 'map/map_constants.dart';
import 'misc/mycolors/mycolors.dart';
import 'models/user_parking.dart';

class ShowDirections extends StatefulWidget {
  final UserParking? userParking;
  const ShowDirections({super.key, required this.userParking});

  @override
  State<ShowDirections> createState() => _ShowDirectionsState();
}

class _ShowDirectionsState extends State<ShowDirections> {
  GoogleMapController? mapController;
  String? _mapStyle;
  final Set<Marker> _markers=<Marker>{};
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(60.38879709499924, 5.3214410635398774),
    zoom: 16.4746,
  );
  Uint8List? customMarker;
  Uint8List? customMarkerLocation;
  String? destination;
  Parking ? parking ;

  //LatLng? latLen ;

  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  final Set<Polyline> _polyline = {};
  static const CameraPosition _kLake = CameraPosition(

      target: LatLng(60.381710239989346, 5.356133492059116),
      zoom: 16.151926040649414);

  @override
  void initState() {
    // TODO: implement initState
    context.read<CurrentPosition>().userCurrentPosition(context);
    super.initState();

    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });

    _initializeMap();

  }




  Future<void> _initializeMap() async {
   // await _getCurrentPosition();
    await loadCustomMarker();

   // addMarkers();
   // custommarker ();
    //_getPolyline();

  }

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


  void addLocationMarker(LatLng latLng){
    _markers.add(Marker(markerId: const MarkerId("currentLocation"), position: latLng,infoWindow: InfoWindow(title: "CurrentLocation"),
      icon: customMarkerLocation != null
          ? BitmapDescriptor.fromBytes(customMarkerLocation!)
          : BitmapDescriptor.defaultMarker,
    )

    );



  }

  Future<LatLng> custommarker (UserParking providerUserParking) async{
    UserParking? userParking = providerUserParking;
    parking = userParking?.bookedSpot?.parking;
    destination = parking?.location;
    AddressConverter addressConverter = AddressConverter();
    String location = await addressConverter.addressToCoordinatess(destination);
    List<String> locationCordinates =location.split(',');
    double latitude = double.parse(locationCordinates[0].trim());
    double longitude = double.parse(locationCordinates[1].trim());
    LatLng destinationCoordinates =LatLng(latitude, longitude);

    String? name = userParking?.bookedSpot?.parking?.name;



    _markers.add( Marker(markerId: MarkerId("customerMarker"), position: destinationCoordinates, infoWindow: InfoWindow(title: name),
      icon: customMarker != null
        ? BitmapDescriptor.fromBytes(customMarker!)
            : BitmapDescriptor.defaultMarker


    )) ;



    setState(() {

    });


     return destinationCoordinates;
  }

  Future<void> loadCustomMarker() async {
    ImageConverter imageConverter = ImageConverter();
    customMarker = await imageConverter.getBytesFromAsset(
      path: 'assets/images/parkingicon.png',
      width: 69, //  temporary customer marker custom marker
    );
    if (customMarker != null) {
      setState(() {});
    } // Trigger a rebuild to display the custom marker
  }


  _getPolyline(Position currentPosition, LatLng latLen) async {
    // List<LatLng> polylineCoordinates = [];
    polylineCoordinates.clear();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: MapConstants.apiKey,
      request: PolylineRequest(
        origin: PointLatLng(currentPosition!.latitude, currentPosition!.longitude),
        destination: PointLatLng(latLen!.latitude, latLen!.longitude),
        mode: TravelMode.driving,
      ),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    polylines.clear();
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: MyColors.primary6,
      points: polylineCoordinates,
      width: 4,
    );
    polylines[id] = polyline;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
   UserParking? user =context.watch<ShowDirectionProvider>().userParking;
    Position? _currentPosition = context.watch<CurrentPosition>().currentPosition;

     // print("here is the na,e now ----------------------_>>>>"+ user!);

    return   Scaffold(
      body: Stack(
        children: [
         GoogleMap(
                markers: _markers,
                mapType: MapType.normal,
                mapToolbarEnabled: false,
                polylines: Set<Polyline>.of(polylines.values),
              //  polylines: _polyline,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) async {
                  _controller.complete(controller);
                  mapController = controller;
                  mapController?.setMapStyle(_mapStyle);

                  if (_currentPosition != null)   {
                    CameraPosition cameraPosition = CameraPosition(
                      target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                      zoom: 16,
                    );
                    mapController?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));


                    await loadCustomImageLocation();
                    addLocationMarker(LatLng(_currentPosition!.latitude, _currentPosition!.longitude) );
                    LatLng latLen =await custommarker (user);
                    print("here is the latong--------------- now"+ latLen!.latitude.toString());
                   await  _getPolyline(_currentPosition, latLen);


                  }




                },
              ),



          Positioned(
            top: 50,
              left: 10,


              child: GestureDetector(
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
              ) ),

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




                    final GoogleMapController? controller =
                    await _controller?.future;
                    controller?.animateCamera(
                        CameraUpdate.newCameraPosition(_kLake));
                    setState(() {});

                    //
                    // on button tap
                  },
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(

                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: MyColors.primarylight
                  ),
                  
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          child: parking?.gallery?.first== null ?
                          Image.asset("assets/images/carpark.jpeg", width: 100,height: 100,fit: BoxFit.cover,):
                          Image.network(
                            parking?.gallery?[0].imageUrl??'',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                "assets/images/carpark.jpeg",
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        
                        
                        
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: destination ??"", fontWeight: FontWeight.bold, fontSize: 15, textColor: MyColors.grey_10),
                            CustomText(text: "${parking?.price}kr" ??"", fontWeight: FontWeight.w400, fontSize: 14, textColor: MyColors.grey_10),
                            CustomText(text: "3min (1.5 km)", fontWeight: FontWeight.w200, fontSize: 12, textColor: MyColors.grey_10)
                          ],
                        ),
                      ),
                      SizedBox(width: 10,),



                    ],
                  ),

                ),
              ))



        ],),
    );
  }
}
