import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking/provider/current_position.dart';
import 'package:parking/provider/parking_provider.dart';
import 'package:parking/widgets/custom_button.dart';
import 'package:parking/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class OLD extends StatefulWidget {
  OLD({super.key});

  @override
  State<OLD> createState() => _OLDState();
}

class _OLDState extends State<OLD> {


  int a =0;
  double? l ;
  CurrentPosition currentPosition = CurrentPosition();
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
   context.read<CurrentPosition>().userCurrentPosition(context);
    //currentPosition.userCurrentPosition(context);




  }


  @override
  Widget build(BuildContext context) {

    l =context.watch<CurrentPosition>().currentPosition?.latitude;
    double? d =context.watch<CurrentPosition>().currentPosition?.longitude;

    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(text: l.toString(), fontWeight: FontWeight.bold, fontSize: 15, textColor: Colors.black),
            CustomText(text: d.toString(), fontWeight: FontWeight.bold, fontSize: 15, textColor: Colors.black),

            CustomText(text: context.watch<DistancePriceProvider>().count.toString(), fontWeight: FontWeight.bold, fontSize: 29, textColor: Colors.black),

            CustomButton(buttonText: "Add", onTap: (){
              context.read<DistancePriceProvider>().increment();

            }),

            SizedBox(
              height: 15,
            ),

            CustomButton(buttonText: "subtract", onTap: (){
              context.read<DistancePriceProvider>().dincrement();

            })
          ],
        ),
      ),
    );
  }
}
