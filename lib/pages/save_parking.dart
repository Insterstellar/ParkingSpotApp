import 'package:flutter/material.dart';
import 'package:parking/misc/mycolors/mycolors.dart';
import 'package:parking/models/Gallery.dart';
import 'package:parking/models/parking_model.dart';
import 'package:parking/pages/parking_details.dart';
import 'package:parking/repo/controller/parking_controller.dart';
import 'package:parking/repo/services/ParkingServices.dart';
import 'package:parking/widgets/custom_list.dart';
import 'package:parking/widgets/custom_text.dart';

class SaveParking extends StatefulWidget {
  const SaveParking({super.key});

  @override
  State<SaveParking> createState() => _SaveParkingState();
}

class _SaveParkingState extends State<SaveParking> {
  void hello(){
    print("hello world");
  }

  List<String> cars= [
  

"Central Park Garage"          ,
"Downtown Plaza Parking"       ,
"Riverside Parking Lot"        ,
"Sunset Boulevard Parking"     ,
"Market Street Parking Deck"   ,
"University Campus Parking"    ,
"City Center Parking"          ,
"Eastside Parking Complex"     ,
"Westfield Mall Parking"       ,
 "Harborview Parking"          ,
 "Airport Long-Term Parking"   ,
 "Metro Station Parking"       ,
 "Hilltop Parking Garage"      ,
 "Lakeside Parking Lot"        ,
 "Northgate Parking Facility"  ,
 "Library Square Parking"      ,
 "Stadium Parking Zone"        ,
 "Convention Center Parking"
  ];

  List<String> addresses =[


 "1 Fjordview Road, Bergen, Norway"        ,
 "25 Mountain Path, Bergen, Norway"        ,
 "10 Seaside Boulevard, Bergen, Norway"    ,
 "17 Harbor Street, Bergen, Norway"        ,
 "5 Viking Way, Bergen, Norway"            ,
 "8 Nordic Lane, Bergen, Norway"           ,
 "34 Glacier Avenue, Bergen, Norway"       ,
 "22 Aurora Drive, Bergen, Norway"         ,
 "19 Birch Grove, Bergen, Norway"          ,
  "11 Fisherman's Wharf, Bergen, Norway"   ,
  "30 Old Town Road, Bergen, Norway"       ,
  "28 Coastal Route, Bergen, Norway"       ,
  "14 Castle Hill, Bergen, Norway"         ,
  "7 Harborview Terrace, Bergen, Norway"   ,
  "3 Northern Lights Lane, Bergen, Norway" ,
  "6 Fjordland Street, Bergen, Norway"     ,
  "13 Maple Ridge, Bergen, Norway"         ,
  "20 Seafarer's Lane, Bergen, Norway"     ,
  ]     ;

  var  parkingController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    parkingController=ParkingController(ParkingServices());

  }

  List <bool> dd =[
    true,
  true
  ];

 // bool favoriteStatus= true;
  //void AddFavorite(){
  //  setState(() {
  //    favoriteStatus =false;
  //  });
  //}



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0,right: 16.0,top: 16.0,bottom: 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: MyColors.primarylight0
                  ),

                  child: Icon(Icons.menu_rounded)),
              CustomText(text: "Save Parking", fontWeight: FontWeight.w500, fontSize: 20, textColor: MyColors.grey_1),
              ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset("assets/images/carpark.jpeg", fit: BoxFit.cover, height: 50, width: 50,)),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: MyColors.primarylight0
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search,color: MyColors.grey_1,),
                      SizedBox(width: 5,),
                      CustomText(text: "Search parking", fontWeight: FontWeight.normal, fontSize: 14, textColor: MyColors.grey_1)
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12,),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: MyColors.primarylight0
                ),
                child: Icon(Icons.tune_outlined, color: MyColors.grey_3,),
              )
            ],
          ),
          SizedBox(height: 30,),
          FutureBuilder<List<Parking>>(
            future: parkingController.getAllParkingSpots(),
            builder: (context, snapshot) {
              return Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index){
                      print("the length is ----0000000000---"+snapshot.data!.length.toString());
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No data available'));
                      }
                      var parkingDetails = snapshot.data?[index];
                      List<Gallery>? imageUrl = parkingDetails?.gallery;
                      return CustomListWidget(parkingName: parkingDetails?.name ??"",address: parkingDetails?.location??"", onTap: (){
                        String? clickedItem= parkingDetails?.name;
                        print("the print index and car type is -------- : $clickedItem number is-- :$index") ;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ParkingDetails(parkingDetails: parkingDetails),
                          ),
                        );
                      }, price: parkingDetails?.price??"", distance: parkingDetails?.distance??"", imageUrl: imageUrl?[0].imageUrl??"",
                        addFavorite: () {
                          //AddFavorite();
                            setState(() {
                              if(dd[index]==true){
                                dd[index]=false;
                              } else{
                                dd[index]=true;
                              }

                            });


                        
                        }, isAdded:  dd[index],
                      );

                    }),
              );
            }
          ),

        ],
      ),
    );
  }
}
