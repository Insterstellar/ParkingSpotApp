import 'dart:async';
import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parking/data/resource_data.dart';
import 'package:parking/dialog/_show_options.dart';
import 'package:parking/map/select_address_map.dart';
import 'package:parking/misc/mycolors/mycolors.dart';
import 'package:parking/repo/services/ParkingServices.dart';
import 'package:parking/util/coordinates_to_Address.dart';
import 'package:parking/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../repo/controller/parking_controller.dart';
import '../widgets/my_text.dart';

class AddParking extends StatefulWidget {
  const AddParking({super.key});

  @override
  State<AddParking> createState() => _AddParkingState();
}

class _AddParkingState extends State<AddParking> {
  List<String> categoryText = ResourceData.parkingAmenities;
  List<int> parkingAmenitiesIndex = List.generate(ResourceData.parkingAmenities.length, (index) => index);
  List<RxBool> categoryFlag = List.generate(ResourceData.parkingAmenities.length, (index) => false.obs);
  List<RxBool> outlineFlag = List.generate(ResourceData.parkingAmenities.length, (index) => false.obs);

  StreamController<LatLng> parkingStreamController = StreamController<LatLng>.broadcast();
  StreamSink<LatLng> get sinkParkingCoordinates =>parkingStreamController.sink;
  Stream<LatLng> get streamParkingCoordinates => parkingStreamController.stream;

  List<XFile> ?_image;

  final picker = ImagePicker();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationAddress();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    parkingStreamController.close();
    super.dispose();
  }

  String? _location;

   void getLocationAddress(){
    streamParkingCoordinates.listen((event) async {
      LatLng latLng =event;
      if(latLng!=null){
        List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
        var first = placemarks.first;
        setState(() {
          _location = "${first.street}, ${first.postalCode} ${first.subAdministrativeArea}";

        });

      }
    });
   }



  Future getImageFromGallery() async {

     try{
       List<XFile> pickedFile = await picker.pickMultiImage(limit: 2);

       setState(() {
         if (pickedFile != null) {
          _image= pickedFile;
         }
       });
     } catch (e){
       print("------------"+e.toString());
     }

  }


  Future getImageFromCamera() async {

    try{
      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      setState(() {
        if (pickedFile != null) {
         // _image=pickedFile;
        //  _image = File(pickedFile.path);
        //  print("image pass is---------"+_image!.path.toString());
        }
      });
    } catch (e){
      print("------------"+e.toString());
    }

  }


  var controller =ParkingController(ParkingServices());





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary1,
      appBar: AppBar(
        backgroundColor: MyColors.primary1,
        title: CustomText(textColor: MyColors.grey_20,fontSize: 13,text: "Add Parking",fontWeight: FontWeight.w400,),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios, color: MyColors.grey_20)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        scrollDirection: Axis.vertical,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(height: 5),
                Container( height: 45,
                  decoration: BoxDecoration(
                      color:MyColors.grey_90, borderRadius: BorderRadius.all(Radius.circular(4))
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(maxLines: 1,
                    controller: new TextEditingController(),
                    style: TextStyle(color: MyColors.grey_20),
                      //focusNode: focusNode,
                      autofocus:true,

                    decoration: InputDecoration(
                      fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(-12), border: InputBorder.none,
                        hintText: "Parking Name", hintStyle: MyText.body1(context)!.copyWith(color: MyColors.grey_40)
                    ),
                  ),
                ),

                Container(height: 15),
                 ElevatedButton(
                 style: ElevatedButton.styleFrom(backgroundColor: MyColors.grey_90, padding: EdgeInsets.symmetric(horizontal: 10),elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)) ),
             
                   onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectMapAddress(sinkParkingCoordinates: sinkParkingCoordinates,)));

                   }, child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,

                   children: [

                      CustomText(text:  _location ?? "Select Address", fontWeight: FontWeight.w400, fontSize: 16, textColor: MyColors.grey_40),




                     Icon(Icons.map, color: MyColors.grey_40)    
                   ],
                 ) ),





                Container(height: 15),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text("Amenities", style: MyText.subhead(context)!.copyWith(color: MyColors.grey_40, fontWeight: FontWeight.w500)),
                ),
                Container(height: 15),

                Wrap(
                  spacing: 8, runSpacing: 5,
                  children: parkingAmenitiesIndex.map((int index) => Obx(() =>
                      ChoiceChip(
                          selected: categoryFlag[index].value,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),

                          label: Text(categoryText[index]),
                          //labelPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelStyle: TextStyle(color: categoryFlag[index].value ? MyColors.primary1 : MyColors.primary6),
                          backgroundColor: MyColors.primary1, pressElevation: 1,
                          selectedColor: MyColors.primary6,
                          onSelected: (bool selected) {
                            print(categoryFlag[index].value = selected);
                            print("is ... :"+categoryText[index]);
                          }
                      )
                  )).toList(),
                ),

                Container(height: 15),


                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                            color: MyColors.grey_90, borderRadius: BorderRadius.all(Radius.circular(4))
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: TextField(maxLines: 1,
                          controller: new TextEditingController(),
                          style: TextStyle(color: MyColors.grey_20),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(-12), border: InputBorder.none,
                              hintText: "Price", hintStyle: MyText.body1(context)!.copyWith(color: MyColors.grey_40)
                          ),
                        ),
                      ),
                    ),
                   Container(width: 15),
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                            color: MyColors.grey_90, borderRadius: BorderRadius.all(Radius.circular(4))
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: TextField(maxLines: 1,
                          controller: new TextEditingController(),
                          style: TextStyle(color: MyColors.grey_20),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(-12), border: InputBorder.none,
                              hintText: "Number of spots", hintStyle: MyText.body1(context)!.copyWith(color: MyColors.grey_40)
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Container(height: 15),



                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                          decoration: BoxDecoration(
                              color: MyColors.grey_90, borderRadius: BorderRadius.all(Radius.circular(4))
                          ),
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                          child: TextField(maxLines: 4, minLines: 3, keyboardType: TextInputType.multiline,
                            controller: new TextEditingController(),
                            style: TextStyle(color: MyColors.grey_20),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(-12), border: InputBorder.none,
                                hintText: "Parking description", hintStyle: MyText.body1(context)!.copyWith(color: MyColors.grey_40)
                            ),
                          )
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: MyColors.primarylight,

                        ),child: IconButton(onPressed: () async {


                        ShowPopUp showPop = ShowPopUp();
                        await showPop.showOptions(context, () async {

                          Navigator.pop(context);
                          getImageFromGallery();

                        },() {
                          print("camera");

                          Navigator.pop(context);
                          getImageFromCamera();
                        },);


                      }, icon: Icon(Icons.image_rounded, size: 78, color: MyColors.grey_10)),


                      ),
                    ),
                  ],
                ),
                Container(height: 15),

                Container(
                  width: double.infinity, height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: MyColors.primary6, elevation: 0),
                    child: Text("Add", style: MyText.subhead(context)!.copyWith(color: MyColors.primary1)),
                    onPressed: () async {
                      LatLng latLng = const LatLng(60.385930637065464, 5.332203274448521);
                     final parkingSpots = await controller.getPublicSpots(latLng);
                     //check presence of the fetched data
                      for (var spot in parkingSpots) {
                        print('Name: ${spot['name']}');
                        print('Address: ${spot['address']}');
                        print('Location: ${spot['lat']}');
                        print('Location: ${spot['lng']}');
                        print('---');
                      }
                      
                      
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
