import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parking/models/parking_model.dart';
import 'package:parking/models/user_parking.dart';
import 'package:parking/repo/controller/user_parking_controller.dart';
import 'package:parking/repo/services/user_parking_service.dart';

import '../misc/mycolors/mycolors.dart';
import '../models/Gallery.dart';
import '../widgets/custom_list.dart';
import '../widgets/custom_text.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  //var userParkingController;
  List<Parking> userFavoriteItems =[];
  var  userParkingController = UserParkingController(UserParkingService());
  List<Parking> filteredFavorites=[];
  int userId=2;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
         deleteUserFvorites(); 
  //


  }

  Future<void> deleteUserFvorites() async{
    var userParkingController = UserParkingController(UserParkingService());
     Future.delayed(const Duration(seconds: 1)) ;
    var  userNewFavoriteItems =await userParkingController.allFavorites(userId);
     userFavoriteItems = userNewFavoriteItems;
     setState(() {
       filteredFavorites=userFavoriteItems;
     });




  }

  void filterFovorites(String query){
    List<Parking> favoriteFilterItems=userFavoriteItems.where((element) => element
            .name
            .toString()
            .toLowerCase()
            .contains(query)).toList();

    setState(() {
      filteredFavorites=favoriteFilterItems;
    });

  }



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
              const CustomText(text: "Favorites", fontWeight: FontWeight.w500, fontSize: 20, textColor: MyColors.grey_1),
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
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: MyColors.primarylight0
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search,color: MyColors.grey_1,),
                      SizedBox(width: 5,),
                      Expanded(
                        child: TextField(
                          onChanged: (value){
                            filterFovorites(value);
                          },
                          decoration: const InputDecoration(
                            hintText: 'Search parking',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: MyColors.grey_1,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: MyColors.grey_1,
                          ),
                        ),
                      ),                    ],
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
          Expanded(
            child: ListView.builder(
              itemCount:filteredFavorites.length,
              itemBuilder: (context, index) {
                List<Gallery>? imageUrl = filteredFavorites[index].gallery;
                var favorites = filteredFavorites[index];


                return CustomListWidget(parkingName: favorites ?.name ??"",address: favorites ?.location??"", onTap: (){
                      //  String? clickedItem= parkingDetails?.name;
                       // print("the print index and car type is -------- : $clickedItem number is-- :$index") ;

                       /* Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ParkingDetails(parkingDetails: parkingDetails),
                          ),
                        );*/
                      }, price: favorites ?.price??"", distance: favorites ?.distance??"", imageUrl: imageUrl?[0].imageUrl??"",
                        addFavorite: () async {
                          //await userParkingController.
                      List<Parking> deletedFavorites = await userParkingController.deleteUserFavorite(userId, favorites.id!);
                      setState(() {
                        filteredFavorites=deletedFavorites;
                      });
                      for(Parking p in deletedFavorites){
                        print("-----------------favorite ha--------s been delete   : "+p.name.toString());
                      }
                          //AddFavorite();





                        }, isAdded:  false,deleteButton: true,
                      );
              }
            )


          ),

        ],
      ),
    );
  }
}
