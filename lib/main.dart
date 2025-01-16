import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:parking/manageParking/parking_dashboard.dart';
import 'package:parking/misc/mycolors/mycolors.dart';
import 'package:parking/pages/drawerPages/About.dart';
import 'package:parking/pages/drawerPages/favorites_page.dart';
import 'package:parking/pages/drawerPages/privacy_policy.dart';
import 'package:parking/pages/homepage.dart';
import 'package:parking/payments/stripe/.env.publishablekey.dart';
import 'package:parking/provider/current_position.dart';
import 'package:parking/provider/parking_provider.dart';
import 'package:parking/provider/show_directions_provider.dart';
import 'package:parking/widgets/vehicle_info.dart';
import 'package:provider/provider.dart';

void main()  async{
 await  _setUp();
  runApp(const MyApp());

}

Future<void> _setUp() async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey=stripePublishableKey;
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return DistancePriceProvider();
        }),
        ChangeNotifierProvider(create: (context)=>CurrentPosition()),
        ChangeNotifierProvider(create: (context)=>ShowDirectionProvider()),
      ],
      child: MaterialApp(
        title: 'Parking Norway',
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: MyColors.primary1),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
        ),

       // home:  MyHomePage(),
        initialRoute: 'home',
        routes: {
          'home' : (context)=>MyHomePage(),
          'favorites' : (context)=>FavoritesPage(),
          'privacyPolicy' : (context)=>PrivacyPolicy(),
          'parkingDashboard' : (context)=>ParkingDashboard(),
          'About' : (context)=>About()
        }
      ),
    );
  }
}


