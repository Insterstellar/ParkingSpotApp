import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking/booking/my_bookings.dart';
import 'package:parking/misc/mycolors/mycolors.dart';
import 'package:parking/pages/MainMapPage.dart';
import 'package:parking/pages/select_parking_spots.dart';
import 'package:parking/pages/parking_details.dart';
import 'package:parking/pages/payment_page.dart';
import 'package:parking/pages/parking_places.dart';
import 'package:parking/widgets/custom_button.dart';
import 'package:parking/widgets/custom_list.dart';
import 'package:parking/widgets/custom_text.dart';

import '../data/no_items_available.dart';
import '../widgets/drawer_widget.dart';
import 'drawerPages/favorites_page.dart';
final GlobalKey<_MyHomePageState> bottomNavigationKey = GlobalKey();
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: bottomNavigationKey); // Assign GlobalKey here

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  int selectedIndexPage =0 ;
  int?  drawerIndex;

  void onItemTapped(int index) async {
    setState(() {
      selectedIndexPage = index;


     // drawerKey.currentState?.onTappedDrawerItem(null);


    });


  }




  List<Widget> _pages=[
   MainPage(),
     SaveParking(),
   //BookingPage(),
  MyBooking(),
    PaymentPage(),
    NoItemsFoundPage(),

   // ParkingDetails()
  ];






  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: MyColors.primary1,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: MyColors.primary6,
         // backgroundColor: MyColors.primarylight,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          elevation: 0,
         currentIndex: selectedIndexPage, //New
          onTap: onItemTapped,

          type: BottomNavigationBarType.shifting,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
              backgroundColor: MyColors.primarylight0,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_parking),
              label: 'Parking',
              backgroundColor: MyColors.primarylight0,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined),
              label: 'Booking',
              backgroundColor: MyColors.primarylight0,
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: MyColors.primarylight0,
            ),


          ],
        ),



      body:   SafeArea(
        child: IndexedStack (
          index:  selectedIndexPage ,
          children:  _pages,  // drawer pages to be implemented here also
        ),
      )
    );
  }
}
