
import 'package:flutter/material.dart';


import '../booking/my_bookings.dart';
import '../misc/mycolors/mycolors.dart';
import '../widgets/custom_text.dart';


class BookingConfirmationDialog extends StatefulWidget {

  BookingConfirmationDialog({Key? key}) : super(key: key);

  @override
  BookingConfirmationDialogState createState() => new BookingConfirmationDialogState();
}

class BookingConfirmationDialogState extends State<BookingConfirmationDialog>{

  @override
  Widget build(BuildContext context){
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(width: 160,
        child: Card(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(4),),
          color: Colors.white,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Wrap(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                width : double.infinity, color: MyColors.primary1,
                child: Column(
                  children: <Widget>[
                    Container(height: 10),
                    Icon(Icons.paid, color: MyColors.primary6, size: 80),
                    Container(height: 10),
                    const CustomText(text: "Successful!", fontWeight: FontWeight.bold, fontSize: 16, textColor: MyColors.grey_20),
                    Container(height: 10),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                width : double.infinity,
                child: Column(
                  children: <Widget>[
                    CustomText(text: "Payment for your parking has been successfully completed.", fontWeight: FontWeight.w400, fontSize: 16, textColor: MyColors.grey_60),
                    Container(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primary1, elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0)
                        ),
                      ),
                      child: Text("View Parking Ticket", style: TextStyle(color: Colors.white)),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyBooking(),
                          ),
                        );
                       // MyToast.show("Get Started clicked", context);
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primary6, elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0)
                        ),
                      ),
                      child: Text("Home", style: TextStyle(color: MyColors.primary1)),
                      onPressed: (){
                        Navigator.of(context).pop();
                        // MyToast.show("Get Started clicked", context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



