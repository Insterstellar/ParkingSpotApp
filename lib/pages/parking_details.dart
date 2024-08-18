import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:parking/booking/mytetxwidget.dart';
import 'package:parking/misc/mycolors/mycolors.dart';
import 'package:parking/models/Amenities.dart';
import 'package:parking/models/Gallery.dart';
import 'package:parking/models/parking_model.dart';
import 'package:parking/pages/booking_page.dart';
import 'package:parking/repo/controller/parking_controller.dart';
import 'package:parking/repo/services/ParkingServices.dart';
import 'package:parking/widgets/custom_button.dart';
import 'package:parking/widgets/custom_text.dart';
import 'package:parking/widgets/review_list_widget.dart';

class ParkingDetails extends StatefulWidget {
  final Parking? parkingDetails;
   //const ParkingDetails({super.key, required this.parkingDetails});
  ParkingDetails({Key? key, required this.parkingDetails}) : super(key: key);

  @override
  State<ParkingDetails> createState() => _ParkingDetailsState();
}

class _ParkingDetailsState extends State<ParkingDetails> with TickerProviderStateMixin {


  List<String> carNames= [
    "Emergency services", "Security","Lighiting","CC Camera", "Near you","Washing bay","Small Cars", "Fence","Cheap"
  ];

  List<String> users
  =[
    "Alice Johnson"    ,
    "Benjamin Smith"   ,
    "Catherine Davis"  ,
    "David Wilson"     ,
    "Eleanor Martinez" ,
    "Francis Brown"    ,
    "Gabriella Jones"  ,
    "Henry Garcia"     ,
    "Isabella Miller"  ,
    "James Anderson"  ,
    "Katherine Thomas",
    "Liam Jackson"    ,
    "Megan White"     ,
    "Nathan Harris"   ,
    "Olivia Martin"   ,
    "Patrick Thompson",
    "Quinn Moore"     ,
    "Rebecca Taylor"
  ];

  Parking? parkingapots;
  List<Amenities>? amenities;
  List<Gallery>? galleries;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    parkingapots=widget.parkingDetails;
    amenityDetails ();

  }

  void amenityDetails (){
   amenities = parkingapots?.amenities;
   galleries = parkingapots?.gallery;
  }



  @override
  Widget build(BuildContext context) {

    TabController tabController=TabController(length: 3, vsync: this)  ;
    return Scaffold(
      backgroundColor: MyColors.primary1,
      body:Stack (
        children: [
          NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(1),
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: MyColors.primary1,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(35),topLeft: Radius.circular(35),),
                      ),
                    ),
                  ),
                  expandedHeight: 300.0,
                  backgroundColor: MyColors.primary1,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarBrightness: Brightness.dark,
                  ),


                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: galleries == null ?
                    Image.asset("assets/images/carpark.jpeg",fit: BoxFit.cover,):
                    Image.network(
                      galleries?[0].imageUrl??'',

                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/images/carpark.jpeg",
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back,color: Colors.white,),
                    onPressed: () {Navigator.pop(context); },
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.share,color: Colors.white), onPressed: () {},
                    ),// overflow menu
                    IconButton(
                      icon: Icon(Icons.bookmark_border, color: Colors.white,), onPressed: () {},
                    ),
                  ],
                ),
              ];
            },
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left:20 ,right:20,top: 6  ,bottom:25 ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: parkingapots?.name??"", fontWeight: FontWeight.w600, fontSize: 25, textColor: MyColors.grey_10),
                            CustomText(text: parkingapots?.location??"", fontWeight: FontWeight.w300, fontSize: 13, textColor: MyColors.grey_10),
                          ],
                        ),


                      ],
                    ),
                    SizedBox(height: 5,),
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                          color: MyColors.primarylight0,
                          borderRadius: BorderRadius.circular(50)),

                      child:  Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.local_taxi_sharp, color: MyColors.primary6,size: 14,),
                          ),
                          CustomText(text: "24 Slots", fontWeight: FontWeight.w900, fontSize: 12, textColor: MyColors.primary6),
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),


                    CustomText(text: "Amenities", fontWeight: FontWeight.w800, fontSize: 19, textColor: MyColors.grey_1),
                    SizedBox(height: 8,),
                    Wrap(
                      spacing: 8,
                      runSpacing: 5,
                      // alignment : WrapAlignment.start,
                      children: amenities!.map((tag) {
                        return Chip(
                          label:  CustomText(text: tag.name??"", fontWeight: FontWeight.w400, fontSize: 14, textColor: MyColors.grey_10),
                          labelStyle: TextStyle(color: Colors.white),
                          backgroundColor: MyColors.primarylight1,
                          labelPadding: EdgeInsets.symmetric(horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16), // Custom border radius
                            side: BorderSide(color: MyColors.primarylight1, width: 1), // Optional border
                          ),

                        );
                      }).toList(),
                    ),
                    SizedBox(height: 10,),
                    //tab bar
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
                            Tab(text: "About",),
                            Tab(text: "Gallery",),
                            Tab(text: "Reveiew",)
                          ]),
                    ),

                    Container(
                      padding: EdgeInsets.only(top: 16),
                      width: MediaQuery.of(context).size.width,
                      height: 400,
                      //color: Colors.blue,
                      child: TabBarView(
                          controller: tabController,
                          children: [
                            ListView(
                              children:[CustomText(text: parkingapots?.description ??"", fontWeight: FontWeight.w300, fontSize: 13, textColor: MyColors.grey_10),     //tab bar
                              ],),
                            GridView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: galleries?.length ?? 0,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                                itemBuilder: (context, index){
                                  return Padding(
                                    padding: EdgeInsets.all(8)  ,
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      child: galleries == null ?
                                      Image.asset("assets/images/carpark.jpeg", width: 50,height: 50,fit: BoxFit.cover,):
                                      Image.network(
                                        galleries?[index].imageUrl??'',
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


                                  ) ;

                                }),
                            ListView.builder(
                                itemCount: 18,
                                itemBuilder: (context, index) {
                                  return ReviewListWidget(usersnames: users[index],);
                                })

                            //


                          ]),
                    )

                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom:0,
              right: 16,
              left: 16,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(buttonText: "Schedule",onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BookingPage(parkingSpot:parkingapots ),
                            ),
                          );
                        
                        },
                            btnColor: MyColors.grey_5, buttonTextColor: MyColors.primary1),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomButton(buttonText: "Book Now",onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BookingPage(parkingSpot:parkingapots ),
                            ),
                          );
                        
                        },
                            btnColor: MyColors.primary6, buttonTextColor: MyColors.primary1),
                      ),
                    ],
                  ),
                  SizedBox(height: 16,)

                ],
              )
          )
        ],
      )






    );
  }
}
