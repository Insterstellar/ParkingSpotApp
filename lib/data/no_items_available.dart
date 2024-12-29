
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../misc/mycolors/mycolors.dart';
import '../widgets/custom_text.dart';
import '../widgets/my_text.dart';

class NoItemsFoundPage extends StatelessWidget {
  const NoItemsFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: MyColors.primary1,

        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child:   Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: MyColors.primarylight0),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.arrow_back,
                                color: MyColors.grey_20,
                              ),
                            )),
                      ),
                      const CustomText(text: "Favorites", fontWeight: FontWeight.w500, fontSize: 20, textColor: MyColors.grey_20),
                     SizedBox(width: 8,)
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset('assets/images/bg_no_item_city.png', width: double.infinity),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 60),
                  width: 250,
                  child: Column(
                    children: <Widget>[
                      Text("No favorites here", style: MyText.title(context)!.copyWith(
                          color: MyColors.grey_60, fontWeight: FontWeight.bold
                      )),
                      Container(height: 5),
                      Text("Add your favorite parking spots from Parking List", textAlign: TextAlign.center, style: MyText.medium(context).copyWith(
                          color: MyColors.grey_40
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}

