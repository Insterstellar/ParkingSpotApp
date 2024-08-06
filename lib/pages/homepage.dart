import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking/misc/mycolors/mycolors.dart';
import 'package:parking/pages/MainPage.dart';
import 'package:parking/pages/booking_page.dart';
import 'package:parking/pages/parking_details.dart';
import 'package:parking/pages/payment_page.dart';
import 'package:parking/pages/save_parking.dart';
import 'package:parking/widgets/custom_button.dart';
import 'package:parking/widgets/custom_list.dart';
import 'package:parking/widgets/custom_text.dart';

import 'favorites_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex =0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _pages=[
    MainPage(),
     SaveParking(),
   // BookingPage(),
   FavoritesPage()
   // PaymentPage(),
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
         currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,

          type: BottomNavigationBarType.shifting,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
              backgroundColor: MyColors.primarylight0,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_parking),
              label: 'Save Parking',
              backgroundColor: MyColors.primarylight0,
            ),
           /* BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined),
              label: 'Booking',
              backgroundColor: MyColors.primarylight0,
            ),*/

            BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined),
              label: 'Payment',
              backgroundColor: MyColors.primarylight0,
            ),


          ],
        ),

      body:   SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
      )
    );
  }
}
